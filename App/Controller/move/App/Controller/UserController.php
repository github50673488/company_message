<?php
require_once ("../Model/UserModel.php");
require_once ("Controller_Action.php");
require_once ("../Model/MyBoxInfoModel.php");
require_once ("../Model/SendHistoryModel.php");
require_once ("../Model/GroupModel.php");
require_once("../Model/ParaModel.php");
require_once("../Tools/CommUtil.php");
require_once("../Tools/SendUtil.php");
class UserController extends Controller_Action
{
	public function init() {
	   session_start();
	}
	function registerAction()
	{
		session_start();
		$inf="";
		$isDocomo=CommUtil::agent_check()==1;
		$userModel = UserModel::getInstant();
		$this->formBean["user_id"]=$userModel->getAutoID();
		if (!$isDocomo&&isset($_GET["email"])) {$this->formBean["email"]=$_GET["email"];}
		if (isset($_POST["doRegister"]))//登録ボタン
		{
			$inf=$this->checkRegInput(true,!$isDocomo);
			if ($inf=="")
			{
				$userModel->w_del($_POST["user_id"]);
				if($userModel->w_register($this->makeUpdateArray(false)))//仮ユーザテーブル登録
				{
					$this->forward("User","regconfirm");//⇒regconfirmAction
					return;
				}
				else
				{
					$inf="登録失敗しました。";
				}
			}
			else//入力チェックエラー、再表示
			{
				$this->putInfoToViewBean($_POST);
			}
		}
		$this->formBean["gpLst"]=GroupModel::getInstant()->getGpLst();
		$this->formBean['group_id']=isset($_POST["gpLst"])?$_POST["gpLst"]:-1;
		$this->formBean["isDocomo"]=$isDocomo;
		$this->formBean["info"]=$inf;
	}
	function regconfirmAction()
	{
		//===>registerActionから
		$isDocomo=CommUtil::agent_check()==1;
		$to_regend=$this->getUrl("User","regend")."&user_id=".$_POST["user_id"];
		$this->formBean["to_reglink"]=$isDocomo?"http://docomo.ne.jp/mb/regmyboxst":$to_regend;
		$this->formBean["isDocomo"]=$isDocomo;
		$this->putInfoToViewBean($_POST);
		$this->formBean["sendway_str"]=CommUtil::getSendWayStr($this->formBean['sendway']);
		$this->formBean["group_name"]=GroupModel::getInstant()->getGroupName($_POST["gpLst"]);
		$this->formBean["mybox_no"]=ParaModel::getInstant()->get_para_value("mybox_no");
		$this->formBean["to_regend"]="http://dcm2.dmpw.jp/info/App/Controller/move/App/Controller/default.php?ctl=User&action=regend&user_id=".$_POST["user_id"];
	}

	function regendAction()
	{
		if (CommUtil::agent_check()==1)
		{
			$myboxinfo= MyBoxInfoModel::getInstant()->getMyBoxInfo($_GET["user_id"]);
			if (!isset($myboxinfo))
			{
				$inf="マイボックス情報が取得できません。";
			}
			else
			{
				$result=SendUtil::AddMyboxUser($myboxinfo["eid"], $myboxinfo["tmpdate"], $myboxinfo["crypt"], $myboxinfo["user_id"]);
				CommUtil::Get_log("マイボックス登録\tユーザコード：".$myboxinfo["user_id"]."\t".($result == "00"?"OK":"NG").$result);
				if($result=="00")
				{
					MyBoxInfoModel::getInstant()->del($_REQUEST["user_id"]);
					$inf=$this->realRegister($_REQUEST["user_id"]);
				}
				else
				{
					$inf="マイボックス登録ができません。";
				}
			}
		}
		else
		{
			$inf=$this->realRegister($_REQUEST["user_id"]);
		}
		$this->formBean["info"]=$inf;
		session_start();
		$_SESSION["user_id"] = $_REQUEST["user_id"];//セッションに保存
		$this->formBean["to_menu"]=$this->getUrl("Main","main_menu")."&user_id=".$_REQUEST["user_id"];
	}

	private function realRegister($user_id)
	{
		$result="登録完了しました。";
		$userModel = UserModel::getInstant();
		if($userModel->register_from_w($user_id))//仮ユーザテーブル登録
		{
			$userModel->w_del($_REQUEST["user_id"]);
		}
		else
		{
			$result= "登録失敗しました。";
		}
		return $result;
	}




	private function checkRegInput($isCheckReg,$isCheckMail)
	{
		if($_POST["user_id"]=="") {return "ユーザＩＤを入力してください。";}
		if($_POST["name"]=="") {return "名前を入力してください。";}
		if($_POST["password"]=="") {return "パスワードを入力してください。";}
		if(strlen($_POST["password"])!=4){return "パスワードは４桁入力してください。";}
		if(!is_numeric($_POST["password"])){return "パスワードは半角数字を入力してください。";}
		if(($isCheckMail||(isset($_POST["email"])&&strlen(trim($_POST["email"])>0)))&& !CommUtil::mail_check($_POST["email"]))
		{
			return "メールアドレスが不正です。"; 
		}
		if ($isCheckReg&&!UserModel::getInstant()->checkRegister($_POST["user_id"]))
		{
			return "入力されたユーザＩＤは、すでに使用されています。";
		}
		return "";
	}

	private function putInfoToViewBean($info)
	{
		$this->formBean["id"]=$info['id'];
		$this->formBean["user_id"]=$info ['user_id'];
		$this->formBean["name"]=$info ['name'];
		$this->formBean["sendway"]=$info ['sendway'];
		$this->formBean["password"]=$info ['password'];
		$this->formBean["email"]=isset($info["email"])?$info ['email']:'';
	}

	

	private function makeUpdateArray($isUpdate)
	{
		$result= array ('user_id' => $_POST ['user_id'],
    			'name' => $_POST ['name'], 'password' => $_POST ['password'],
				'email' => isset($_POST["email"])?$_POST ['email']:'', 'sendway' => $_POST ['sendway'],
		        'group_id'=>$_POST ['gpLst'], 'authority' => 1 //まず権限を普通をする
		);
		if ($isUpdate) {$result['id']=$_POST ['id'];}
		return $result;
	}
	
//	private function del_user($userModel,$user_id)
//	{
//		$info="";
//		$rusult=false;
//		if($userModel->delByUserID($user_id))
//		{
//			$rusult=SendHistoryModel::getInstant()->delByUserID($user_id);
//		}
//		if ($rusult)
//		{
//			$this->freeRedirect($this->getUrl("User","delend"));
//			return "";
//		}
//		else
//		{
//			$info= "ユーザ削除失敗しました。";
//		}
//		return	$info;
//	}
	
//	function changeinfoAction() {
//		session_start();
//		$inf="";
//		$isDocomo=CommUtil::agent_check()==1;
//		$userModel=UserModel::getInstant();
//		if (isset($_POST["btn_update_user"]))//情報変更
//		{
//			$inf=$this->checkRegInput(false,!$isDocomo);
//			if ($inf=="")//エラーなし、更新する
//			{
//				$userModel->update($this->makeUpdateArray(true));//更新
//				$inf="ユーザ情報更新しました";
//				$this->putInfoToViewBean($userModel->getRecordByUID($_SESSION["user_id"]));
//			}
//			else//入力チェックエラー、再表示
//			{
//				$this->putInfoToViewBean($_POST);
//			}
//		}
//		elseif (isset($_POST["btn_del_user"]))//配信情報解除
//		{
//			if ($isDocomo)
//			{
//				$result=SendUtil::DelMyboxUser($_POST["user_id"]);
//				CommUtil::Get_log("マイボックス削除\tユーザコード：".$_POST["user_id"]."\t".($return == "00"?"OK":"NG").$return);
//				if ($result=="00")
//				{
//					$inf=$this->del_user($userModel,$_POST["user_id"]);
//					if ($inf==""){return;}
//				}
//				else
//				{
//					$inf="マイボックス情報削除失敗しました";
//				}
//			}
//			else
//			{
//				$inf=$this->del_user($userModel,$_POST["user_id"]);
//				if ($inf==""){return;}
//			}
//			$this->putInfoToViewBean($_POST);
//		}
//		else
//		{
//			$this->putInfoToViewBean(UserModel::getInstant()->getRecordByUID($_SESSION["user_id"]));
//		}
//
//		$this->loadPattern();
//		$this->formBean["info"]=CommUtil::Sethtml_error($inf);
//		$this->formBean["to_changeinfo"]=$this->getUrl('User','changeinfo');
//		$this->formBean["isDocomo"]=$isDocomo;
//		$this->formBean["go_back"]=$this->getUrl("Main","main_menu")."&user_id=".$_SESSION["user_id"];
//	}

	
//	function delendAction()
//	{
//		$this->formBean['info']="登録解除完了しました";
//
//		$isDocomo=CommUtil::agent_check()==1;
//		if($isDocomo){
//			$this->formBean['to_login'] = $this->getUrl("Login","login")."&key=mybox";
//		}
//		else{
//			$this->formBean['to_login']= $this->getUrl("Login","login");
//		}
//	}
	
	
//	function checkAction()
//	{
//		session_start();
//		$err="";
//		$pass="";
//		if (isset($_POST["btn_check_user"]))
//		{
//			$pass=$_POST["password"];
//			if (UserModel::getInstant()->checkPass($_SESSION["user_id"],$pass))
//			{
//				$this->redirect("User","changeinfo");
//			}
//			$err="パスワードを確認してください";
//		}
//		$this->formBean["err"]=$err;
//		$this->formBean["password"]=$pass;
//		$this->formBean["go_back"]=$this->getUrl("Main","main_menu")."&user_id=".$_SESSION["user_id"];
//	}
	
	
	
}
?>