<?php
require_once("Controller_Action.php");
require_once ("../Model/ScheduleModel.php");

class ScheduleController extends Controller_Action
{
    public function init() {
    	session_start();
		$this->formBean["go_back"]=$this->getUrl("Main","main_menu")."&user_id=".$_SESSION["user_id"];
    }
    
	function downAction() {
		$this->formBean["data"]=ScheduleModel::getInstant()->getiScheduleLst($_SESSION["user_id"]);
		$this->addDownLink();
	}
	
    private function addDownLink()
	{
		if (count($this->formBean["data"])<=0){return;}
		$i=0;
		foreach ($this->formBean["data"] as $row)
		{
			$this->formBean["data"][$i]['down_link']=schedule_down_url.$row['filename'];
			$i++;
		}
	}
}
?>