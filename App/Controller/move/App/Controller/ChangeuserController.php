<?php
require_once("../Tools/CommUtil.php");
require_once("Controller_Action.php");
require_once ("../Model/UserModel.php");
require_once ("../Model/GroupModel.php");
require_once ("../Model/SendHistoryModel.php");

class ChangeuserController extends Controller_Action
{
	public function init() {
		session_start();
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_back"]=$this->getUrl("Main","main_menu")."&user_id=".$_SESSION["user_id"];
	}
	
    function checkAction()
	{
		session_start();
		$err="";
		$pass="";
		if (isset($_POST["btn_check_user"]))
		{
			$pass=$_POST["password"];
			if (UserModel::getInstant()->checkPass($_SESSION["user_id"],$pass))
			{
				$this->redirect("Changeuser","change");
			}
			$err="パスワードを確認してください";
		}
		$this->formBean["err"]=$err;
		$this->formBean["password"]=$pass;
	}
	
	function changeAction() {
		$err="";
		$userModel=UserModel::getInstant();
		if (isset($_POST["btn_update_user"]))
		{
			$err=$this->checkRegInput();
			if ($err!="")//入力チェックエラー、再表示
			{
				$this->putInfoToViewBean($_POST);
				$this->formBean["err"]=$err;
				return;
			}
			if (!$userModel->update($this->makeUpdateArray()))//エラーなし、変更する 
			{
				$this->putInfoToViewBean($_POST);
				$this->formBean["err"]="更新失敗しました";
				return;
			}
			$this->redirect('Main', 'main_menu');
		}
		else if(isset($_POST["btn_del_user"]))
		{
		    $isDocomo=($_POST ['sendway']==2 || $_POST ['sendway']==1);
			if ($isDocomo)
			{
				$result=SendUtil::DelMyboxUser($_POST["user_id"]);
				CommUtil::Get_log("マイボックス削除\tユーザコード：".$_POST["user_id"]."\t".($result == "00"?"OK":"NG").$result);
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
			$this->redirect('Changeuser', 'delend');
		}
		$this->putInfoToViewBean($userModel->getUserInfo($_SESSION["user_id"]));
	}

	private function checkRegInput()
	{
		if($_POST["user_id"]=="") {return "ユーザＩＤを入力してください。";}
		if($_POST["name"]=="") {return "名前を入力してください。";}
		if($_POST["password"]=="") {return "パスワードを入力してください。";}
		if(strlen($_POST["password"])!=4){return "パスワードは４桁入力してください。";}
		if(!is_numeric($_POST["password"])){return "パスワードは半角数字を入力してください。";}
		if(strlen(trim($_POST["email"])>0)&& !CommUtil::mail_check($_POST["email"]))
		{
			return "メールアドレスが不正です。"; 
		}
		return "";
	}

	private function putInfoToViewBean($info)
	{
		$this->formBean["user_id"]=$info ['user_id'];
		$this->formBean["name"]=$info ['name'];
		$this->formBean["sendway"]=$info ['sendway'];
		$this->formBean["password"]=$info ['password'];
		$this->formBean["email"]=$info ['email'];
		$this->formBean["authority"]=$info ['authority'];
		$this->formBean["isDocomo"]=($info ['sendway']==2 || $info ['sendway']==1);//docomoユーザ判定
		$this->formBean["isAdmin"]=$info ['authority']==2;
	}

	private function makeUpdateArray()
	{
		return array ('user_id' => $_POST ['user_id'],'name' => $_POST ['name'], 
		'password' => $_POST ['password'],'email' => (isset($_POST ['email'])?$_POST ['email']:''),
		 'sendway' => $_POST ['sendway'],'authority' => $_POST['authority']);
	}

	function delendAction() {
		if (isset($_POST ['btn_ok'])){ $this->redirect("Login","login");}
	}
}
?>