<?php
require_once("../../Env/dbconn.class.php");
require_once("../Tools/CommUtil.php");
require_once("ModelAction.php");
class MyBoxInfoModel extends ModelAction {
	private  static  $myBoxInfoModel=null;
	static function getInstant() {
		if (self::$myBoxInfoModel==null){self::$myBoxInfoModel=new MyBoxInfoModel();}
		return self::$myBoxInfoModel;
	}

   function insert($myboxinfo) {
		return $this->db_insert("myboxinfo",$myboxinfo);
	}
	
	function del($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "delete from myboxinfo where user_id=? ";
		$stmt = $mysqli->prepare ($query);
		$stmt->bind_param ( "s", $user_id );
		$stmt->execute ();
		$mysqli->close ();
	}

	function getMyBoxInfo($user_id) 
	{
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select * from myboxinfo where user_id='".$user_id."' limit 1 ;";
		$myboxArray=array();
		if ($result = $mysqli->query($sql)) {
			$myboxArray = $result->fetch_array();
			$result->close();
		}
		$mysqli->close ();
		return $myboxArray;
	}

}

?>