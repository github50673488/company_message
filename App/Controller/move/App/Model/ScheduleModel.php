<?php
require_once("../../Env/dbconn.class.php");
require_once("../../Env/Setting.php");
require_once("../Tools/CommUtil.php");
require_once("../Model/ParaModel.php");
require_once("ModelAction.php");
class ScheduleModel extends ModelAction{
	private  static  $scheduleModel=null;
	static function getInstant() {
	if (self::$scheduleModel==null){self::$scheduleModel=new ScheduleModel();}
	    return self::$scheduleModel;
	}
	
    function get_file_title($fileName)
	{
		$mysqli = DBConn::getConn ($sql);
		$sql="select  title from schedule where filename='".$fileName."'";
		$row=array();
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$result->close();
		}
		$mysqli->close ();
		return $row[0];
	}
    
	
	function checki_Pass($id,$i_password)
	{
		$mysqli = DBConn::getConn ($sql);
		$sql="select  count(-1) from schedule where kind=1 and id=".$id." and i_password='".$i_password."'";
		$row=array();
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$result->close();
		}
		$mysqli->close ();
		return $row[0]>0;
	}
	
	
    function getScheduleInfo($id)
	{
		$mysqli = DBConn::getConn ($sql);
		$sql="select  * from schedule where id=".$id;
		$row=array();
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array(MYSQLI_BOTH);
			$result->close();
		}
		$mysqli->close ();
		return $row;
	}
	
    function getiScheduleLst($user_id)
	{
		$mysqli = DBConn::getConn ();
		$sql="select DATE_FORMAT(a.entry_date,'%Y/%m/%d') as entry_date,c.title,c.filename from send_history a
inner join reserve b on a.reserve_id=b.id 
inner join schedule c on b.schedule =c.filename
where a.user_id='".$user_id."'  and c.kind=1 order by a.entry_date desc";
		
	  if ($result = $mysqli->query($sql)) {
	    	while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$scheduleArray[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $scheduleArray;
	}
	
	function select($where,$page) {
		$mysqli = DBConn::getConn ();
		$sql = " select a.id,a.s_id,DATE_FORMAT(a.create_date,'%Y/%m/%d') as create_date, 
		a.kind,case when a.kind=0 then 'スケジュール' else  'iスケジュール' end as kind_name,
		DATE_FORMAT(a.start_date,'%Y-%m-%d') as start_date,
		DATE_FORMAT(a.end_date,'%Y-%m-%d') as end_date,
		a.title,a.place,a.detail,a.parentid,a.create_user,a.update_user,a.filename,a.create_date as idx1
		 from schedule a
		 ".
		
		$sql.=$where." order by idx1 desc ";
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		$sql.= CommUtil::makePageLimitStr($page,$linePerPage);
		
	    if ($result = $mysqli->query($sql)) {
	    	while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$scheduleArray[] = $row;
			}
			$result->close();
		}
		$mysqli->close ();
		return $scheduleArray;
	}
	
	function getNameLst() {
		$mysqli = DBConn::getConn ();
		$sql = " select filename from schedule where kind!=2";
        
		$nameArray=array();
	    if ($result = $mysqli->query($sql)) {
	    	while($row = $result->fetch_array(MYSQLI_BOTH))
			{
				$nameArray[] = $row['filename'];
			}
			$result->close();
		}
		$mysqli->close ();
		return $nameArray;
	}
	
	function sid_chack($s_id) {
		$mysqli = DBConn::getConn ();
		$sql = "select count(-1) from schedule where s_id = '".$s_id."' AND kind IN (0,2)";
		
		$recordCount=0;
		if ($result = $mysqli->query($sql)) {
			$row = $result->fetch_array();
			$recordCount=$row[0];
			$result->close();
		}
		$mysqli->close ();
		
		if($recordCount > 0) {
			return false;
		}
		
		return true;
	}
	
     function getRecordCount($where) {
		$mysqli = DBConn::getConn ();
		$sql = "select count(-1) from schedule ".$where;
		
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
		$sql = "insert into schedule (s_id,create_date,kind,title,start_date,end_date,
		place,detail,update_user,create_user) values(?,now(), ?,?,?,?,?,?,?,?) ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ( "sisssssss", $registerArray ['s_id'], $registerArray ['kind'], $registerArray ['title'],
		$registerArray ['start_date'],$registerArray ['end_date'],$registerArray ['place'],
		$registerArray ['detail'],$registerArray ['update_user'],$registerArray ['create_user'] );
		$stmt->execute ();
		$insert_id=$mysqli->insert_id;
		$mysqli->close ();
		return $insert_id;
	}
	
  function i_register($registerArray, $s_id) {
		$mysqli = DBConn::getConn ();
		$sql = "insert into schedule (s_id,create_date,kind,title,update_user,create_user,i_password)
		 values(?,now(),?,?,?,?,?);";
		$stmt = $mysqli->prepare ($sql);
		$stmt->bind_param ( "sissss", $s_id, $registerArray ['kind'], $registerArray ['title'],
		$registerArray ['update_user'],$registerArray ['create_user'],$registerArray ['i_password']);
		$stmt->execute ();
		$insert_id=$mysqli->insert_id;
		$mysqli->close ();
		return $insert_id;
	}
	
    function i_child_register($registerArray) {
		$mysqli = DBConn::getConn ();
		$sql = "insert into schedule (s_id,create_date,kind,title,start_date,end_date,
		place,detail,update_user,create_user,parentid) values(?,now(), ?,?,?,?,?,?,?,?,?) ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ( "sisssssssi", $registerArray ['s_id'], $registerArray ['kind'], $registerArray ['title'],
		$registerArray ['start_date'],$registerArray ['end_date'],$registerArray ['place'],
		$registerArray ['detail'],$registerArray ['update_user'],$registerArray ['create_user'],
		$registerArray ['parentid']);
		$stmt->execute ();
		$mysqli->close ();
	}
	
    function i_child_add($addArray) {
		$mysqli = DBConn::getConn ();
		$sql = "insert into schedule (s_id,create_date,kind,title,start_date,end_date,
		place,detail,update_user,create_user,parentid) values(?,?,?,?,?,?,?,?,?,?,?) ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ( "ssisssssssi", $addArray ['s_id'], $addArray ['create_date'],$addArray['kind'], $addArray ['title'],
		$addArray ['start_date'],$addArray ['end_date'],$addArray ['place'],
		$addArray ['detail'],$addArray ['update_user'],$addArray ['create_user'],
		$addArray ['parentid']);
		$stmt->execute ();
		$mysqli->close ();
	}
	
    function del($id) {
		$mysqli = DBConn::getConn ();
		
        if ($dbResult = $mysqli->query("select filename from schedule  where kind=0 and id=".$id)) 
		{
			$row = $dbResult->fetch_array();
			$filename=$row[0];
			$dbResult->close();
		}
		
		$sql = "delete from schedule where (kind=0 and id=?) ";
		$stmt = $mysqli->prepare ($sql);
		$stmt->bind_param ( "i", $id );
		if ($stmt->execute ())
		{
			$filePath=schedule_path1.$filename;
			if(file_exists($filePath)){unlink($filePath);}		
		}
		$mysqli->close ();
	}
	
    function i_del($id,$isDeli_ScheduleRec) {
		$mysqli = DBConn::getConn ();
		
        if ($isDeli_ScheduleRec && $dbResult = $mysqli->query("select filename from schedule  where kind=1 and id=".$id)) 
		{
			$row = $dbResult->fetch_array();
			$filename=$row[0];
			$dbResult->close();
		}
		
		$sql = "delete from schedule where (parentid=? and kind=2) ";
		if ($isDeli_ScheduleRec){$sql .="or (kind=1 and id=?) ";} 
		$stmt = $mysqli->prepare ($sql);
		if ($isDeli_ScheduleRec)
		{
			$stmt->bind_param ( "ii", $id,$id );
		}
		else
		{
			$stmt->bind_param ( "i", $id );
		}
		$executeResult= $stmt->execute ();
		if ($isDeli_ScheduleRec && $executeResult)
		{
			$filePath=schedule_path1.$filename;
			if(file_exists($filePath)){unlink($filePath);}
		}
		$mysqli->close ();
	}
	
   function update_i_schedule_title($updateArray) {
		$mysqli = DBConn::getConn ();
		$sql = " update schedule set title=?,update_user=?,i_password=? where id=? ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ("sssi", $updateArray ['title'],
		$updateArray ['update_user'], $updateArray ['i_password'],
		$updateArray ['id']);
		$stmt->execute ();
		$mysqli->close ();
	}
	
    function update($updateArray) {
		$mysqli = DBConn::getConn ();
		$sql = " update schedule set s_id = ?,kind=?,title=?,start_date=?,end_date=?,
		place=?, detail=? ,update_user=? where id=? ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ("sissssssi", $updateArray ['s_id'],$updateArray ['kind'], $updateArray ['title'], 
		$updateArray ['start_date'],$updateArray ['end_date'],$updateArray ['place'],
		$updateArray ['detail'],$updateArray ['update_user'], $updateArray ['id']);	
		$stmt->execute ();
		$mysqli->close ();
	}
	
	function update_filepath($id, $filepath) {
		$mysqli = DBConn::getConn ();
		$sql = " update schedule set filename=? where id=? ;";
		$stmt = $mysqli->prepare ( $sql );
		$stmt->bind_param ("si", $filepath, $id);
		$result=$stmt->execute ();
		$mysqli->close ();
		return $result;
	}
	
	function getSuheduleID()// スケジュールID取得用 
	{
		//$req_body = "categoryid=O03&regcheck=0&cid01=".mybox_no."&testtype=01";// body部の作成
		$req_body = "categoryid=O03&regcheck=0&cid01=".ParaModel::getInstant()->get_para_value("mybox_no")."&testtype=01";// body部の作成
		
		// header部の作成
		// パスワード、ログインIDのbase64エンコーディング
		$iconcier_login_id=ParaModel::getInstant()->get_para_value("iconcier_login_id");
		$iconcier_login_password=ParaModel::getInstant()->get_para_value("iconcier_login_password");
		$encodedAuth=base64_encode($iconcier_login_id .":". $iconcier_login_password);
		$req_head = "POST /s/SrvCalIdRegist HTTP/1.1\r\n"
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
	    
	    $calid = "";
	    if($result=="00") {
	    	$detailcode = substr($headers[9],6);
	    	$calid = $detailcode;
	    } else { 
	    	// 失敗	echo
	    }
	    fclose($sock);
		return $calid;
	}
	
	function send_iSuhedule($iSuhedule, $suhedule_id, $id, $up_type){
		
		// $up_type = 1 新規登録,$up_type = 2 更新
		
		$date = date("Ymd")."T".date("Hi")."00Z";
		
		$data = "BEGIN:VCALENDAR\r\n"
				."VERSION:1.0\r\n"
				."X-WR-CALNAME;CHARSET=SHIFT_JIS:".mb_convert_encoding($iSuhedule['title'],"SJIS","UTF-8")."\r\n"
				."X-WR-RELCALID:".$suhedule_id."\r\n"
				."X-WR-CALDESC;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:\r\n"
				."X-DCM-LASTMODIFIED:".$date."\r\n";
		
		foreach($iSuhedule["schedule_list"] as $key => $regItem)
		{
			// 子スケジュール
			$detail = mb_convert_encoding($regItem['detail'],"SJIS","UTF-8");
			$title = mb_convert_encoding($regItem['title'],"SJIS","UTF-8");
			$location = mb_convert_encoding($regItem['place'],"SJIS","UTF-8");
			
			$data .= "BEGIN:VEVENT\r\n"
					."TZ:+09:00\r\n"
					."DTSTART:".date("Ymd",strtotime($regItem['start_date']))."T000000Z\r\n"  // 開始日
					."DTEND:".date("Ymd",strtotime($regItem['end_date']))."T000000Z\r\n"  // 終了日
					."DESCRIPTION;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:".$this->quoted_printable_encode2($detail)."\r\n"  //詳細
					."CATEGORIES:\r\n"
					."AALARM:\r\n"
					."DALARM:\r\n"
					."RRULE:\r\n"
					."SUMMARY;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:".$this->quoted_printable_encode2($title)."\r\n"  // 件名
					."LOCATION;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:".$this->quoted_printable_encode2($location)."\r\n"  // 場所
					."X-DCM-SID:".$regItem['s_id']."\r\n" // SID
					."X-DCM-ALLDAY:1\r\n"
					."LAST-MODIFIED:".$date."\r\n"
					."END:VEVENT\r\n";
		}
		
		$data .= "END:VCALENDAR\r\n";
		
		$res = false;
		
		// ファイルをアップロード
		$number = date("YmdHis");
		$filename = "i_schedule".$number.".vcs";

		$data_file = schedule_path1.$filename;  // ファイル名

		if ($fh=fopen("$data_file","w")) {
			if (flock($fh,LOCK_EX)) {
				fwrite($fh,$data);
				flock($fh,LOCK_UN);
				$res = true;
			} else {
				echo "flock error!!";
			}
			fclose($fh);
		} else {
			echo "open error!!";
		}
		
		$this->update_filepath($id, $filename);
		
		// マイボックスに送信
        if($up_type == 2) {
			// 更新を行うため、前回分の予約をキャンセルする。
			// body部の作成
			$req_body = "categoryid=O03&calid=".$suhedule_id;
			
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
		}
		
		// body部の作成
		$mybox_no=ParaModel::getInstant()->get_para_value("mybox_no");
		$req_body = "--bbbbbbbbbb\r\n".
	                "Content-Disposition: form-data; name=\"categoryid\"\r\n".
	                "\r\n".
	                "O03\r\n".
	                "--bbbbbbbbbb\r\n".
	                "Content-Disposition: form-data; name=\"kind\"\r\n".
	                "\r\n".
	                "0\r\n".
	                "--bbbbbbbbbb\r\n".
	                "Content-Disposition: form-data; name=\"calid\"\r\n".
	                "\r\n".
	                "".$suhedule_id."\r\n".
	                "--bbbbbbbbbb\r\n".
	                "Content-Disposition: form-data; name=\"cid01\"\r\n".
	                "\r\n".
	                "".$mybox_no."\r\n".
	                "--bbbbbbbbbb\r\n".
	                "Content-Disposition: form-data; name=\"updateday\"\r\n".
	                "\r\n".
	                "".date("Ymd",strtotime("+1 day"))."\r\n".
	                "--bbbbbbbbbb\r\n".
	                "Content-Disposition: form-data; name=\"attachfile\"; filename=\"iSchedule.vcs\"\r\n".
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
		$req_head = "POST /s/SrvSCntsUpdate HTTP/1.1\r\n"
					."Host: ".host_iconcier."\r\n"
					."Content-Type: multipart/form-data; boundary=bbbbbbbbbb\r\n"
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
		
		return $res;
	}
	
	function send_suhedule($suhedule,$id) {
		
		$date = date("Ymd")."T".date("Hi")."00Z";
		$detail = mb_convert_encoding($suhedule['detail'],"SJIS","UTF-8");
		$title = mb_convert_encoding($suhedule['title'],"SJIS","UTF-8");
		$location = mb_convert_encoding($suhedule['place'],"SJIS","UTF-8");
		
		$data = "BEGIN:VCALENDAR\r\n"
				."VERSION:1.0\r\n"
				."BEGIN:VEVENT\r\n"
				."TZ:+09:00\r\n"
				."DTSTART:".date("Ymd",strtotime($suhedule['start_date']))."T000000Z\r\n"  // 開始日
				."DTEND:".date("Ymd",strtotime($suhedule['end_date']))."T000000Z\r\n"  // 終了日
				."DESCRIPTION;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:".$this->quoted_printable_encode2($detail)."\r\n"  //詳細
				."CATEGORIES:\r\n"
				."AALARM:\r\n"
				."DALARM:\r\n"
				."RRULE:\r\n"
				."SUMMARY;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:".$this->quoted_printable_encode2($title)."\r\n"  // 件名
				."LOCATION;CHARSET=SHIFT_JIS;ENCODING=QUOTED-PRINTABLE:".$this->quoted_printable_encode2($location)."\r\n"  // 場所
				."X-DCM-SID:".$suhedule['s_id']."\r\n" // SID
				."X-DCM-ALLDAY:1\r\n"
				."LAST-MODIFIED:".$date."\r\n"
				."END:VEVENT\r\n"
				."END:VCALENDAR\r\n";
		
		$number = date("YmdHis");
		$filename = "schedule".$number.".vcs";

		$data_file = schedule_path1.$filename;  // ファイル名

		if ($fh=fopen("$data_file","w")) {
			if (flock($fh,LOCK_EX)) {
				fwrite($fh,$data);
				flock($fh,LOCK_UN);
			} else {
				echo "flock error!!";
				return false;
			}
			fclose($fh);
		} else {
			echo "open error!!";
			return false;
		}
		
		return $this->update_filepath($id, $filename);
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
	
	function getRandomString($nLengthRequired = 64){
	    $sCharList = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	    mt_srand();
	    $sRes = "";
	    for($i = 0; $i < $nLengthRequired; $i++)
	        $sRes .= $sCharList{mt_rand(0, strlen($sCharList) - 1)};
	    return $sRes;
	}
}

?>