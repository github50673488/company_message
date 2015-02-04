<?php
require_once("../Model/UserModel.php");
require_once("../Tools/CommUtil.php");
require_once("Controller_Action.php");

class LoginController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
		session_start();
	}

	function loginAction() {
		$errMsg="";
		if (isset($_POST["login"]))
		{
			//$_POST["user_id"]=CommUtil:: Pad_left($_POST["user_id"],10,"0");//liu 2010/08/24 del
			$errMsg=$this->getErrmsg();
			if ($errMsg=="")
			{
				$_SESSION["user_id"] = $_POST["user_id"];// ログインが成功した証をセッションに保存
				$_SESSION["authority"] = UserModel::getInstant()->getAuthority($_POST["user_id"]);// ログインが成功した証をセッションに保存
				$this->redirect('Main','main_menu');
			}
			$this->formBean["user_id"]=$_POST ['user_id'];
			$this->formBean["password"]=$_POST ['password'];
		}
		$this->formBean["err"]=CommUtil::Sethtml_error($errMsg);
	}

	private function getErrmsg()
	{
		if (strlen(trim($_POST ['user_id']))==0 ){return "担当者ＩＤを入力してください。";}
		if (strlen(trim($_POST ['password']))==0) {return  "パスワードを入力してください。";}
		if (!UserModel::getInstant()->checkLogin($_POST ['user_id'], $_POST ['password'] ))
		{
			return "入力内容を確認してください。";
		}
		return "";
	}
}
?>