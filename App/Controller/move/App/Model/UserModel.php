<?php
require_once("../../Env/dbconn.class.php");
require_once("../../Env/Setting.php");
require_once("ModelAction.php");
require_once("../Model/ParaModel.php");
class UserModel extends ModelAction{
	private  static  $userModel=null;
	static function  getInstant() {
		if (self::$userModel==null){self::$userModel=new UserModel();}
		return self::$userModel;
	}

	
    function release_user($user_id) {
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
	
    function update($updateArray) {
		$con=" WHERE user_id = '".$updateArray['user_id']."' LIMIT 1";
		return $this->db_update("user",$updateArray,$con);
	}
	
    function getUserInfo($user_id) {
		return $this->getRow("select * from user where user_id='".$user_id."'");
	}

    function getUserName($user_id) {
		$sql="select name from user where user_id='".$user_id."'";
		return $this->getValue($sql);
	}
	
	function getUserInfoByUidList($userid_list) {
		$sql="select * from user where user_id in (".implode(",", $userid_list).")";
		return $this->getAll($sql);
	}

	function getGroupUserInfo($group_id) {
		return $this->getAll("select user_id,name from user where group_id=".$group_id);
	}

	function getRecordCount($where) {
		return $this->getValue("select count(-1) from user ".$where);
	}

	function checkUid($user_id) {
		return 0<$this->getValue("select count(-1) from user where user_id= '".$user_id."'");
	}

	function checkPass($user_id,$password) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select count(-1) from user where user_id='".$user_id."' and password='".$password."'";

		$ispass=false;
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$ispass=$row[0]>0;
			$result->close();
		}
		$mysqli->close ();
		return $ispass;
	}


	function select($where,$page) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select * from user ".$where." order by user_id ";
		$sql.= CommUtil::makePageLimitStr($page,LINE_PER_PAGE);

		if ($result = $mysqli->query($sql)) {
			while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$userArray[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $userArray;
	}

	function getRecord($id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select * from user where id=".$id;

		$record=array();
		if ($result = $mysqli->query($sql)) {
			$record = $result->fetch_array();
			$result->close();
		}
		$mysqli->close ();
		return $record;
	}

	function getRecordByUID($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select * from user where user_id = '".$user_id."' limit 1 ";

		$record=array();
		if ($result = $mysqli->query($sql)) {
			$record = $result->fetch_array();
			$result->close();
		}
		$mysqli->close();
		return $record;
	}


	function checkRegister($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select count(-1) from user where user_id= '".$user_id."'";

		$isCanReg=false;
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$isCanReg=$row[0]==0;
			$result->close();
		}
		$mysqli->close ();
		return $isCanReg;
	}

	function getAutoID() {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select max(CAST(IFNULL(user_id,0) AS UNSIGNED))+1 as addUid  from user;";

		$AutoID=0;
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$AutoID=$row[0];
			$result->close();
		}
		$mysqli->close ();
		return str_pad($AutoID, 7, "0", STR_PAD_LEFT);
	}

	function del($id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "delete from user where id=?";
		$stmt = $mysqli->prepare ($query);
		$stmt->bind_param ( "i", $id );
		$stmt->execute ();
		$mysqli->close ();
	}

	function delByUserID($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "delete from user where user_id=?";
		$stmt = $mysqli->prepare ($query);
		$stmt->bind_param ( "s", $user_id );
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}

	function register($registerArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "insert into user (user_id,name,password,email,sendway,p1,p2,p3,p4,p5,p6,p7,p8,p9)
		values(?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		$stmt = $mysqli->prepare ($query );
		$stmt->bind_param ( "ssssiiiiiiiiii", $registerArray ['user_id'],$registerArray ['name'],
		$registerArray ['password'],$registerArray ['email'],$registerArray ['sendway'],
		$registerArray ['p1'],$registerArray ['p2'],$registerArray ['p3'],$registerArray ['p4'],
		$registerArray ['p5'],$registerArray ['p6'],$registerArray ['p7'],$registerArray ['p8'],
		$registerArray ['p9']);
		$stmt->execute ();
		$mysqli->close ();
	}

	function w_del($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "delete from w_user where user_id=?";
		$stmt = $mysqli->prepare ($query);
		$stmt->bind_param ( "s", $user_id );
		$stmt->execute ();
		$mysqli->close ();
	}


	function w_register($registerArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "insert into w_user (user_id,name,password,email,sendway,group_id,authority)
		values(?,?,?,?,?,?,?);";
		$stmt = $mysqli->prepare ($query );
		$stmt->bind_param ( "ssssiii", $registerArray ['user_id'],$registerArray ['name'],
		$registerArray ['password'],$registerArray ['email'],$registerArray ['sendway'],
		$registerArray ['group_id'],$registerArray ['authority']);
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}


	function register_from_w($user_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "insert into user select * from w_user where user_id = '".$user_id."' ";
		$stmt = $mysqli->prepare ($query);
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}

	
}

?>