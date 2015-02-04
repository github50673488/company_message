<?php
require_once("../Model/UserModel.php");
require_once("../Tools/CommUtil.php");
require_once("Controller_Action.php");
class LoginController extends Controller_Action
{
	public function init() {
          session_start();
	}
	function loginAction() {
		$user_id="";
        $err="";
		if(CommUtil::agent_check()==1 && isset($_SERVER["HTTP_X_CUID"]))
		{
			$this->go_menu($_SERVER["HTTP_X_CUID"]);
		}
		
		if (isset($_POST["login"]))
		{
			//$user_id=CommUtil::Pad_left($_POST["user_id"],10,"0");//liu 2010/08/24 del
			if (UserModel::getInstant()->checkUid($user_id))
			{
				 $this->go_menu($user_id);
			}
			else
			{
				$err =CommUtil::Sethtml_error("ユーザIDを確認してください");
			}
		}
		$this->formBean["err"]=$err;
		
		$this->formBean["uid"]=$user_id;
		
	   
	}
	
	private function go_menu($user_id)
	{
		if (strlen($user_id)<=0){return;}
		session_start();
		$_SESSION["user_id"] = $user_id;//セッションに保存
		//$this->freeRedirect($this->getUrl("Main","main_menu")."&user_id=".$user_id);
		$this->forward("Main","main_menu");
	}
}
?>