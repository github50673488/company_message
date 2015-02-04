<?php
require_once("../Tools/CommUtil.php");
require_once("../Model/ReserveModel.php");
require_once("Controller_Action.php");
require_once("../Model/ParaModel.php");
require_once("../Model/ScheduleModel.php");
class MsglistController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
		session_start();
	}

	function listAction() {
		$reserveModel =ReserveModel::getInstant();
		$where='';
		if (isset($_POST["doDel"]))
		{
			$reserveModel->del($_POST["id"]);
		}
		else if (isset($_POST["reMessage"]))
		{
			$this->forward('Msglist', 'confirm');
			return;
		}
		 
		//-----------------リスト　表示,ページコントロール↓-----------------
		$page = 1;
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		//$linePerPage = $_POST['pageCount']; 保留
		$recordCount = $reserveModel->getRecordCount($_SESSION["user_id"]);
		$maxpage = (int)($recordCount / $linePerPage);
		if (intval($recordCount % $linePerPage) != 0) {$maxpage ++;}
		$this->formBean[URL_LIST] = $this->makePageUrlLst($maxpage,$page,'Msglist','list');
		$this->formBean[MAX_PAGE] = $maxpage;
		$this->formBean[NOW_PAGE] = $page;
		$this->formBean[TOP_PAGE] = $maxpage+1;//先頭へ
		$this->formBean[PREV_PAGE] = $maxpage+2;//前へ
		$this->formBean[NEXT_PAGE] = $maxpage+3;//次へ
		$this->formBean[LAST_PAGE] = $maxpage+4;//最後へ 
		//-----------------ページコントロール↑-----------------

		$this->formBean["data"]=$reserveModel->select($page,$_SESSION["user_id"]);
		$this->formBean["to_confirm"]=$this->getUrl('Msglist','confirm');
	}

	function confirmAction() {
		$this->formBean["title"]=$_POST["title"];
		$this->formBean["entry_date_str"]=$_POST["entry_date_str"];
		$this->formBean["free_word"]=$_POST["free_word"];
		$this->formBean["detail"]=$_POST["detail"];

		$filepath="";
		$fileExt=substr($_POST["addfilename"],-4);
		if ($fileExt=='.trc')//トルカ
		{
			$filepath = toruka_path.$_POST["addfilename"];
		}
		elseif ($fileExt=='.vcs')//スゲジュール
		{
			$filepath =schedule_path.$_POST["addfilename"];
		}
		if (file_exists($filepath))
		{
			$this->formBean["is_file_exist"]= 1;
			$this->formBean["filepath"]= $filepath;
			$this->formBean["filetitle"]=$_POST["addfiletitle"];
			if ($fileExt=='.vcs')//スゲジュールのencording問題
			{
			  	$this->formBean["filetitle"]= ScheduleModel::getInstant()->get_file_title($_POST["addfilename"]);
			}
		}
		
		$this->formBean["is_from_msg_list"]=1;
		$this->formBean["to_msg_send"]= $this->getUrl("Message","send");
		$this->formBean["id"]=$_POST["id"];
	}
}
?>