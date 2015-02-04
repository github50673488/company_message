<?php
//リクエストのボディ部を作成
//取得したパラメータはURLエンコードを施す

define("local_cert","/var/www/html/coop/opt/cert/demo.pem");//SSL証明書ファイル  
define("passphrase","5644");//SSL　エンコード パスフレーズ
define("capath","/var/www/html/coop/opt/cert/servercert/");//SSL証明書ファイルパス
define("host","so.docomo-apms.ne.jp");//マイボックスリクエストホスト 
define("basic_auth_id","CP001048");//Basic認証ID
define("basic_auth_pswd","SfHwob8BAq8m");//Basic認証パスワード
define("rid_del_f","228005002");///マイボックユーザ一括削除リクエストID
define("pid_f","22800501");///マイボックユーザ一括登録/削除 ページID
define("mybox_no","02000062004");//マイボックスサービス番号 

$req_body = $req_body = "--bbbbbbbbbb\r\n".
	
                "Content-Disposition: form-data; name=\"rid\"\r\n".
                "\r\n".
                "228005002\r\n".
                "--bbbbbbbbbb\r\n".
	            
	            "Content-Disposition: form-data; name=\"pid\"\r\n".
                "\r\n".
                "22800501\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"file_name\"; filename=\"20100430001.csv\"\r\n".
                "Content-Type:text/comma-separated-values\r\n".
                "\r\n".
                "\"NO\",1,\"TF\",999999999,\"TL\",99999\r\n".
                "\"".mybox_no."\"".","."\""."0000000002"."\"\r\n".
                "\"".mybox_no."\"".","."\""."0000000003"."\"\r\n".
                "[end of file]\r\n".
                "\r\n".
                "--bbbbbbbbbb--\r\n";

$encodedAuth=base64_encode(basic_auth_id .":".basic_auth_pswd);//Basic認証のID、パスワードをBase64でエンコード

//ヘッダー部の作成
$req_header= "POST /fc HTTP/1.1\r\n".
		"Host: "."so.docomo-apms.ne.jp"."\r\n".
        "Content-Length: " .strlen($req_body)."\r\n".
		"Authorization: Basic ".$encodedAuth."\r\n".
		"Content-Type: multipart/form-data; boundary=bbbbbbbbbb\r\n".
		"\r\n";

//"Content-Type: application/x-www-form-urlencoded\r\n".
$request = $req_header .$req_body;

echo "req:".$request;


//SSL接続の設定
$context = stream_context_create();
$result = stream_context_set_option($context, 'ssl', 'local_cert',local_cert );
$result = stream_context_set_option($context, 'ssl', 'passphrase',passphrase );
$result = stream_context_set_option($context, 'ssl', 'capath',capath);
//echo "result:".$result;
//APMSサーバへアクセス
$sock = stream_socket_client("ssl://" .host. ":443", $errno, $errstr ,30 , STREAM_CLIENT_CONNECT, $context);
if (!$sock) die("$errstr ($errno)\n");
fputs($sock, $request);
$data = array();
while (!feof($sock))
$data[] = trim(fgets($sock, 4096));
$eol_line = count($data) - 1;
$return = $data[$eol_line];
fclose($sock);

if ($result=="00")
{
		if ($return=="00")
		{
			echo "ok";
		}
		else
		{
			echo $return;
		}
}
else
{
	var_dump($data);
}
?>