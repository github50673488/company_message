<?php
require_once("../../Env/dbconn.class.php");
require_once("../Tools/CommUtil.php");
require_once("../../Env/Setting.php");
require_once("../Model/ParaModel.php");
require_once("ModelAction.php");
class TorukaModel extends ModelAction{
	private  static  $torukaModel=null;
	static function getInstant() {
		if (self::$torukaModel==null){self::$torukaModel=new TorukaModel();}
		return self::$torukaModel;
	}
	
	function getTorukaInfo($id)
	{
		return $this->getRow("select  * from toruka where id=".$id);
	}
	
    function getiTorukaLst($user_id)
	{
		$sql="select DATE_FORMAT(a.entry_date,'%Y/%m/%d') as entry_date,c.title,c.filename from send_history a 
inner join reserve b on a.reserve_id=b.id 
inner join toruka c on b.toruca =c.filename
where a.user_id='".$user_id."'  and c.kind=1 order by a.entry_date desc";
		return $this->getAll($sql);
	}
	
	function select($where,$page) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = " select a.id,DATE_FORMAT(a.create_date,'%Y/%m/%d') as create_date,
	 a.kind,case when a.kind=0 then '普通トルカ' else  'iトルカ' end as kind_name ,
	 a.title,a.subtitle,a.content,a.update_user,a.filename,b.name as create_user,
	 a.create_date as idx1
	 from toruka a
     left join user b on a.create_user=b.user_id   "
    .$where." order by idx1 desc ";
    $linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
    $sql.= CommUtil::makePageLimitStr($page,$linePerPage);

    if ($result = $mysqli->query($sql)) {
    	while($row = $result->fetch_array(MYSQLI_BOTH))
    	{
    		$torukaArray[] = $row;
    	}
    	$result->close();
    }
    $mysqli->close ();
    return $torukaArray;
	}

	function getNameLst() {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = " select filename from toruka  ;";

		$torukaArray=array();
		if ($result = $mysqli->query($sql)) {
			while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$torukaArray[] = $row['filename'];
			}
			$result->close();
		}
		$mysqli->close ();
		return $torukaArray;
	}


	function getRecordCount($where) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "select count(-1) from toruka ".$where;

		$recordCount=0;
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$recordCount=$row[0];
			$result->close();
		}
		$mysqli->close ();
		return $recordCount;
	}

	function register($registerArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = "insert into toruka (create_date,kind,title,subtitle,content,update_user,create_user)
        values(now(), ?,?,?,?,?,?) ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ( "isssss", $registerArray ['kind'], $registerArray ['title'],$registerArray ['subtitle'],
		$registerArray ['content'],$registerArray ['update_user'],$registerArray ['create_user'] );
		$stmt->execute ();
		$insert_id=$mysqli->insert_id;
		$mysqli->close ();

		return $insert_id;
	}

	function del($id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");

		if ($dbResult = $mysqli->query("select filename from toruka  where id=".$id)) 
		{
			$row = $dbResult->fetch_array();
			$filename=$row[0];
			$dbResult->close();
		}
		$stmt = $mysqli->prepare ("delete from toruka where id=?");
		$stmt->bind_param ( "i", $id );
		if ($stmt->execute ())
		{
			$filePath=toruka_path1.$filename;
			if(file_exists($filePath)){unlink($filePath);}		
		}
		$mysqli->close ();
	}

	function update($updateArray) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = " update toruka set kind=?,title=?,subtitle=?,content=?,update_user=? where id=? ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ("issssi", $updateArray ['kind'], $updateArray ['title'],
		$updateArray ['subtitle'], $updateArray ['content'],$updateArray ['update_user'], $updateArray ['id']);
		$stmt->execute ();
		$mysqli->close ();
	}

	function update_filepath($id, $filepath) {
		$mysqli = DBConn::getConn ();
		$sql = " update toruka set filename=? where id=? ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ("si", $filepath, $id);
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}

	function get_fileName($id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$sql = " select filename from toruka where id = ".$id." ;";
		
		if ($result = $mysqli->query($sql)) {
			while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$torukaArray[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $torukaArray[0]["filename"];
	}

	function send_toruka($toruka, $up_type) {
		// $up_type = 1 新規登録,$up_type = 2 更
		$date = date("ymdHi");
		$content = base64_encode(mb_convert_encoding($toruka['content'],"SJIS","UTF-8"));
		$title = base64_encode(mb_convert_encoding($toruka['title'],"SJIS","UTF-8"));
		$subtitle = base64_encode(mb_convert_encoding($toruka['subtitle'],"SJIS","UTF-8"));

		if ($up_type == 1) {
			$number = date("YmdHis");
			$filename = "toruka".$number.".trc";
		} else {
			// ファイル更新の場合、対象ファイルの取得
			$filename = $this->get_fileName($toruka['id']);
		}

		if ($toruka['kind'] == 1) {
			// トルカ（詳細）
			$data = "ToruCa\r\n"
			."Version: 2.1\r\n"
			."Type: card\r\n"
			."\r\n"
			."URL: http://dcm2.dmpw.jp/info/Upload/Toruka/".$filename."\r\n"// URL
			."Data1: ".$title."\r\n"  //タイトル
			."Data2: ".$content."\r\n"//本文
			."Data3: ".$subtitle."\r\n"//サブタイトル
			."Cat: 004C\r\n"
			."IP-ID: ".$toruka['id']."\r\n"
			."Sort-ID: \r\n"
			."Dist: 4\r\n"
			."Color-ID: 2\r\n"
			."LM: ".$date."\r\n"
			."\r\n";
		} else {
			// トルカ（詳細）
			$data = "ToruCa\r\n"
			."Version: 2.1\r\n"
			."Type: snip\r\n"
			."\r\n"
			."URL: http://dcm2.dmpw.jp/info/Upload/Toruka/".$filename."\r\n"// URL
			."Data1: ".$title."\r\n"  //タイトル
			."Data2: ".$content."\r\n"//本文
			."Data3: ".$subtitle."\r\n"//サブタイトル
			."Cat: 004C\r\n"
			."IP-ID: ".$toruka['id']."\r\n"
			."Sort-ID: \r\n"
			."Dist: 4\r\n"
			."Color-ID: 2\r\n"
			."LM: ".$date."\r\n"
			."\r\n";
		}

		$data_file = toruka_path1.$filename;  // ファイル名
		$res = true;
		if ($fh=fopen("$data_file","w")) {
			if (flock($fh,LOCK_EX)) {
				fwrite($fh,$data);
				flock($fh,LOCK_UN);
			} else {
				$res = false;
				echo "flock error!!";
			}
			fclose($fh);
		} else {
			$res = false;
			echo "open error!!";
		}
        $mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		if ($toruka['kind'] == 1) {
			// iトルカマイボックス送信処理
			
			if($up_type == 1) {
				// 新規登録
				// body部の作成
				$req_body = "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"categoryid\"\r\n".
			                "\r\n".
			                "O04\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"regcheck\"\r\n".
			                "\r\n".
			                "0\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"cid01\"\r\n".
			                "\r\n".
			                "".$mybox_no."\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"updateday\"\r\n".
			                "\r\n".
			                "".date("Ymd",strtotime("+1 day"))."\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"attachfile\"; filename=\"toruka.trc\"\r\n".
			                "Content-Type: application/octet-stream\r\n".
			                "\r\n".
			                "".$data."".
			                "\r\n".
			                "--bbbbbbbbbb--\r\n";

				// header部の作成
				// パスワード、ログインIDのbase64エンコーディング
				$iconcier_login_id=ParaModel::getInstant()->get_para_value("iconcier_login_id");
				$iconcier_login_password=ParaModel::getInstant()->get_para_value("iconcier_login_password");
				$encodedAuth=base64_encode($iconcier_login_id .":". $iconcier_login_password);
				$req_head = "POST /s/SrvTrcRegist HTTP/1.1\r\n"
				."Host: ".host_iconcier."\r\n"
				."Content-Type: multipart/form-data; boundary=bbbbbbbbbb\r\n"
				."Authorization: Basic ".$encodedAuth."\r\n"
				."Content-Length: ".strlen($req_body)."\r\n"
				."\r\n";

				$request = $req_head .$req_body;

			} else {
				// 更新登録
				// 更新を行うため、前回分の予約をキャンセルする。
				// body部の作成
				$req_body = "categoryid=O04&torucaurl=http://dcm2.dmpw.jp/info/Upload/Toruka/".$filename."&torucaipid=".$toruka['id'];

				// header部の作成
				// パスワード、ログインIDのbase64エンコーディング
				$iconcier_login_id=ParaModel::getInstant()->get_para_value("iconcier_login_id");
				$iconcier_login_password=ParaModel::getInstant()->get_para_value("iconcier_login_password");
				$encodedAuth=base64_encode($iconcier_login_id .":". $iconcier_login_password);
				$req_head = "POST /s/SrvSCntsCancel HTTP/1.1\r\n"
				."Host: ".host_iconcier."\r\n"
				."Content-Type: application/x-www-form-urlencoded\r\n"
				."Authorization: Basic ".$encodedAuth."\r\n"
				."Content-Length: " .strlen($req_body)."\r\n"
				."\r\n";

				$request = $req_head .$req_body;

				//SSL接続の設定
				$context = stream_context_create();
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
				 
				if($result=="00") {
					$res = true;
				} else {
					// 失敗
					$res = false;
				}
				fclose($sock);
				 
				$request = "";
				 
				// 次を投げる前に5秒待つ
				sleep(5);
				 
				// body部の作成
				// body部の作成
				$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
				$req_body = "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"categoryid\"\r\n".
			                "\r\n".
			                "O04\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"regcheck\"\r\n".
			                "\r\n".
			                "0\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"cid01\"\r\n".
			                "\r\n".
			                "".$mybox_no."\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"updateday\"\r\n".
			                "\r\n".
			                "".date("Ymd",strtotime("+1 day"))."\r\n".
			                "--bbbbbbbbbb\r\n".
			                "Content-Disposition: form-data; name=\"attachfile\"; filename=\"toruka.trc\"\r\n".
			                "Content-Type: application/octet-stream\r\n".
			                "\r\n".
			                "".$data."".
			                "\r\n".
			                "--bbbbbbbbbb--\r\n";

				// header部の作成
				// パスワード、ログインIDのbase64エンコーディング]
				$iconcier_login_id=ParaModel::getInstant()->get_para_value("iconcier_login_id");
				$iconcier_login_password=ParaModel::getInstant()->get_para_value("iconcier_login_password");
				$encodedAuth=base64_encode($iconcier_login_id .":". $iconcier_login_password);
				$req_head = "POST /s/SrvTrcRegist HTTP/1.1\r\n"
				."Host: ".host_iconcier."\r\n"
				."Content-Type: multipart/form-data; boundary=bbbbbbbbbb\r\n"
				."Authorization: Basic ".$encodedAuth."\r\n"
				."Content-Length: ".strlen($req_body)."\r\n"
				."\r\n";

				$request = $req_head .$req_body;
			}
				
			//SSL接続の設定
			$context = stream_context_create();
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

			if($result=="00") {
                echo "ssl fail";
			} else {
				// 失敗
				return false;
			}
			fclose($sock);
		}
		return $this->update_filepath($toruka['id'], $filename);
	}

	function quoted_printable_encode2($str)
	{
		$crlf="\r\n";

		$str=trim($str);

		$lines   = preg_split("/(\r\n|\n|\r)/s", $str);
		$out     = '';
		$temp = '';
		foreach ($lines as $line)
		{
			for ($j = 0; $j < strlen($line); $j++)
			{
				$char = substr ( $line, $j, 1 );
				$ascii = ord ( $char );

				if ( $ascii < 32 || $ascii == 61 || $ascii > 126 )
				{
					$char = '=' . strtoupper ( dechex( $ascii ) );
				}

				if ( ( strlen ( $temp ) + strlen ( $char ) ) >= 76 )
				{
					$out .= $temp . '=' . $crlf;   $temp = '';
				}
				$temp .= $char;
			}
		}
		$out .= $temp;

		return trim ( $out );
	}
}

?>