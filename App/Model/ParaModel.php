<?php
require_once("../../Env/dbconn.class.php");
require_once("../../Env/Setting.php");
require_once("ModelAction.php");
class ParaModel extends ModelAction {
	private  static  $paraModel=null;
	static function getInstant() {
		if (self::$paraModel==null){self::$paraModel=new ParaModel();}
		return self::$paraModel;
	}

    function get_para_list() {
		$paras= $this->getAll("select * from para" );
		$result=array();
		foreach($paras as $row )
		{
			$result[$row['para_name']]=$row['para_value'];
		}
		return $result;
	}
	
    function get_para_value($para_name) {
		return $this->getValue("select para_value from para where para_name='".$para_name."'");
	}
	
    function update_para($para_name,$paravalue) {
		return $this->execute("update para set para_value = '".$paravalue."' where para_name='".$para_name."' ;" );
	}
}

?>