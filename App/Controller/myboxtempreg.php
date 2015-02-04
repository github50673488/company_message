<?
require_once("../../Env/Setting.php");
require_once("../Model/ParaModel.php");
require_once("../Model/MyBoxInfoModel.php");
require_once("../Tools/CommUtil.php");
if(!$_POST)
{
	CommUtil::Get_log("myboxtempreg no post!!");
	return;
}

$xpid = $_POST['xp_id'];
$eid  = $_POST['eid'];
$date = $_POST['date'];
$crypt= $_POST['crypt'];
$arg1 = $_POST['arg1'];
$arg2 = $_POST['arg2'];

$myboxinfo["eid"] = $eid;
$myboxinfo["tmpdate"] = $date;
$myboxinfo["crypt"] = $crypt;
//$myboxinfo["user_id"] = CommUtil::Pad_left($arg1, 10, "0");
$myboxinfo["user_id"] = $arg1;

$msg = MyBoxInfoModel::getInstant()->insert($myboxinfo)?"OK":"NG";
CommUtil::Get_log("仮登録情報追加\tユーザ番号：".$myboxinfo["user_id"]."\t".$msg);

if($msg != "OK"){return;}

$req_body = "OK\r\n";
$time = time();
$date = gmdate( "D, d M Y H:i:s", $time) . " GMT";
$req_header= "HTTP/1.0 200 OK\r\n".
		"Date: ".$date."\r\n".
		"Server: ".$_SERVER['SERVER_NAME']."\r\n".
		"Content-Length: " .strlen($req_body)."\r\n".
		"Content-Type: text/plain\r\n".
		"\r\n";
$request = $req_header .$req_body;
$local_cert=ParaModel::getInstant()->get_para_value("local_cert");
$passphrase=ParaModel::getInstant()->get_para_value("passphrase");
$capath=ParaModel::getInstant()->get_para_value("capath");
$context = stream_context_create();
$result = stream_context_set_option($context, 'ssl', 'local_cert',$local_cert );
$result = stream_context_set_option($context, 'ssl', 'passphrase',$passphrase );
$result = stream_context_set_option($context, 'ssl', 'capath',$capath);

$sock = stream_socket_client("ssl://" .host. ":443", $errno, $errstr ,30 , STREAM_CLIENT_CONNECT, $context);
if (!$sock)
{
	CommUtil::Get_log("仮登録情報追加\tサーバーアクセス："."\t"."NG"."\t".$errstr($errno));
}
else
{
   CommUtil::Get_log("仮登録情報追加\tサーバーアクセス："."\t"."OK");
}

$ret = fputs($sock, $request);
CommUtil::Get_log("仮登録情報追加\tサーバーアクセス(fputs)："."\t".$ret);
fclose($sock);
?>
