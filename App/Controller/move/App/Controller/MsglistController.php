<?php
require_once("../Tools/CommUtil.php");
require_once("../Model/ReserveModel.php");
require_once("Controller_Action.php");
require_once("../Model/ParaModel.php");
class MsglistController extends Controller_Action
{
	public function init() {
		session_start();
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_back"]=$this->getUrl('Main','main_menu');
	}

	function listAction() {
		//-----------------リスト　表示,ページコントロール↓-----------------
		$page = 1;
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		$recordCount = ReserveModel::getInstant()->getRecordCount($_SESSION["user_id"]);
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

		$this->formBean["data"]=ReserveModel::getInstant()->select($page,$_SESSION["user_id"]);
		if (count($this->formBean["data"])>0)
		{
			$i=0;
			foreach ($this->formBean["data"] as $row)
			{
				$url=$this->getUrl("Msglist","confirm").'&id='.$row['id'].'&addfilename='.$row['addfilename'].'&addfiletitle='.$row['addfiletitle'];
				$this->formBean["data"][$i]['detail_link']=$url;
				$i++;
			}
		}
	}

	function confirmAction() {
		$revInfo=ReserveModel::getInstant()->getRevInfo($_GET["id"]);
		$this->formBean["title"]=$revInfo["title"];
		$this->formBean["entry_date_str"]=date("Y/m/d",strtotime($revInfo["entry_date"])) ;
		$this->formBean["free_word"]=$revInfo["free_word"];
		$this->formBean["detail"]=$revInfo["detail"];

		$filepath="";
		$fileExt=substr($_GET["addfilename"],-4);
		if ($fileExt=='.trc')//トルカ
		{
			$filepath =toruka_path1.$_GET["addfilename"];
		}
		elseif ($fileExt=='.vcs')//スゲジュール
		{
			$filepath =schedule_path1.$_GET["addfilename"];
		}
		if (file_exists($filepath))
		{
			$this->formBean["is_file_exist"]= 1;
			$this->formBean["filepath"]= $filepath;
			$this->formBean["filetitle"]=$_GET["addfiletitle"];
		    if ($fileExt=='.vcs')//スゲジュールのencording問題
			{
			  	$this->formBean["filetitle"]= ScheduleModel::getInstant()->get_file_title($_GET["addfilename"]);
			}
		}
		
		$this->formBean["is_from_msg_list"]=1;
		$this->formBean["to_msg_send"]= $this->getUrl("SendMessage","send");
		$this->formBean["id"]=$_GET["id"];
	}
}
?>