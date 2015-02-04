<?php
require_once ("../Model/UserModel.php");
require_once ("../Model/GroupModel.php");
require_once ("Controller_Action.php");
require_once("../Tools/CommUtil.php");
require_once("../Model/ParaModel.php");
class UserController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
	}

	function manageAction() {
		if (isset($_POST["doRegister"])){$this->redirect('User','register');}//登録画面へ
		
		$userModel = UserModel::getInstant();
		$where='';
		if (isset($_POST["btn_search_id"])&& strlen(trim($_POST["serarch_user_id"]))>0)
		{
			$where=" where user.user_id = '".$_POST["serarch_user_id"]."'";
		}
		else if (isset($_POST["btn_search_group"])&& $_POST["gpLst"]!=-1)
		{
			$where=" where user.group_id = ".$_POST["gpLst"];
		}

		$page = 1;
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		//$linePerPage = $_POST['pageCount']; 保留
		$recordCount = $userModel->getRecordCount($where);
		$maxpage = (int)($recordCount / $linePerPage);
		if (intval($recordCount % $linePerPage) != 0) {$maxpage ++;}
		$this->formBean[URL_LIST] = $this->makePageUrlLst($maxpage,$page,'User','manage');
		$this->formBean[MAX_PAGE] = $maxpage;
		$this->formBean[NOW_PAGE] = $page;
		$this->formBean[TOP_PAGE] = $maxpage+1;//先頭へ
		$this->formBean[PREV_PAGE] = $maxpage+2;//前へ
		$this->formBean[NEXT_PAGE] = $maxpage+3;//次へ
		$this->formBean[LAST_PAGE] = $maxpage+4;//最後へ 
		//-----------------ページコントロール↑-----------------

		$this->formBean["data"]=$userModel->select($where,$page);
		if (count($this->formBean["data"])>0)
		{
			$i=0;
			foreach ($this->formBean["data"] as $row)
			{
				$url=$this->getUrl("User","changeinfo").'&id='.$row['id'];
				$this->formBean["data"][$i]['detail_link']=$url;
				$i++;
			}
		}
		
		$this->formBean["gpLst"]['-1']="全体";
		$gplist=GroupModel::getInstant()->getGpLst();
		foreach ( $gplist as $gp_id=>$gp_name)
		{
			$this->formBean["gpLst"][$gp_id]=$gp_name;
		}
		$this->formBean['group_id']=isset($_POST["gpLst"])?$_POST["gpLst"]:-1;
		$this->formBean["register"]=$this->getUrl("User","register") ;
	}

	private function checkRegInput($isCheckReg)
	{
		if($_POST["user_id"]=="") {return "ユーザＩＤを入力してください。";}
		if($_POST["name"]=="") {return "名前を入力してください。";}
		if($_POST["password"]=="") {return "パスワードを入力してください。";}
		if(strlen($_POST["password"])!=4){return "パスワードは４桁入力してください。";}
		if(!is_numeric($_POST["password"])){return "パスワードは半角数字を入力してください。";}
		if(isset($_POST["email"]) && !CommUtil::mail_check($_POST["email"]))
		{
			return "メールアドレスが不正です。"; 
		}
		if ($isCheckReg)
		{
			if (!UserModel::getInstant()->checkRegister($_POST["user_id"]))
			{
				return "入力されたユーザＩＤは、すでに使用されています。";
			}
		}
		return "";
	}

	function registerAction() {
		$userModel = UserModel::getInstant();
		$this->formBean["user_id"]=$userModel->getAutoID();
		$info="";
		if (isset($_POST["doRegister"]))//登録ボタン
		{
			$info=$this->checkRegInput(true);
			if ($info=="")//エラーなし、追加する
			{
				if ($userModel->register($this->makeUpdateArray(false)))
				{
					$this->redirect("User","manage");//登録成功だったら、ユーザ管理へ
				}
				else
				{
					$info="ユーザ登録失敗しました";
				}
			}
		    $this->putInfoToViewBean($_POST);
		}
		$this->formBean["gpLst"]=GroupModel::getInstant()->getGpLst();
		$this->formBean["isDocomo"]=false;//サイトで新規のはドコモ以外しかない
		$this->formBean["info"]=$info;
	}

	
	private function makeUpdateArray($isUpdate)
	{
		$result= array ('user_id' => $_POST ['user_id'],
    			'name' => $_POST ['name'], 'password' => $_POST ['password'],
				'email' => (isset($_POST ['email'])?$_POST ['email']:''), 'sendway' => $_POST ['sendway'],
		        'group_id' =>$_POST ['gpLst'], 'authority' => $_POST['authority']
		);
		if ($isUpdate) {$result['id']=$_POST ['id'];}
		return $result;
	}

	private function putInfoToViewBean($info)
	{
		$this->formBean["id"]=$info['id'];
		$this->formBean["user_id"]=$info ['user_id'];
		$this->formBean["name"]=$info ['name'];
		$this->formBean["sendway"]=$info ['sendway'];
		$this->formBean["password"]=$info ['password'];
		$this->formBean["email"]=$info ['email'];
		$this->formBean["group_id"]=$info ['group_id'];
		$this->formBean["authority"]=$info ['authority'];
		$this->formBean["gpLst"]=GroupModel::getInstant()->getGpLst();
		$this->formBean["isDocomo"]=($info ['sendway']==2 || $info ['sendway']==1);//docomoユーザ判定
	}

	function changeinfoAction() {
		$err="";
		$userModel=UserModel::getInstant();
		if (isset($_POST["btn_update_user"]))
		{
			$err=$this->checkRegInput(false);
			if ($err!="")//入力チェックエラー、再表示
			{
				$this->putInfoToViewBean($_POST);
				$this->formBean["err"]=$err;
				return;
			}
			if (!$userModel->update($this->makeUpdateArray(true)))//エラーなし、変更する 
			{
				$this->putInfoToViewBean($_POST);
				$this->formBean["err"]="更新失敗しました";
				return;
			}
			$this->redirect('User', 'manage');
		}
		else if(isset($_POST["btn_del_user"]))
		{
			if ($_POST ['sendway']==2 || $_POST ['sendway']==1)//docomo ユーザ　マイボックス削除」
			{
				$result=SendUtil::DelMyboxUser($_POST["user_id"]);
				CommUtil::Get_log("マイボックス削除\tユーザコード：".$_POST["user_id"]."\t".($return == "00"?"OK":"NG").$return);
				if ($result!="00")
				{
					$this->putInfoToViewBean($_POST);
					$this->formBean["err"]="マイボックス情報削除失敗しました";
					return;
				}
			}
			if(!$userModel->release_user($_POST["user_id"]))
			{
				$this->putInfoToViewBean($_POST);
				$this->formBean["err"]= "ユーザ情報削除失敗しました。";
				return;
			}
			$this->redirect('User', 'delend');
		}
		$this->putInfoToViewBean($userModel->getRecord($_REQUEST["id"]));
	}
	
   function delendAction() {
		if (isset($_POST ['btn_ok'])){ $this->redirect("User","manage");}
	}
}
?>