<?php
require_once("../Tools/CommUtil.php");
require_once("Controller_Action.php");
class MasterController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
	}

	function listAction() {
		$this->formBean["goto_user"]=$this->getUrl('User','manage');
		$this->formBean["go_group"]=$this->getUrl('Group','manage');
		$this->formBean["go_para_setting"]=$this->getUrl('Para','setting');
		
	}
}
?>