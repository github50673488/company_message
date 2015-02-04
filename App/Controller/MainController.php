<?php
require_once("Controller_Action.php");
class MainController extends Controller_Action
{
    public function init() {
    	$this->formBean["go_logout"]=$this->getUrl('Login','logout');
    	session_start();
    	
    }
    
	function main_menuAction() {
		$this->formBean["go_msg_send"]=$this->getUrl('Message','send');
		$this->formBean["go_msg_list"]=$this->getUrl('Msglist','list');
		$this->formBean["go_toruka_manage"]=$this->getUrl('Toruka','manage');
		$this->formBean["go_schedule_manage"]=$this->getUrl('Schedule','manage');
		$this->formBean["go_msgboard_manage"]=$this->getUrl('Msgboard','manage');
		$this->formBean["go_changeuser"]=$this->getUrl('Changeuser','change');
		$this->formBean["go_master_manage"]=$this->getUrl('Master','list');
		$this->formBean["isAdmin"]=$_SESSION["authority"]==2;
	}
}
?>