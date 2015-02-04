<?php
require_once ("LoginController.php");
require_once ("MainController.php");
require_once ("MessageController.php");
require_once ("MsglistController.php");
require_once ("ScheduleController.php");
require_once ("MsgboardController.php");
require_once ("TorukaController.php");
require_once ("ChangeuserController.php");
require_once ("MasterController.php");
require_once ("GroupController.php");
require_once ("UserController.php");
require_once ("ParaController.php");
require_once("../../Env/Setting.php");

class Controller_Front {
   
   private  static  $controller_Front=null;
   public  $para=null;
   
   static function getInstance() {
	if (self::$controller_Front==null){self::$controller_Front=new Controller_Front();}
	return self::$controller_Front;
	}
    public  function dispatche()
	{
		if (isset ( $_REQUEST [CTL_KEY] )) {$ctlName = $_REQUEST [CTL_KEY];}
		if (isset ( $_REQUEST [ACT_KEY] )) {$actName = $_REQUEST [ACT_KEY];}

		try
		{
			if (strlen($ctlName)==0 )
			{
				echo "No Control Name";
				exit;
			}
			if (strlen($actName)==0 )
			{
				echo "No action Name";
				exit;
			}
			//$className=lcfirst($ctlName)."Controller";//クラス名前大文字
			$className=$ctlName."Controller";
			if (class_exists($className))
			{
				$controller= new $className;//new Controller
			}
			else
			{
				echo "no this class ";
				exit;
			}
			
			//$funName=lcfirst($actName)."Action";//action関数名前小文字
			$funName=$actName."Action";
			if (method_exists($controller,$funName))
			{
				$controller->viewPath=$ctlName;
				$controller->viewName=$actName;
				$controller->revPara=$this->para;
				if (method_exists($controller,"init") ) 
				{
				   $controller->init();//初期化
				}
				$controller->$funName();
				if (!$controller->isViewShowed) 
			    {
					$controller->render();//auto show view
				}
			}
			else
			{
				echo "no this method ";
				exit;
			}
		}
		catch (Exception $e) {
			echo "dispatche Error!";
			exit();
		}
	}
	
}

?>
