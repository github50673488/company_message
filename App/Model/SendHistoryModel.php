<?php
require_once("../../Env/dbconn.class.php");
require_once("ModelAction.php");
class SendHistoryModel extends ModelAction {
	private  static  $sendHistoryModel=null;
	static function  getInstant() {
		if (self::$sendHistoryModel==null){self::$sendHistoryModel=new SendHistoryModel();}
		return self::$sendHistoryModel;
	}

	function getReserveUserLst($reserve_id) {
		$sql="select user_id from send_history where reserve_id =".$reserve_id;
		$u_id_list= $this->getAll($sql);
		$result=array();
		foreach ($u_id_list as $row)
		{
			$result[]=$row['user_id'];
		}
		return $result;
	}

	function delByUserID($user_id) {
		return $this->execute("delete from send_history where user_id='".$user_id."'");
	}

	function insert($insertArray) {
		return $this->db_insert("send_history",$insertArray);
	}

	function writeRevHis()
	{
		$mysqli = DBConn::getConn ();
		$mysqli->autocommit(false);
		$mysqli->query("SET NAMES 'utf8'");
		$res1= $mysqli->query("delete from user where user_id='".$user_id."'");
		$res2=$mysqli->query("delete from send_history where user_id='".$user_id."'");
		$result=$res1&&$res2;
		$result?$mysqli->commit():$mysqli->rollback();
		$mysqli->close ();
		return $result;
	}

}

?>