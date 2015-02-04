<?php
require_once("../Tools/CommUtil.php");
require_once("Controller_Action.php");
require_once ("../Model/UserModel.php");
require_once ("../Model/GroupModel.php");

class GroupController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
	}

	function manageAction() {
		if (isset($_POST["doRegister"])){$this->redirect('Group','register');}//登録画面へ
		$this->formBean["data"]=GroupModel::getInstant()->selectGp();
		if (count($this->formBean["data"])>0)
		{
			$i=0;
			foreach ($this->formBean["data"] as $row)
			{
				$url=$this->getUrl("Group","detail").'&id='.$row['id'];
				$this->formBean["data"][$i]['detail_link']=$url;
				$i++;
			}
		}
	}

	function registerAction() {
		if (isset($_POST["docancel"])){ $this->redirect('Group','manage'); }
		if (!isset($_POST["doRegister"])){return;}//登録ボタン
		if (strlen(trim($_POST ['group_name']))==0)
		{
			$this->formBean["info"]="グループ名を入力してください";
			return;
		}
		if (!GroupModel::getInstant()->register($_POST ['group_name']))
		{
			$this->formBean["info"]="グループ登録失敗しました";
			$this->formBean["group_name"]=$_POST["group_name"];
			return;
		}
		$this->redirect("Group","manage");//登録成功だったら、グループ管理へ
	}

	function detailAction() {
		if (isset($_POST["btn_changname"]))//登録ボタン
		{
			$this->forward("Group","modify");
			return;
		}
		elseif(isset($_POST["btn_delgroup"]))
		{
			GroupModel::getInstant()->del($_POST["id"]);
			$this->redirect("Group","manage");
		}
		$this->formBean["data"]=UserModel::getInstant()->getGroupUserInfo($_REQUEST["id"]);
		$this->formBean["id"]= $_REQUEST["id"];
		$this->formBean["group_name"]= GroupModel::getInstant()->getGroupName($_REQUEST["id"]);
		$this->formBean["is_can_del"]= count($this->formBean["data"])==0;
	}

	function modifyAction() {
		if (isset($_POST["btn_cancel_change"]))
		{
		   $this->freeRedirect($this->getUrl("Group","detail")."&id=".$_POST['id']);
		}
		if (isset($_POST["btn_change_name"]))
		{
			if (strlen(trim($_POST ['group_name']))==0)
			{
				$this->formBean["info"]="グループ名を入力してください";
				$this->loadModifyView();
				return;
			}
			if (!GroupModel::getInstant()->update($_POST ['id'],$_POST ['group_name']))
			{
				$this->formBean["info"]="グループ登録失敗しました";
				$this->loadModifyView();
				return;
			}
			$this->freeRedirect($this->getUrl("Group","detail").'&id='.$_POST['id']);
		}
		
		//==>detailから
		$this->loadModifyView();
	}
	
	private function loadModifyView()
	{
		$this->formBean["to_modify"]= $this->getUrl("Group","modify");
		$this->formBean["group_name"]= $_POST['group_name'];
		$this->formBean["id"]=$_POST['id'];
	} 
}
?>