<?php
require_once("../../Env/dbconn.class.php");
require_once("ModelAction.php");
class AccessCountModel extends ModelAction {
	private  static  $accessCountModel=null;
	static function getInstant() {
		if (self::$accessCountModel==null){self::$accessCountModel=new AccessCountModel();}
		return self::$accessCountModel;
	}
	
    function insert($access_cnt) {
		return $this->db_insert("access_count", $access_cnt);
	}
	
	
}
?>