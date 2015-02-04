<?php
require_once("../../Env/dbconn.class.php");
require_once("ModelAction.php");
class SendHistoryModel extends ModelAction{
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
	
	
	function getSendHisList($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		
		$sendHisList=array();
		$sql = "select * from send_history where user_id= '".$user_id."' order by entry_date desc limit 5";
		if ($result = $mysqli->query($sql)) {
		    while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$sendHisList[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $sendHisList;
	}
	
   function getGPSList($user_id,$page) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		
		$sendHisList=array();
		$sql = "select * from send_history where user_id= '".$user_id."' and send_mode=1 ";
		$sql.=" order by entry_date desc ";
		$sql.= CommUtil::makePageLimitStr($page,LINE_PER_PAGE);
		if ($result = $mysqli->query($sql)) {
		    while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$sendHisList[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $sendHisList;
	}
		
   function getGpsRecordCount($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select count(-1) from send_history where user_id= '".$user_id."' and send_mode=1 ";

		$recordCount=0;
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$recordCount=$row[0];
			$result->close();
		}
		$mysqli->close ();
		return $recordCount;
	}
	
}

?>