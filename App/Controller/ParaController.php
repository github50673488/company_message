<?php
require_once("../Tools/CommUtil.php");
require_once("Controller_Action.php");
require_once("../Model/ParaModel.php");
class ParaController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
	}

	function settingAction() {
		if(isset($_POST["btn_update"]))
		{
			$this->updateParas();
			$this->redirect("Master","list");
		}
		
		$this->loadParasToView();
		$this->formBean['go_back']=$this->getUrl("Master","list");
		
	}
	
    private function updateParas()
	{
		$paraModel=ParaModel::getInstant();
		$paraModel->update_para("mybox_no",$_POST["mybox_no"]);
		$paraModel->update_para("basic_auth_id",$_POST["basic_auth_id"]);
		$paraModel->update_para("basic_auth_pswd",$_POST["basic_auth_pswd"]);
		$paraModel->update_para("local_cert",$_POST["local_cert"]);
		$paraModel->update_para("passphrase",$_POST["passphrase"]);
		$paraModel->update_para("capath",$_POST["capath"]);
		$paraModel->update_para("iconcier_login_id",$_POST["iconcier_login_id"]);
		$paraModel->update_para("iconcier_login_password",$_POST["iconcier_login_password"]);
		$paraModel->update_para("popup_msg",$_POST["popup_msg"]);
		$paraModel->update_para("msg_r_password",$_POST["msg_r_password"]);
		$paraModel->update_para("msg_r_email_from",$_POST["msg_r_email_from"]);
		$paraModel->update_para("email_from",$_POST["email_from"]);
		$paraModel->update_para("smtp_host",$_POST["smtp_host"]);
		$paraModel->update_para("smtp_port",$_POST["smtp_port"]);
		$paraModel->update_para("email_send_name",$_POST["email_send_name"]);
		$paraModel->update_para("LINE_PER_PAGE",$_POST["LINE_PER_PAGE"]);
		$paraModel->update_para("map_url",$_POST["map_url"]);
	}
	
	
	private function loadParasToView()
	{
		$para_list=ParaModel::getInstant()->get_para_list();
		$this->formBean["mybox_no"]=$para_list["mybox_no"];
		$this->formBean["basic_auth_id"]=$para_list["basic_auth_id"];
		$this->formBean["basic_auth_pswd"]=$para_list["basic_auth_pswd"];
		$this->formBean["local_cert"]=$para_list["local_cert"];
		$this->formBean["passphrase"]=$para_list["passphrase"];
		$this->formBean["capath"]=$para_list["capath"];
		$this->formBean["iconcier_login_id"]=$para_list["iconcier_login_id"];
		$this->formBean["iconcier_login_password"]=$para_list["iconcier_login_password"];
		$this->formBean["popup_msg"]=$para_list["popup_msg"];
		$this->formBean["msg_r_password"]=$para_list["msg_r_password"];
		$this->formBean["msg_r_email_from"]=$para_list["msg_r_email_from"];
		$this->formBean["email_from"]=$para_list["email_from"];
		$this->formBean["smtp_host"]=$para_list["smtp_host"];
		$this->formBean["smtp_port"]=$para_list["smtp_port"];
		$this->formBean["email_send_name"]=$para_list["email_send_name"];
		$this->formBean["LINE_PER_PAGE"]=$para_list["LINE_PER_PAGE"];
		$this->formBean["map_url"]=$para_list["map_url"];
	}
}
?>