<?php
require_once("Controller_Action.php");
require_once ("../Model/TorukaModel.php");
require_once("../Model/ParaModel.php");

class TorukaController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
		session_start();//session使用
	}

	function manageAction() {
		$torukaModel = TorukaModel::getInstant();
		$where='';	
		if (isset($_POST["doDel"]))
		{
			$torukaModel->del($_POST["id"]);
		}
		else if (isset($_POST["doUpdate"]))
		{
			$this->forward('Toruka', 'edit');
			return;
		}
	    else if (isset($_POST["t_makemessage"]))
		{
			$_POST["file_kind_name"]=$_POST["kind"]==1?"iトルカ":"トルカ";
			$_POST["file_kind"]="1";
			$this->forward('Message', 'send');
			return;
		}
		
		//-----------------リスト　表示,ページコントロール↓-----------------
		$page = 1;
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		//$linePerPage = $_POST['pageCount']; 保留
		$recordCount = $torukaModel->getRecordCount();
		$maxpage = (int)($recordCount / $linePerPage);
		if (intval($recordCount % $linePerPage) != 0) {$maxpage ++;}
		$this->formBean[URL_LIST] = $this->makePageUrlLst($maxpage,$page,'Toruka','manage');
		$this->formBean[MAX_PAGE] = $maxpage;
		$this->formBean[NOW_PAGE] = $page;
		$this->formBean[TOP_PAGE] = $maxpage+1;//先頭へ
		$this->formBean[PREV_PAGE] = $maxpage+2;//前へ
		$this->formBean[NEXT_PAGE] = $maxpage+3;//次へ
		$this->formBean[LAST_PAGE] = $maxpage+4;//最後へ 
		//-----------------ページコントロール↑-----------------

		$this->formBean["data"]=$torukaModel->select('',$page);
		$this->formBean["to_edit"]=$this->getUrl('Toruka','edit');
	}

	function editAction() {
		if (isset($_POST["doRegister"]))
		{
			$this->formBean["id"]=-1;//新規フラグ
		}
		elseif (isset($_POST["doUpdate"]))
		{
			$this->formBean["id"]=$_POST["id"];
			$this->formBean["kind"]=$_POST["kind"];
			$this->formBean["title"]=$_POST["title"];
			$this->formBean["subtitle"]=$_POST["subtitle"];
			$this->formBean["content"]=$_POST["content"];
		}

		$this->formBean["to_confirm"]=$this->getUrl('Toruka','confirm');
		$this->formBean["to_mana"]=$this->getUrl('Toruka','manage');//
		$this->formBean["form_title"]=$this->formBean["id"]==-1?"トルカ新規画面":"トルカ編集画面";
	}

	function confirmAction() {
		if (!isset($_POST["update"]))//確認画面表示
		{
			$this->formBean["id"]=$_POST["id"];
			$this->formBean["kind"]=$_POST["kind"];
			$this->formBean["kind_name"]=$_POST["kind"]==0?"通常トルカ":"iトルカ";
			$this->formBean["title"]=$_POST["title"];
			$this->formBean["subtitle"]=$_POST["subtitle"];
			$this->formBean["content"]=$_POST["content"];
		}
		else//更新して、管理画面表示
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
			
			if ($res) {$this->redirect('Toruka', 'manage');}
			else{$this->formBean["err"]="更新失敗しました。";}
		}
		$this->formBean["cancel"]=$this->getUrl('Toruka','manage');
	}
}
?>