<?php
require_once ("Controller_Front.php");
require_once("../../Env/Setting.php");
class Controller_Action
{
	protected $formBean=array();
	protected $foreachArray=array();
	public $viewName='';
	public $viewPath='';
	public $isViewShowed=false;
	public $revPara=null;

	//画面選択
	public function render($viewPath='',$viewName='')
	{
		if ($viewPath!='') {$this->viewPath=$viewPath; }
		if ($viewName!='') {$this->viewName=$viewName; }
		if (!$this->checkLogin()){$this->logoutAction();}
		include ($this->makeViewUrl());
		$this->isViewShowed=true;
	}

	private function checkLogin()
	{
		session_start();
		if ($this->viewName=="login") {return true;}//ログイン画面チェックしない
		if ($_SESSION["user_id"]) {return true;}
		return false;
	}

	public function logoutAction()
	{
		session_start();
		session_unset();
		session_destroy();
		header("Location: ../../index.php");
		exit;
	}

	private  function makeViewUrl()
	{
		$viewPath=$this->viewPath;
		if ($viewPath!='') {$viewPath.='/';}
		$viewUrl="../../View/".$viewPath.$this->viewName.".tpl";
		return $viewUrl;
	}

	//コントローラ　選択
	protected  function forward($controlName='',$actionName='',$sendPara=array())
	{
		$this->isViewShowed=true;// forbid self def view
		$_REQUEST [CTL_KEY]=$controlName;
		$_REQUEST [ACT_KEY] =$actionName;
		$controller_Front = Controller_Front::getInstance();
		$controller_Front->para=$sendPara;
		$controller_Front->dispatche();
	}

	protected function redirect($controlName,$actionName)
	{
		header('Location: '.$this->getUrl($controlName,$actionName));
		exit();
	}

	protected function getUrl($controlName='',$actionName='')
	{
		return './default.php?'.CTL_KEY.'='.$controlName.'&'.ACT_KEY.'='.$actionName;
	}

	protected function freeRedirect($url)
	{
		header('Location: '.$url);
		exit();
	}

	protected  function makePageUrlLst($maxpage,$page,$controlName,$actionName)
	{
		$urllist = array();
		if ($maxpage <= 1) {return $urllist;}
		$baseUrl=$this->getUrl($controlName,$actionName);
		if($maxpage < 6)
		{
			for($l = 1; $l <= $maxpage; $l++)
			{
				$urllist[$l] = $baseUrl.'&page='.$l;
			}
			return $urllist;
		}
		//---------------データが6ページ以上↓---------------
		//-----------ファーストページ------------------    
		if($page <= 1)
		{
			for($l = 1; $l < 6; $l++)
			{
				$urllist[$l] = $baseUrl.'&page='.$l;
			}
			$urllist[$maxpage + 3] = $baseUrl.'&page='.($page+1); //次へ  
			$urllist[$maxpage + 4] = $baseUrl.'&page='.$maxpage;  //最後へ   
			return $urllist;
		}
		//-----------ラストページ------------------  
		if($page >= $maxpage)
		{
			$urllist[$maxpage + 1] = $baseUrl.'&page=1';//先頭へ
			$urllist[$maxpage + 2] = $baseUrl.'&page='.($page - 1);//前へ
			for($l = $maxpage - 4; $l < $maxpage + 1; $l++)
			{
				$urllist[$l] =  $baseUrl.'&page='.$l;
			}
			return $urllist;
		}
			
		$urllist[$maxpage + 1] = $baseUrl.'&page=1';
		$urllist[$maxpage + 2] = $baseUrl.'&page='.($page - 1);

		if($page < 4) {$spage = 1;}
		elseif($page > $maxpage - 3) {$spage = $maxpage - 4;}
		else {$spage = $page - 2;}
		$epage = $spage + 5;

		for($l = $spage; $l < $epage; $l++)
		{
			$urllist[$l] = $baseUrl.'&page='.$l;
		}
		$urllist[$maxpage + 3] = $baseUrl.'&page='.($page+1); //次へ  
		$urllist[$maxpage + 4] = $baseUrl.'&page='.$maxpage;  //最後へ 
			
		return $urllist;
	}


	protected function html_options($params)
	{
		$name = null;
		$values = null;
		$options = null;
		$selected = array();
		$output = null;
		 
		$extra = '';
		 
		foreach($params as $_key => $_val) {
			switch($_key) {
				case 'name':
					$$_key = (string)$_val;
					break;
				case 'options':
					$$_key = (array)$_val;
					break;
				case 'values':
				case 'output':
					$$_key = array_values((array)$_val);
					break;
				case 'selected':
					$$_key = array_map('strval', array_values((array)$_val));
					break;
				default:
					if(!is_array($_val)) {
						$extra .= ' '.$_key.'="'.$_val.'"';
					} 
					break;
			}
		}

		if (!isset($options) && !isset($values)){return '';} 

		$_html_result = '';
		if (isset($options)) {
			foreach ($options as $_key=>$_val)
			$_html_result .= $this->html_options_optoutput($_key, $_val, $selected);

		} else {
			foreach ($values as $_i=>$_key) {
				$_val = isset($output[$_i]) ? $output[$_i] : '';
				$_html_result .=$this->html_options_optoutput($_key, $_val, $selected);
			}
		}
		if(!empty($name)) {
			$_html_result = '<select name="' . $name . '"' . $extra . '>' . "\n" . $_html_result . '</select>' . "\n";
		}

		return $_html_result;
	}

	protected function html_options_optoutput($key, $value, $selected) {
		if(!is_array($value)) {
			$_html_result = '<option label="' . $value . '" value="' .
			$key . '"';
			if (in_array((string)$key, $selected))
			$_html_result .= ' selected="selected"';
			$_html_result .= '>' . $value . '</option>' . "\n";
		} else {
			$_html_result = $this->html_options_optgroup($key, $value, $selected);
		}
		return $_html_result;
	}

	protected function html_options_optgroup($key, $values, $selected) {
		$optgroup_html = '<optgroup label="' . $key . '">' . "\n";
		foreach ($values as $key => $value) {
			$optgroup_html .= $this->html_options_optoutput($key, $value, $selected);
		}
		$optgroup_html .= "</optgroup>\n";
		return $optgroup_html;
	}
}
?>