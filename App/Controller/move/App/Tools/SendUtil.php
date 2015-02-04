<?php
require_once("../../Env/Setting.php");
require_once("../Model/ParaModel.php");
class SendUtil {

	public static function AddMyboxUser($eid, $date, $crypt, $cuid)
	{
		$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		$pswd  = "00000000";
		$req_body = "xp_id=" . urlencode($mybox_no) .
		"&eid=" . urlencode($eid).
		"&date=" . urlencode($date).
		"&crypt=" . urlencode($crypt).
		"&cuid=" . urlencode($cuid).
		"&pswd=" . urlencode($pswd);

		$basic_auth_id=ParaModel::getInstant()->get_para_value("basic_auth_id");
		$basic_auth_pswd=ParaModel::getInstant()->get_para_value("basic_auth_pswd");
		$encodedAuth=base64_encode($basic_auth_id .":".$basic_auth_pswd);

		$req_header= "POST /as HTTP/1.1\r\n".
		"Host: ".host."\r\n".
		"Authorization: Basic $encodedAuth\r\n".
		"Content-Length: " .strlen($req_body)."\r\n".
		"Content-Type: application/x-www-form-urlencoded\r\n".
		"\r\n";
		$request = $req_header.$req_body;

		$context = stream_context_create();
		$local_cert=ParaModel::getInstant()->get_para_value("local_cert");
		$passphrase=ParaModel::getInstant()->get_para_value("passphrase");
		$capath=ParaModel::getInstant()->get_para_value("capath");
		$result = stream_context_set_option($context, 'ssl', 'local_cert',$local_cert);
		$result = stream_context_set_option($context, 'ssl', 'passphrase',$passphrase);
		$result = stream_context_set_option($context, 'ssl', 'capath',$capath);

		$sock = stream_socket_client("ssl://" .host. ":443", $errno, $errstr ,30 , STREAM_CLIENT_CONNECT, $context);
		if (!$sock) die("$errstr ($errno)\n");

		$ret = fputs($sock, $request);

		$data = array();
		while (!feof($sock))
		$data[] = trim(fgets($sock, 4096));
		$eol_line = count($data) - 1;
		$result = $data[$eol_line];

		fclose($sock);
		return $result;
	}

	public static function DelMyboxUser($cuid)
	{
		//リクエストのボディ部を作成
		//取得したパラメータはURLエンコードを施す
		$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		$req_body = "xp_id=" . urlencode($mybox_no) .
		"&cuid=" . urlencode($cuid).
		"&rid=".rid_del_p.
		"&pid=".pid_p;

		$basic_auth_id=ParaModel::getInstant()->get_para_value("basic_auth_id");
		$basic_auth_pswd=ParaModel::getInstant()->get_para_value("basic_auth_pswd");
		$encodedAuth=base64_encode($basic_auth_id .":".$basic_auth_pswd);//Basic認証のID、パスワードをBase64でエンコード

		//ヘッダー部の作成
		$req_header= "POST /fc HTTP/1.1\r\n".
		"Host: ".host."\r\n".
		"Authorization: Basic $encodedAuth\r\n".
		"Content-Length: " .strlen($req_body)."\r\n".
		"Content-Type: application/x-www-form-urlencoded\r\n".
		"\r\n";
		$request = $req_header .$req_body;

		//SSL接続の設定
		$context = stream_context_create();
		$local_cert=ParaModel::getInstant()->get_para_value("local_cert");
		$passphrase=ParaModel::getInstant()->get_para_value("passphrase");
		$capath=ParaModel::getInstant()->get_para_value("capath");
		$result = stream_context_set_option($context, 'ssl', 'local_cert',$local_cert );
		$result = stream_context_set_option($context, 'ssl', 'passphrase',$passphrase );
		$result = stream_context_set_option($context, 'ssl', 'capath',$capath);

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
		return($return);
	}


	public static function DoGpsSend($member,$popup_msg,$send_date,$title,$free_word,$url,$area,$sdate,$stime,$edate,$etime)
	{
		print "<pre>";
		//リクエストのボディ部を作成
		//取得したパラメータはURLエンコードを施す
		$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		$req_body = "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"categoryid\"\r\n".
                "\r\n".
                "O05\r\n".
                "--bbbbbbbbbb\r\n".
			
	            "Content-Disposition: form-data; name=\"cnttype\"\r\n".
                "\r\n".
                "0\r\n".
                "--bbbbbbbbbb\r\n".

	            "Content-Disposition: form-data; name=\"userptn\"\r\n".
                "\r\n".
                "00\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"cid\"\r\n".
                "\r\n".
                "".$mybox_no."\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"popupfreewd\"\r\n".
                "\r\n".
                "".$popup_msg."\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"popupurl\"\r\n".
                "\r\n".
                "02\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"popupact\"\r\n".
                "\r\n".
                "10\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"inactinfodate\"\r\n".
                "\r\n".
                "".$send_date."\r\n".
                "--bbbbbbbbbb\r\n".
			

                "Content-Disposition: form-data; name=\"freewd1\"\r\n".
                "\r\n".
                "".$title."\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"freewd3\"\r\n".
                "\r\n".
                "".$free_word."\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"linkurl\"\r\n".
                "\r\n".
                "01;".$url."\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"cntsicon\"\r\n".
                "\r\n".
                "00\r\n".
                "--bbbbbbbbbb\r\n".

	            "Content-Disposition: form-data; name=\"sdate00\"\r\n".
                "\r\n".$sdate."\r\n".
                "--bbbbbbbbbb\r\n".

	            "Content-Disposition: form-data; name=\"stime00\"\r\n".
                "\r\n".$stime."\r\n".
                "--bbbbbbbbbb\r\n".

	            "Content-Disposition: form-data; name=\"edate00\"\r\n".
                "\r\n".$edate."\r\n".
                "--bbbbbbbbbb\r\n".

	            "Content-Disposition: form-data; name=\"etime00\"\r\n".
                "\r\n".$etime."\r\n".
                "--bbbbbbbbbb\r\n".

                "Content-Disposition: form-data; name=\"sendlistfile\"; filename=\"test.csv\"\r\n".
                "\r\n".
                "".$member."".
                "\r\n".
                "--bbbbbbbbbb\r\n".

	            "Content-Disposition: form-data; name=\"areafile\"; filename=\"wwww.csv\"\r\n".
	            "Content-Type: application/octet-stream\r\n".
                "\r\n".
                "".$area."".
	            "\r\n".
	            "--bbbbbbbbbb--\r\n";

		$iconcier_login_id=ParaModel::getInstant()->get_para_value("iconcier_login_id");
		$iconcier_login_password=ParaModel::getInstant()->get_para_value("iconcier_login_password");
		$encodedAuth=base64_encode($iconcier_login_id .":". $iconcier_login_password);
		$req_body=mb_convert_encoding($req_body, "SJIS", "UTF-8");

		//------------GPSヘッダー部の作成-----
		$req_header= "POST /s/SrvRTRegist HTTP/1.1\r\n".
		"Host: ".host_iconcier."\r\n".
		"Content-Type: multipart/form-data; boundary=bbbbbbbbbb\r\n".
		"Authorization: Basic ".$encodedAuth."\r\n".
		"Content-Length: ".strlen($req_body)."\r\n".
		"\r\n";

		$request = $req_header .$req_body;
		$context = stream_context_create();//SSL接続の設定
		$local_cert=ParaModel::getInstant()->get_para_value("local_cert");
		$passphrase=ParaModel::getInstant()->get_para_value("passphrase");
		$capath=ParaModel::getInstant()->get_para_value("capath");
		$result = stream_context_set_option($context, 'ssl', 'local_cert', $local_cert);
		$result = stream_context_set_option($context, 'ssl', 'passphrase', $passphrase);
		$result = stream_context_set_option($context, 'ssl', 'capath', $capath);

		//APMSサーバへアクセス
		$sock = stream_socket_client("ssl://" . host_iconcier. ":443", $errno, $errstr ,30 , STREAM_CLIENT_CONNECT, $context);
		if (!$sock) die("$errstr ($errno)\n");

		fputs($sock, $request);

		while (!feof($sock)){
			$headers[] = trim(fgets($sock, 4096));
		}
		fclose($sock);
		return $headers;
	}

	public static function DoIconcierSend($member,$popup_msg,$send_date,$title,$free_word,$url)
	{
		print "<pre>";
		$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		//リクエストのボディ部を作成
		$req_body = "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"categoryid\"\r\n".
                "\r\n".
                "O00\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"cid\"\r\n".
                "\r\n".
                "".$mybox_no."\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"popupfreewd\"\r\n".
                "\r\n".
                "".$popup_msg."\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"popupurl\"\r\n".
                "\r\n".
                "02\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"popupact\"\r\n".
                "\r\n".
                "10\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"inactinfodate\"\r\n".
                "\r\n".
                "".$send_date."\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"freewd1\"\r\n".
                "\r\n".
                "".$title."\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"freewd3\"\r\n".
                "\r\n".
                "".$free_word."\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"linkurl\"\r\n".
                "\r\n".
                "01;".$url."\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"cntsicon\"\r\n".
                "\r\n".
                "00\r\n".
                "--bbbbbbbbbb\r\n".
                "Content-Disposition: form-data; name=\"sendlistfile\"; filename=\"test.csv\"\r\n".
                "\r\n".
                "".$member."".
                "\r\n".
                "--bbbbbbbbbb--\r\n";

		$iconcier_login_id=ParaModel::getInstant()->get_para_value("iconcier_login_id");
		$iconcier_login_password=ParaModel::getInstant()->get_para_value("iconcier_login_password");
		$encodedAuth=base64_encode($iconcier_login_id .":". $iconcier_login_password);//Basic認証のID、パスワードをBase64でエンコード
		$req_body=mb_convert_encoding($req_body, "SJIS", "UTF-8");//SJISに文字コード変換

		//ヘッダー部の作成
		$req_header= "POST /s/SrvDMsgNRegist HTTP/1.1\r\n".
		"Host: ".host_iconcier."\r\n".
		"Authorization: Basic $encodedAuth\r\n".
		"Content-Length: " .strlen($req_body)."\r\n".
		"Content-Type: multipart/form-data; boundary=bbbbbbbbbb\r\n".
		"\r\n";
		$request = $req_header .$req_body;
		$context = stream_context_create();//SSL接続の設定
		$local_cert=ParaModel::getInstant()->get_para_value("local_cert");
		$passphrase=ParaModel::getInstant()->get_para_value("passphrase");
		$capath=ParaModel::getInstant()->get_para_value("capath");
		$result = stream_context_set_option($context, 'ssl', 'local_cert', $local_cert);
		$result = stream_context_set_option($context, 'ssl', 'passphrase', $passphrase);
		$result = stream_context_set_option($context, 'ssl', 'capath', $capath);

		//APMSサーバへアクセス
		$sock = stream_socket_client("ssl://" . host_iconcier. ":443", $errno, $errstr ,30 , STREAM_CLIENT_CONNECT, $context);
		if (!$sock) die("$errstr ($errno)\n");
		fputs($sock, $request);
		while (!feof($sock))
		{
			$headers[] = trim(fgets($sock, 4096));
		}
		fclose($sock);

		return $headers;
	}


	public static function DoMsg_rSend($title,$mem,$free_word)
	{
		$body_head = "# Comment\r\n\$KEYWD 0000000000000000\r\n\$SUBJECT ".$title."\r\n\r\n\$BEGIN\r\n\t\$USERS\r\n";
		$body_footer = "\t\$END-USERS\r\n\$END-BEGIN\r\n";
		$body_head = mb_convert_encoding($body_head, "SJIS", "UTF-8");
		$body = $body_head.$mem;
		$body = $body.$body_footer;
		$body = chunk_split(base64_encode($body));

		$message=
"--mimeboundary\r\n".
"Content-Type: text/plain; name=\"body.txt\"\r\n".
"Content-Transfer-Encoding: base64\r\n".
"Content-Disposition: attachment; filename=\"body.txt\"\r\n".
"\r\n".
"".$body."\r\n".
"--mimeboundary\r\n".
"Content-Type: text/plain; charset=\"ISO-2022-JP\"\r\n".
"Content-Transfer-Encoding: 7bit\r\n".
"X-MSGTYPE: PDCTEXT\r\n".
"\r\n".
"".$free_word."\r\n".
"--mimeboundary\r\n".
"Content-Type: text/plain; charset=\"ISO-2022-JP\"\r\n".
"Content-Transfer-Encoding: 7bit\r\n".
"X-MSGTYPE: FOMATEXT\r\n".
"\r\n".
"".$free_word."\r\n".
"--mimeboundary--\r\n";


		$to = msg_r_email_to;//宛先
$to = "k-ryu@navc2.co.jp";//宛先
		$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		$msg_r_password=ParaModel::getInstant()->get_para_value("msg_r_password");
		$msg_r_email_from=ParaModel::getInstant()->get_para_value("msg_r_email_from");
		$subject = $mybox_no.",".$msg_r_password; //題名
		$mail = new Qdmail();
		$mail -> smtp(true);
		$smtp_host=ParaModel::getInstant()->get_para_value("smtp_host");
		$smtp_port=ParaModel::getInstant()->get_para_value("smtp_port");
		$param = array(
'host'=>$smtp_host,
'port'=>$smtp_port,
'from'=>$msg_r_email_from,
'protocol'=>'SMTP',
		);

		$smtp = new QdSmtp($param);
		$mail ->smtpServer($param);
		$mail ->charsetBody('JIS');//2010/09/14 半角文字化け対応
		$mail ->timeZone( '+9000' );  // 日本時間の場合
		$mail ->to($to,'TO-ADDRESS');
		$mail ->subject($subject);
		$mail ->from('FROM-ADDRESS<'.$msg_r_email_from.'>');
		$mail ->text($message);
		$mail ->addHeader( 'Content-Type', 'multipart/mixed;boundary="mimeboundary"');
		$mail ->addHeader( 'Message-ID','message-id-000000000');
		$mail ->addHeader( 'X-MYBOXMSG', 'MIX');
		return $mail ->send(); // メール送信
	}

	public static function DoMailSend($mailaddr,$title,$body)
	{
		if (strlen($mailaddr)==0){return false;}
		mb_language("japanese");//言語設定、内部エンコーディングを指定する
		mb_internal_encoding("UTF-8");
		//----------------日本語HTMLメールを送る↓--------------------
		$mail = new JPHPMailer();
		$mail->IsSMTP();
		$smtp_host=ParaModel::getInstant()->get_para_value("smtp_host");
		$smtp_port=ParaModel::getInstant()->get_para_value("smtp_port");
		$mail->Host = $smtp_host.":".$smtp_port;
		$mail->addTo($mailaddr);//宛先
		$email_from=ParaModel::getInstant()->get_para_value("email_from");
		$email_send_name=ParaModel::getInstant()->get_para_value("email_send_name");
		$mail->setFrom($email_from,$email_send_name);//差出人
		$mail->setSubject($title);//題名
		$mail->setBody($body);//HTML本文

		return $mail->send();
	}

}
?>