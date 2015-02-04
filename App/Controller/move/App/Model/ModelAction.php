<?php
require_once("../../Env/dbconn.class.php");
require_once("../../Env/Setting.php");
class ModelAction {
	function getValue($sql) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$value='';
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$value=$row[0];
			$result->close();
		}
		$mysqli->close ();
		return $value;
	}

	function getAll($sql) {
		$mysqli = DBConn::getConn ($sql);
		$mysqli->query("SET NAMES 'utf8'");
		$resultArray=array();
		if ($result = $mysqli->query($sql)) {
			while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$resultArray[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $resultArray;
	}

	function getRow($sql) {
		$mysqli = DBConn::getConn ($sql);
		$mysqli->query("SET NAMES 'utf8'");
		$row=array();
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array(MYSQLI_BOTH);
			$result->close();
		}
		$mysqli->close ();
		return $row;
	}


	function execute($sql) {
		try {
			$mysqli = DBConn::getConn ();
			$mysqli->query("SET NAMES 'utf8'");
			$stmt = $mysqli->prepare ($sql);
			$result=$stmt->execute();
			$mysqli->close ();
			return $result;
		}catch (Exception $e) {
			return false;
		}
	}

	function insertGetID($tbl, $array, $null_list=array())
	{
		try {	
			$mysqli = DBConn::getConn ();
			$mysqli->query("SET NAMES 'utf8'");
			$stmt = $mysqli->prepare ($this->getInsertSql($tbl, $array, $null_list));
			$exres=$stmt->execute();
			$result=$exres?$mysqli->insert_id:-1;
			$mysqli->close ();
			return $result;
		}catch (Exception $e) {
			return -1;
		}
	}

	function db_select($tbl, $col, $con, $array_flag=true)
	{
		$data = array();
		$sql = ($col=="*") ? "SELECT * FROM $tbl" : "SELECT ".implode($col, ", ")." FROM $tbl";
		if($con) $sql .= " ".trim($con);
		return  $array_flag?$this->getAll($sql):$this->getRow($sql);
	}
	
    function db_insert($tbl, $array, $null_list=array())
	{
		return $this->execute($this->getInsertSql($tbl, $array, $null_list));
	}

	function db_update($tbl, $array, $con="LIMIT 1", $null_list=array())
	{
		return $this->execute($this->getUpdateSql($tbl, $array, $con,$null_list));
	}
	
	function getInsertSql($tbl, $array, $null_list)
	{
		$col = $val = "";
		foreach(array_keys($array) as $key) {
			$col .= "$key, ";
			$val .= "'".mysql_escape_string($array[$key])."', ";
		}
		foreach($null_list as $value) {
			$col .= "$value, ";
			$val .= "NULL, ";
		}
		return "INSERT INTO $tbl(".rtrim($col, ", ").") VALUES(".rtrim($val, ", ").")";
	}

    function getUpdateSql($tbl, $array, $con,$null_list)
	{
		$i=0;
		foreach(array_keys($array) as $key) {
			if(count($array) == $i+1){
				$set .= "$key = '".mysql_escape_string($array[$key])."' ";
			}else{
				$set .= "$key = '".mysql_escape_string($array[$key])."', ";
			}
			$i++;
		}
		foreach($null_list as $value) 
		{
			$set .= "$value = NULL, ";
		}
		$sql = "UPDATE $tbl SET ".$set;
		if($con!="") $sql .= " $con";
		return $sql;
	}
}

?>