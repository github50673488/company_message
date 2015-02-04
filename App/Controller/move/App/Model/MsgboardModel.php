<?php
require_once("../../Env/dbconn.class.php");
require_once("../Tools/CommUtil.php");
require_once("ModelAction.php");
require_once("../Model/ParaModel.php");
class MsgboardModel extends ModelAction {

	private  static  $msgboardModel=null;
	static function getInstant() {
		if (self::$msgboardModel==null){self::$msgboardModel=new MsgboardModel();}
		return self::$msgboardModel;
	}

	function getMsgBoardInfo($id) {
		return $this->getRow("select * from msg_board where id=".$id);
	}

	function select($page) {
		$sql = "select *,DATE_FORMAT(create_date,'%Y-%m-%d') as create_date_str
		from msg_board  order by create_date desc ";
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		$sql.= CommUtil::makePageLimitStr($page,$linePerPage);
		return $this->getAll($sql);
	}

	function getRecordCount() {
		return $this->getValue("select count(-1) from msg_board ");
	}

	function del($id) {
		return $this->execute("delete from msg_board where id=".$id);
	}

	function register($registerArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		//$map = addslashes($registerArray ['map']);
		$query = "insert into msg_board (title,create_date,detail,map) values(?,?,?,?) ;";
		$stmt = $mysqli->prepare ( $query );
		$stmt->bind_param ( "ssss", $registerArray ['title'], date('Y-m-d H:i:s'), $registerArray ['detail'], $registerArray ['map'] );
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}

	function update($updateArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$isUpdateMap=isset($updateArray['map']);
		if ($isUpdateMap)
		{
			$query = " update msg_board set title=?,map=?, detail=? where id=? ;";
		}
		else
		{
			$query = " update msg_board set title=?, detail=? where id=? ;";
		}
		$stmt = $mysqli->prepare ( $query );
		if ($isUpdateMap)
		{
			$stmt->bind_param ("sssi", $updateArray ['title'],  $updateArray ['map'], $updateArray ['detail'], $updateArray ['id']);
		}
		else
		{
			$stmt->bind_param ("ssi", $updateArray ['title'], $updateArray ['detail'], $updateArray ['id']);
		}
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}

}

?>