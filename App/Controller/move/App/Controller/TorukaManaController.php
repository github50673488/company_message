<?php
require_once("Controller_Action.php");
require_once ("../Model/TorukaModel.php");
require_once ("../Model/UserModel.php");
require_once("../Model/ParaModel.php");
class TorukaManaController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
		$this->formBean["to_mana"]=$this->getUrl('TorukaMana','manage');//
		session_start();//session使用
		var_dump($_SESSION);
		var_dump($_REQUEST);
	}

	function manageAction() 
	{
		$torukaModel = TorukaModel::getInstant();
		$where='';
	    if (isset($_POST["t_makemessage"]))
		{
			$_POST["file_kind_name"]=$_POST["kind"]==1?"iトルカ":"トルカ";
			$_POST["file_kind"]="1";
			$this->forward('SendMessage', 'send');
			return;
		}

		//-----------------リスト　表示,ページコントロール↓-----------------
		$page = 1;
		$where=" where  create_user ='".$_SESSION["user_id"]."'";//作成者のだけ
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");;
		//$linePerPage = $_POST['pageCount']; 保留
		$recordCount = $torukaModel->getRecordCount($where);
		$maxpage = (int)($recordCount / $linePerPage);
		if (intval($recordCount % $linePerPage) != 0) {$maxpage ++;}
		$this->formBean[URL_LIST] = $this->makePageUrlLst($maxpage,$page,'TorukaMana','manage');
		$this->formBean[MAX_PAGE] = $maxpage;
		$this->formBean[NOW_PAGE] = $page;
		$this->formBean[TOP_PAGE] = $maxpage+1;//先頭へ
		$this->formBean[PREV_PAGE] = $maxpage+2;//前へ
		$this->formBean[NEXT_PAGE] = $maxpage+3;//次へ
		$this->formBean[LAST_PAGE] = $maxpage+4;//最後へ 
		//-----------------ページコントロール↑-----------------
		
		$this->formBean["data"]=$torukaModel->select($where,$page);
		if (count($this->formBean["data"])>0)
		{
			$i=0;
			foreach ($this->formBean["data"] as $row)
			{
				$url=$this->getUrl("TorukaMana","detail").'&id='.$row['id'];
				$this->formBean["data"][$i]['detail_link']=$url;
				$i++;
			}
		}
		$this->formBean["to_edit"]=$this->getUrl('TorukaMana','edit');
	}

	function detailAction() 
	{
		if (isset($_POST["btn_del"]))
		{
			TorukaModel::getInstant()->del($_POST["id"]);
			$this->redirect('TorukaMana','manage');
		}
		elseif (isset($_POST["btn_edit"]))
		{
			$this->freeRedirect($this->getUrl("TorukaMana","edit")."&id=".$_POST["id"]);
		}
		$this->loadInfoToView();
	}
	
	private function loadInfoToView()
	{
		if (!isset($_REQUEST["id"]) || $_REQUEST["id"]<0){return;}
		$torukaInfo= TorukaModel::getInstant()->getTorukaInfo($_REQUEST["id"]);
		$this->formBean["id"]=$torukaInfo["id"];
		$this->formBean["title"]=$torukaInfo["title"];
		$this->formBean["kind"]=$torukaInfo["kind"];
		$this->formBean["title"]=$torukaInfo["title"];
		$this->formBean["subtitle"]=$torukaInfo["subtitle"];
		$this->formBean["content"]=$torukaInfo["content"];
		$this->formBean["create_date"]=date("Y/m/d",strtotime($torukaInfo["create_date"]));
		$this->formBean["create_user"]= UserModel::getInstant()->getUserName($torukaInfo["create_user"]);
        $this->formBean['down_link']=toruka_down_url.$torukaInfo['filename'];
	}
	
	function editAction() 
	{
		if (isset($_POST["doRegister"]))
		{
			$this->formBean["id"]=-1;//新規フラグ
		}
		elseif(isset($_GET["id"]) && $_GET["id"]>0)
		{
			$this->loadInfoToView();
		}

		$this->formBean["to_confirm"]=$this->getUrl('TorukaMana','confirm');
		$this->formBean["form_title"]=$this->formBean["id"]>0?"トルカ編集画面":"トルカ新規画面";
	}

	function confirmAction() 
	{
		if (isset($_POST["update"]))//更新して、管理画面表示
		{
			$torukaModel = TorukaModel::getInstant();
			session_start();
			if ($_POST["id"]==-1)//新規
			{
				$registerArray = array ('kind' => $_POST ['kind'],'title' => $_POST ['title'],
				'subtitle' => $_POST ['subtitle'],'content' => $_POST ['content'],
				'create_user' => $_SESSION["user_id"],'update_user' => $_SESSION["user_id"]);
				$registerArray['id'] = $torukaModel->register($registerArray);
				$res = $torukaModel->send_toruka($registerArray, 1);
			}
			else if ($_POST["id"]>0)//修正
			{
				$updateArray = array ('id' => $_POST ['id'],'kind' => $_POST ['kind'],'title' => $_POST ['title'],
				'subtitle' => $_POST ['subtitle'],'content' => $_POST ['content'],'update_user' => $_SESSION["user_id"]);
				$torukaModel->update($updateArray);
				$res = $torukaModel->send_toruka($updateArray, 2);
			}
			if ($res) {$this->redirect('TorukaMana', 'manage');}
			//echo $this->getUrl($controlName,$actionName));
			else{$this->formBean["err"]="更新失敗しました。";}
		}
		else//確認画面表示
		{
			$this->formBean["id"]=$_POST["id"];
			$this->formBean["kind"]=$_POST["kind"];
			$this->formBean["kind_name"]=$_POST["kind"]==0?"通常トルカ":"iトルカ";
			$this->formBean["title"]=$_POST["title"];
			$this->formBean["subtitle"]=$_POST["subtitle"];
			$this->formBean["content"]=$_POST["content"];
		}
		$this->formBean["cancel"]=$this->getUrl('TorukaMana','manage');
	}
}
?>