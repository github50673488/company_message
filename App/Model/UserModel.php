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

	function checkLogin($userid, $userpsw) {
		$sql = "select count(-1) as user_count from user where user_id='".$userid."' and password='".$userpsw."'";
		return $this->getValue($sql)>0;
	}

	function getAuthority($userid ) {
		return $this->getValue("select authority from user where user_id='".$userid."'");
	}


	function select($where,$page) {
		$sql = "select user.*,group_info.group_name from user
		left join group_info on user.group_id=group_info.id
		".$where." order by user.user_id ";
		$sql.= CommUtil::makePageLimitStr($page,ParaModel::getInstant()->get_para_value("LINE_PER_PAGE"));
		return $this->getAll($sql);
	}

	function getUserInfo($user_id) {
		return $this->getRow("select * from user where user_id='".$user_id."'");
	}

	function getRecord($id) {
		return $this->getRow("select * from user where id=".$id);
	}

	function checkRegister($user_id) {
		return 0==$this->getValue("select count(-1) from user where user_id= '".$user_id."'");
	}

	function getAutoID() {
		$AutoID=$this->getValue("select max(CAST(IFNULL(user_id,0) AS UNSIGNED))+1 from user;");
		return str_pad($AutoID, 10, "0", STR_PAD_LEFT);
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

	function register($registerArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = "insert into user (user_id,name,password,email,sendway,group_id,authority)
		values(?,?,?,?,?,?,?);";
		$stmt = $mysqli->prepare ($query );
		$stmt->bind_param ( "ssssiii", $registerArray ['user_id'],$registerArray ['name'],
		$registerArray ['password'],$registerArray ['email'],$registerArray ['sendway'],
		$registerArray ['group_id'],$registerArray ['authority']);
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}

	function update($updateArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$query = " update user set user_id=?,name=?,password=?,email=?,sendway=?,group_id=? ";
		$isUpdateAuth= isset($updateArray["authority"]);
		if ($isUpdateAuth){ $query.=",authority=?";}
		$query.=" where id=? ;";
		$stmt = $mysqli->prepare ($query);
		if ($isUpdateAuth)
		{
			$stmt->bind_param ("ssssiiii", $updateArray ['user_id'],$updateArray ['name'],
			$updateArray ['password'],$updateArray ['email'],$updateArray ['sendway'],
			$updateArray ['group_id'],$updateArray ['authority'],$updateArray ['id']);
		}
		else
		{
			$stmt->bind_param ("ssssiii", $updateArray ['user_id'],$updateArray ['name'],
			$updateArray ['password'],$updateArray ['email'],$updateArray ['sendway'],
			$updateArray ['group_id'],$updateArray ['id']);
		}
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}
}

?>