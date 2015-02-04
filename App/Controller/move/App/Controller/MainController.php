<?php
require_once("Controller_Action.php");
require_once("../Model/SendHistoryModel.php");
class MainController extends Controller_Action
{
    public function init() {
    	session_start();
    }
    
	function main_menuAction() 
	{
		$this->formBean["to_sendmessage"]=$this->getUrl('SendMessage','send');
		$this->formBean["go_msg_list"]=$this->getUrl('Msglist','list');
		$this->formBean["to_toruka_mana"]=$this->getUrl('TorukaMana','manage');
		$this->formBean["to_schedule_mana"]=$this->getUrl('ScheduleMana','manage');
		$this->formBean["to_msg_board"]=$this->getUrl('Msgboard','manage');
		$this->formBean["to_toruka"]=$this->getUrl('Toruka','down');
		$this->formBean["to_schedule"]=$this->getUrl('Schedule','down');
		$this->formBean["to_user"]=$this->getUrl('Changeuser','check');
		
	}
}
?>