<?php
require_once("Controller_Action.php");
require_once ("../Model/MsgboardModel.php");
require_once("../Tools/CommUtil.php");
require_once("../Model/ParaModel.php");

class MsgboardController extends Controller_Action
{
	public function init() {
		session_start();
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
	}

	function manageAction()
	{
		$msgboardModel = MsgboardModel::getInstant();
		if (isset($_POST["del"]))
		{
			$msgboardModel->del($_POST["id"]);
		}
		elseif (isset($_POST["update"]))
		{
			$this->freeRedirect($this->getUrl("Msgboard","modify")."&id=".$_POST["id"]);
		}
		elseif (isset($_POST["doRegister"]))
		{
			$this->redirect('Msgboard','register');//登録画面へ
		}
		//-------------------リスト　表示↓-------------------------------------
		//-----------------ページコントロール↓-----------------
		$page = 1;
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		//$linePerPage = $_POST['pageCount']; 保留
		$recordCount = $msgboardModel->getRecordCount();
		$maxpage = (int)($recordCount / $linePerPage);
		if (intval($recordCount % $linePerPage) != 0) {$maxpage ++;}
		$this->formBean[URL_LIST] = $this->makePageUrlLst($maxpage,$page,'Msgboard','manage');
		$this->formBean[MAX_PAGE] = $maxpage;
		$this->formBean[NOW_PAGE] = $page;
		$this->formBean[TOP_PAGE] = $maxpage+1;//先頭へ
		$this->formBean[PREV_PAGE] = $maxpage+2;//前へ
		$this->formBean[NEXT_PAGE] = $maxpage+3;//次へ
		$this->formBean[LAST_PAGE] = $maxpage+4;//最後へ 
		//-----------------ページコントロール↑-----------------

		$this->formBean["data"]=$msgboardModel->select($page);
		if (count($this->formBean["data"])>0)
		{
			$i=0;
			foreach ($this->formBean["data"] as $row)
			{
				$url=$this->getUrl("Msgboard","detail").'&id='.$row['id'];
				$this->formBean["data"][$i]['detail_link']=$url;
				$i++;
			}
		}
	}

	function detailAction() {
		$msgboardModel=MsgboardModel::getInstant();
		if (isset($_POST["delbtn"]))
		{
			$msgboardModel->del($_POST["id"]);
			$this->redirect('Msgboard','manage');
		}
		elseif (isset($_POST["modifybtn"]))
		{
			$this->freeRedirect($this->getUrl("Msgboard","modify")."&id=".$_POST["id"]);
		}
		$msgboardInfo= $msgboardModel->getMsgBoardInfo($_REQUEST["id"]);
		$this->formBean["id"]=$msgboardInfo["id"];
		$this->formBean["title"]=$msgboardInfo["title"];
		$this->formBean["detail"]=str_replace("\r\n","<br>",$msgboardInfo["detail"]);
		$this->formBean["map"]=$msgboardInfo["map"];
		$this->formBean["to_detail"]=$this->getUrl("Msgboard","detail");
	}

	function registerAction() {
		if (isset($_POST['regbtn']))//登録
		{
			$map = "";
			if (strlen($_FILES['map_file']['name']) > 0)
			{
				if($_FILES['map_file']['size'] > 65536)
				{
					$this->setErrViewBean("アップロードしたファイルは大き過ぎます(64*(2^10)バイト制限)");
					return;
				}
				$map_file = fopen($_FILES['map_file']['tmp_name'], 'rb');
				if(!$map_file)
				{
					$this->setErrViewBean("アップロードしたファイルを開けませんでした");
					return;
				}
				$map = fread($map_file, 65536); //
				fclose($map_file);
			}

			$registerArray = array ('title' => $_POST ['title'],'map' => $map, 'detail' => $_POST ['detail']);
			if (!MsgboardModel::getInstant()->register($registerArray ))
			{
				$this->setErrViewBean("登録失敗しました");
				return;
			}
			$this->redirect('Msgboard', 'manage');
		}
		else if (isset($_POST['cancelbtn']))//キャンセル
		{
			$this->redirect('Msgboard', 'manage');
		}
	}

	private function setErrViewBean($err,$isReloadMap=false)
	{
		$this->formBean['err']=$err;
		$this->formBean['title']=$_POST['title'];
		$this->formBean['detail']=$_POST['detail'];
		if ($isReloadMap)
		{
			$this->formBean['id']=$_REQUEST["id"];
			$msgboardInfo= MsgboardModel::getInstant()->getMsgBoardInfo($_REQUEST["id"]);
			$this->formBean["map"]=$msgboardInfo["map"];
		}
	}

	function modifyAction() {
		if (isset($_POST['regbtn']))//登録
		{
			$map = "";
			if (strlen($_FILES['map_file']['name']) > 0)
			{
				if($_FILES['map_file']['size'] > 65536)
				{
					$this->setErrViewBean("アップロードしたファイルは大き過ぎます(64*(2^10)バイト制限)",true);
					return;
				}
				$map_file = fopen($_FILES['map_file']['tmp_name'], 'rb');
				if(!$map_file)
				{
					$this->setErrViewBean("アップロードしたファイルを開けませんでした",true);
					return;
				}
				$map = fread($map_file, 65536); //
				fclose($map_file);
			}
			$updateArray = array ('id' => $_POST ['id'],'title' => $_POST ['title'], 'detail' => $_POST ['detail']);
			if ((!isset($_POST['changefile'])&& strlen($map)>0)
			||(isset($_POST['changefile'])&&$_POST['changefile']==1))
			{
				$updateArray['map'] = $map;
			}
			if (!MsgboardModel::getInstant()->update($updateArray))
			{
				$this->setErrViewBean("変更失敗しました",true);
				return;
			}
			$this->redirect('Msgboard', 'manage');
		}
		else if (isset($_POST['cancelbtn']))//キャンセル
		{
			$this->redirect('Msgboard', 'manage');
		}

		$msgboardModel=MsgboardModel::getInstant();
		$msgboardInfo= $msgboardModel->getMsgBoardInfo($_REQUEST["id"]);
		$this->formBean["id"]=$msgboardInfo["id"];
		$this->formBean["title"]=$msgboardInfo["title"];
		$this->formBean["detail"]=str_replace("\r\n","<br>",$msgboardInfo["detail"]);
		$this->formBean["map"]=$msgboardInfo["map"];
	}
}
?>