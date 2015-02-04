<?php
require_once("../../../../Env/Setting.php");
$sql = "update access_count set count = count + 1 where url = '20100514093704_0000000003.php' LIMIT 1";
$mysqli= new mysqli (DB_SERVER, DB_USER, DB_PSW, DB_NAME );
$stmt = $mysqli->prepare ($sql);
$result=$stmt->execute();
$mysqli->close ();
?>
<html><head><meta http-equiv='Content-Type' content='text/html; charset=shift_jis'><title>情報配信デモシステム</title></head>sdfsdf<div><br><a href='http://dcm2.dmpw.jp/info/Upload/Toruka/toruka20100428161213.trc'>ダウンロード</a></div></body></html>