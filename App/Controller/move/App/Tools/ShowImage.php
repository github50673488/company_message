<?php
require_once("../../Env/dbconn.class.php");
require_once("../Tools/CommUtil.php");

$mysqli = DBConn::getConn ();
if (isset($_GET['map_id']))
{	
    header("Content-Type: image/jpeg");
	$sql = "select map from msg_board where id=".$_GET['map_id'];
	if ($result = $mysqli->query($sql)) {
		$row = $result->fetch_array();
		$result->close();
	}
	//$imagebytes = stripslashes($row['map']);
	echo $row['map'];
}
?>