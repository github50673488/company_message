<?php
class CommUtil {

	public static function sj_str($text) { // sjis 文字化け対策
		$str_arr = array('―','ソ','Ы','Ⅸ','噂','浬','欺','圭','構','蚕','十','申','曾','箪','貼','能','表','暴','予','禄','兔','喀','媾','彌','拿','杤','歃','濬','畚','秉','綵','臀','藹','觸','軆','鐔','饅','鷭','偆','砡',"");
		$text = str_replace("\\\\", "\\", $text); // ￥￥を￥に 2005.12.13
		for ($i = 0; $str_arr[$i] != ""; $i++) {
			$text = str_replace($str_arr[$i] . "\\", mb_substr($str_arr[$i], 0, 1), $text); // 先に\がついていたら消して
			$text = str_replace($str_arr[$i], $str_arr[$i] . "\\", $text); // \つける
		}
		return $text;
	}

	public static function Get_log($log, $log_dir="./log/")
	{
		$log_path = $log_dir.date("Ymd").".txt";
		$log_data = date("Y/m/d H:i:s")."\t".$log."\r\n";

		CommUtil::Convert_sjis($log_data);
		$handle = fopen($log_path, "a");
		flock($handle, LOCK_EX);
		fwrite($handle, $log_data);
		fclose($handle);
	}

	public static function check_time_str($timestr)
	{
		if(strlen($timestr)!=4) {return false;}
		$hour_str=substr($timestr,0,2);
		$min_str=substr($timestr,2,2);
		if (!is_numeric($hour_str) || !is_numeric($min_str) ) {return false;}
		if (($hour_str < 0 || $hour_str > 23) || ($min_str < 0 || $min_str > 59)){return false;}
		return true;
	}

	public static function getGpsStr($longitude,$latitude,$radius)
	{
		$a="+".CommUtil::changeMapFormat($longitude).",+".CommUtil::changeMapFormat($latitude);
		return $a.",".CommUtil::getRadiusStr($radius);
	}
	public static function getRadiusStr($radius)
	{
		$radius=intval($radius);
		$radiusStr = ''.$radius;
		$a=substr($radiusStr,strlen($radiusStr)-2,1);
		$a=$a>=5?5:0;
		$b=intval($radius/100);
		$b=$b==0?'':''.$b;
		return "".$b.$a."0";
	}

	public static function changeMapFormat($innum)
	{
		$EH = intval($innum);
		$EM = intval(($innum-$EH)*60);
		$ES = ($innum-$EH-($EM/60))*3600;
		$ESS = (round($ES*10)/10);
		if($EM<10){$EM = "0".$EM;}
		if($ESS<10){$ESS = "0".$ESS;}
		if(strrpos(($ESS.""), ".")===false){$ESS = $ESS.".0";}
		return $EH.'.'.$EM.'.'.$ESS;
	}

	public static function mail_check($mailaddress){
		if (preg_match('/^[a-zA-Z0-9_\.\-]+?@[A-Za-z0-9_\.\-]+$/',$mailaddress)) {
			return TRUE;
		}
		else{
			return FALSE;
		}
	}


	//formate:20080415
	public static function checkStartEndDateStr($startDateStr,$EndDateStr)
	{
		$err_msg=CommUtil::check_date($startDateStr);
		if ($err_msg!=""){return "開始".$err_msg;}		
		$err_msg=CommUtil::check_date($EndDateStr);
		if ($err_msg!="") {return $err_msg="終了".$err_msg;}
		if (strtotime(CommUtil::makeDBDateStr($startDateStr))>strtotime(CommUtil::makeDBDateStr($EndDateStr)))
		{
			return "正しい日付範囲を入力してください";
		}
		return "";
	}

	//formate:20080415
//	public static function check_date($date_str)
//	{
//		if (!is_integer($date_str)){return "日付を数字で入力してください。";}
//		if(strlen(trim($date_str))==0){return "日付を入力してください。";}
//		$year_str=substr($date_str,0,4);
//		$month_str=substr($date_str,4,2);
//		$day_str=substr($date_str,6,2);
//		if (!checkdate($month_str,$day_str,$year_str)) {return "日付を確認してください。";}
//		return "";
//	}

	
	public static function check_date($date_str)
	{
		$year_str=substr($date_str,0,4);
		$month_str=substr($date_str,4,2);
		$day_str=substr($date_str,6,2);

		if(strlen(trim($date_str))==0){return "日付を入力してください。";}
	    if (!preg_match("/^\d*$/",$year_str) || !preg_match("/^\d*$/",$month_str)||!preg_match("/^\d*$/",$day_str))
		{
			return "日付は数字で入力してください。";
		}
		if (!checkdate($month_str,$day_str,$year_str)) {return "日付を確認してください。";}
		return "";
	}

	//formate:20080415
	public static function makeDBDateStr($date_str)
	{
		$year_str=substr($date_str,0,4);
		$month_str=substr($date_str,4,2);
		$day_str=substr($date_str,6,2);
		return $year_str."-".$month_str."-".$day_str;
	}

	public static  function isDate($str,$format="Y/m/d"){
		$unixTime=strtotime($str);
		$checkDate= date($format,$unixTime);
		return $checkDate==$str;
	}

	public static function DeleteFile($path){
		$dh = opendir($path);
		while (false !== ($filename = readdir($dh))) {
			if ($filename == '.' || $filename == '..') {
				continue;
			}
			if (is_dir($path.$filename)) {
				DeleteFile($path.$filename."\\");
			} elseif (is_file($path.$filename)) {
				unlink($path.$filename);
			}
		}
		closedir($dh);
		rmdir($path);
	}


	public static function makePageLimitStr($page,$line)
	{
		if ($page<1) {return ''; }
		$start=($page-1)*$line;
		return ' limit '.$start.','.$line.' ';
	}

	public static function writeFile($file,$str,$mode='w')
	{
		$oldmask = @umask(0);
		$fp = @fopen($file,$mode);
		@flock($fp, 3);
		if(!$fp)
		{
			Return false;
		}
		else
		{
			@fwrite($fp,$str);
			@fclose($fp);
			@umask($oldmask);
			Return true;
		}
	}

	public static function  splitFile($filename,$size)
	{
		$i    = 1;
		$fp   = fopen($filename,"rb");
		while(!feof($fp))
		{
			$handle = fopen($filename.".J".CommUtil:: Pad_left("{$i}",2,"0"),"wb");
			fwrite($handle,fread($fp,$size));
			//fwrite($file,"datasplit.{$i}rn");
			fclose($handle);
			unset($handle);
			$i++;
		}
		fclose ($fp);
		return $i;
	}

	public static function ReadFile($FileName)
	{
		$file = fopen($FileName,"r");
		$size=filesize($FileName);
		$ip=fread($file,$size);
		fclose($file);
		return $ip;
	}

	//	■表示関連
	//--------------------------------------------------
	//	機能：配列からhidden文を作成
	//	引数：配列[name] = value、name指定
	public static function  Sethtml_hidden($array, $set_key=array())
	{
		if($array && is_array($array)) {
			foreach($array as $key => $value) {
				if(!$set_key || array_search($key, $set_key)!==false) {
					if(is_array($value)) {
						foreach($value as $key2 => $value2) echo "<input type=\"hidden\" name=\"".$key."[".$key2."]"."\" value=\"".$value2."\" />\r\n";
					}else {
						echo "<input type=\"hidden\" name=\"".$key."\" value=\"".$value."\" />\r\n";
					}
				}
			}
		}
	}

	//--------------------------------------------------
	//	機能：リスト表示
	//	引数：配列、ヘッダー、フッター
	public static function Sethtml_list($list, $header="", $footer="")
	{
		$result='';
		if($list && is_array($list)) {
			$result.= "<ul>";
			foreach($list as $value)
			{
				$result.=("<li>".$header.$value.$footer."</li>");
			}
			$result.= "</ul>";
		}else if($list) {
			$result.=("<p>".$header.$list.$footer."</p>");
		}
		return $result;
	}

	//--------------------------------------------------
	//	機能：エラーメッセージ表示
	//	引数：配列、ヘッダー、フッター
	public static function Sethtml_error($error, $header="", $footer="")
	{
		$errMsg='';
		if($error) {
			$errMsg.= "<div style=\"color:#FF0000;\">";
			$errMsg.= CommUtil::Sethtml_list($error, $header, $footer);
			$errMsg.= "</div>";
		}
		return $errMsg;
	}

	//--------------------------------------------------
	//	機能：リンクをセットする
	//	引数：href、リンク名、target、other
	public static function Sethtml_link($url, $linkname, $target="", $other="")
	{
		$target = (!$target || $target=="_self") ? "_self" : "_blank";
		echo ($url) ? "<a href=\"".$url."\" target=\"".$target."\" ".$other.">".$linkname."</a>" : $linkname;
	}



	//--------------------------------------------------
	//	機能：テキスト表示（改行コード->改行タグ）
	//	引数：文字列、改行コード、改行タグ
	public static function Sethtml_text($str, $code="\n", $tag="<br />")
	{
		$str = str_replace($code, $tag, $str);
		echo $str;
	}



	//--------------------------------------------------
	//	機能：ログインユーザーの権限チェック
	public static function Check_right_u($num)
	{
		return ($_SESSION["login"]["right_id"] < $num) ? true : false;
	}
	public static function Check_right_e($num)
	{
		return ($_SESSION["login"]["right_id"]==$num) ? true : false;
	}

	//--------------------------------------------------
	//	機能：選択した担当者情報を表示
	public static function Sethtml_charge()
	{
		?>

<form action="../charge.php" method="get">
<table cellpadding="0" cellspacing="0" style="width: 98%;">
	<tr>
		<td>企画回： <strong><?php echo 
		$_SESSION["charge"]["y"]; ?></strong> 年 <strong><?php echo 
		$_SESSION["charge"]["m"]; ?></strong> 月 <strong><?php echo 
		$_SESSION["charge"]["t"]; ?></strong> 回</td>
		<td>コース： <strong><?php echo $_SESSION["charge"]["course"]; ?></strong></td>
		<td>担当者コード： <strong><?php echo $_SESSION["charge"]["charge_code"]; ?></strong></td>
		<td style="text-align: right;"><input type="submit" value="担当者変更" /></td>
	</tr>
</table>
<input type="hidden" name="return"
	value="<?php echo Get_filebase($_SERVER['PHP_SELF']); ?>" /></form>
		<?php
	}




	//--------------------------------------------------
	//	機能：引数を表示しhiddenにセット
	public static function Sethtml_plushidden($value, $hidden_name, $num=false)
	{
		echo ($num) ? number_format($value) : $value;
		echo "<input type=\"hidden\" name=\"".$hidden_name."\" value=\"".$value."\" />";
	}


	//	■メール
	//--------------------------------------------------
	//	機能：メール送信（mb_send_mail）
	//	引数：件名、本文、送信者名、送信者メルアド、宛先、CC、BCC
	public static function Sendmail_mb($to, $from, $sender, $subject, $content, $cc="", $bcc="")
	{
		//if($sender) $sender = "=?iso-2022-jp?B?".base64_encode(mb_convert_encoding($sender, "iso-2022-jp", "UTF-8"))."?=";
		if($sender) $sender = mb_encode_mimeheader($sender);
		$header = "From: ".$sender."<".$from.">\r\n";
		if($cc) $header .= "Cc: ".$cc."\r\n";
		if($bcc) $header .= "Bcc: ".$bcc."\r\n";

		if(!mb_send_mail($to, $subject, $content, $header)) return false;
		return true;
	}

	//--------------------------------------------------
	//	機能：指定したファイルを読込み、出力用バッファの取得
	//	引数：ファイルパス、配列データ、配列名
	//	返値：出力用バッファ
	public static function Get_ob($file, $array_data, $array_name)
	{
		${$array_name} = $array_data;
		if(file_exists($file)) {
			ob_start();
			include($file);
			$contents = ob_get_contents();
			ob_end_clean();
		}
		return $contents;
	}

	//	■文字列関連
	//--------------------------------------------------
	//	機能：文字エンコーディング変換
	//	引数：文字列 or 配列、文字エンコーディング
	//-> SJIS
	public static function Convert_sjis(&$value, $from_enc="UTF-8")
	{
		mb_convert_variables("SJIS", $from_enc, $value);
	}
	public static function Convert_sjis_r($value, $from_enc="UTF-8")
	{
		mb_convert_variables("SJIS", $from_enc, $value);
		return $value;
	}
	//-> EUC-JP
	public static function Convert_ujis(&$value, $from_enc="UTF-8")
	{
		mb_convert_variables("EUC-JP", $from_enc, $value);
	}
	public static function Convert_ujis_r($value, $from_enc="UTF-8")
	{
		mb_convert_variables("EUC-JP", $from_enc, $value);
		return $value;
	}
	//-> UTF-8
	public static function Convert_utf8(&$value, $from_enc="EUC-JP")
	{
		mb_convert_variables("UTF-8", $from_enc, $value);
	}
	public static function Convert_utf8_r($value, $from_enc="EUC-JP")
	{
		mb_convert_variables("UTF-8", $from_enc, $value);
		return $value;
	}
	//--------------------------------------------------
	//	機能：htmlspecialcharsを配列に適用
	//	引数：文字列 or 配列
	public static function HSC_array($value)
	{
		return (is_array($value)) ? array_map("HSC_array", $value) : htmlspecialchars($value, ENT_QUOTES, "UTF-8");
	}
	//--------------------------------------------------
	//	機能：HTML特殊文字をデコード
	//	引数：文字列 or 配列
	//	返値：デコードした値
	public static function HSC_decode($value)
	{
		if(is_array($value)) {
			return array_map("HSC_decode", $value);
		}else {
			$table = get_html_translation_table(HTML_SPECIALCHARS, ENT_QUOTES);
			$table["'"] = htmlspecialchars("'", ENT_QUOTES, "UTF-8");  //&#39; -> &#039;
			return strtr($value, array_flip($table));
		}
	}
	//--------------------------------------------------
	//	機能：特殊文字（機種依存文字）を変換
	//	引数：文字列、タグ利用フラグ
	//	返値：変換した文字列
	public static function Replace_sp_str($str, $tag_use=false, $str_encoding="")
	{
		$sp_str = array(
		"Ⅰ"=>"I", "Ⅱ"=>"II", "Ⅲ"=>"III", "Ⅳ"=>"IV", "Ⅴ"=>"V", 
		"Ⅵ"=>"VI", "Ⅶ"=>"VII", "Ⅷ"=>"VIII", "Ⅸ"=>"IX", "Ⅹ"=>"X", 
		"ⅰ"=>"i", "ⅱ"=>"ii", "ⅲ"=>"iii", "ⅳ"=>"iv", "ⅴ"=>"v", 
		"ⅵ"=>"vi", "ⅶ"=>"vii", "ⅷ"=>"viii", "Ⅸ"=>"ix", "ⅹ"=>"x", 
		"①"=>"(1)", "②"=>"(2)", "③"=>"(3)", "④"=>"(4)", "⑤"=>"(5)", 
		"⑥"=>"(6)", "⑦"=>"(7)", "⑧"=>"(8)", "⑨"=>"(9)", "⑩"=>"(10)", 
		"⑪"=>"(11)", "⑫"=>"(12)", "⑬"=>"(13)", "⑭"=>"(14)", "⑮"=>"(15)", 
		"⑯"=>"(16)", "⑰" =>"(17)", "⑱"=>"(18)", "⑲"=>"(19)", "⑳"=>"(20)", 
		"㊤"=>"(上)", "㊥"=>"(中)", "㊦"=>"(下)", "㊧"=>"(左)", "㊨"=>"(右)", 
		"㍉"=>"ミリ", "㍍"=>"メートル", "㌔"=>"キロ", "㌘"=>"グラム", "㌧"=>"トン", 
		"㌦"=>"ドル", "㍑"=>"リットル", "㌫"=>"パーセント", "㌢"=>"センチ", 
		"㎝"=>"cm", "㎏"=>"kg", "㎡"=>"m2", "㏍"=>"K.K.", "℡"=>"TEL", "№"=>"No.", 
		"㍻"=>"平成", "㍼"=>"昭和", "㍽"=>"大正", "㍾"=>"明治", 
		"㈱"=>"(株)", "㈲"=>"(有)", "㈹"=>"(代)");
		if($tag_use) {
			$sp_str["㎡"] = "m<sup>2</sup>";
		}
		if($str_encoding) mb_convert_variables($str_encoding, "UTF-8");

		return str_replace(array_keys($sp_str), array_values($sp_str), $str);
	}
	//--------------------------------------------------
	//	機能：trimを配列に適用
	//	引数：文字列 or 配列
	public static function Trim_array($value)
	{
		return (is_array($value)) ? array_map("Trim_array", $value) : trim($value);
	}
	//--------------------------------------------------
	//	機能：文字列を丸める
	//	引数：文字列、文字数、語尾
	//	返値：丸めた文字列
	public static function Ellipsis_str($str, $size, $trimmarker, $encoding="UTF-8")
	{
		$size = $size*2;
		$size += substr_count($str, "\r");
		$size += substr_count($str, "\n");
		return (mb_strwidth($str, $encoding)>$size) ? mb_strimwidth($str, 0, $size, $trimmarker, $encoding) : $str;
	}
	//--------------------------------------------------
	//	機能：mb_convert_kanaを配列に適用
	public static function MB_convert_array(&$str, $option, $encoding)
	{
		if(is_array($str)) {
			foreach($str as $key => $value) $str[$key] = mb_convert_kana($str[$key], $option, $encoding);
		}else {
			$str = mb_convert_kana($str, $option, $encoding);
		}
		return $str;
	}
	//--------------------------------------------------
	//	機能：半角文字チェック
	public static function Check_str_sb($str)
	{
		$cstr = mb_convert_kana($str, "ahks", "UTF-8");
		return ($cstr==$str) ? true : false;
	}
	//--------------------------------------------------
	//	機能：全角文字チェック
	public static function Check_str_mb($str)
	{
		$cstr = mb_convert_kana($str, "AHKS", "UTF-8");
		return ($cstr==$str) ? true : false;
	}
	//--------------------------------------------------
	//	機能：str_pad() (left)
	public static function Pad_left($str, $length, $pad_str=" ")
	{
		return (string) str_pad($str, $length, $pad_str, STR_PAD_LEFT);
	}
	//--------------------------------------------------
	//	機能：日本語文字埋め
	public static function MB_pad($str, $pad_len, $pad_str=" ")
	{
		if(!$str) $str = "";
		$str_len = mb_strlen($str, "UTF-8");
		//指定文字数より多い場合切捨て
		if($str_len > $pad_len) {
			$str = mb_substr($str, 0, $pad_len, "UTF-8");
			//文字埋め
		}else {
			$len = $pad_len - $str_len;
			for($i=0;$i<$len;$i++) $str .= $pad_str;
		}
		return $str;
	}
	//--------------------------------------------------
	//	機能：文字列型の数値を整数型に変換
	public static function Change_int($int)
	{
		return (integer) $int ;
	}
	//--------------------------------------------------
	//	機能：文字列型のバイト数を求める（日本語2バイト、英文字１バイト）
	public static function StrLenB($str)
	{
		$byteLen = 0;
		$len = mb_strlen($str, 'UTF-8');
		for($i=0; $i<$len; $i++)
		{
			$item = mb_substr($str, $i, 1, "UTF-8");
			if(ord($item[0])>=128)
			{
				$byteLen +=2;
			}
			else
			{
				$byteLen++;
			}
		}
		return $byteLen;
	}
	//	■日付関連
	//--------------------------------------------------
	//	機能：日付のフォーマット
	//	引数：日付（配列可）、区切り文字、結合文字、月日2桁フラグ
	//	返値：フォーマットした日付
	public static function Format_date($date, $deli="-", $glue="", $zero=true, $encoding="")
	{
		if(!is_array($date)) {
			$date = ($deli=="") ? Explode_ymd($date) : explode($deli, $date);
		}
		if($zero) {
			$date[1] = sprintf("%02d", $date[1]);
			$date[2] = sprintf("%02d", $date[2]);
		}else {
			$date[1] = intval($date[1]);
			$date[2] = intval($date[2]);
		}
		return implode($glue, $date);
	}

	//--------------------------------------------------
	//	機能：年月日の分割
	//	引数：日付、区切り文字
	//	返値：array(0->年, 1->月, 2->日
	public static function Explode_ymd($date, $deli="")
	{
		$ymd = array();
		if($deli) {
			$ymd = explode($deli, $date);
		}else {
			$len = strlen($date);
			if(6 <= $len) {
				$ymd = array(substr($date, 0, 4), substr($date, 4, 2));
				if($len==7 || $len==8) $ymd[] = substr($date, 6);
			}
		}
		return $ymd;
	}

	//--------------------------------------------------
	//	機能：年(2桁)月日の分割
	//	引数：日付、区切り文字
	//	返値：array(0->年, 1->月, 2->日
	public static function Explode_y2md($date, $deli="")
	{
		$ymd = array();
		if($deli) {
			$ymd = explode($deli, $date);
		}else {
			$len = strlen($date);
			if(4 <= $len) {
				if($ymd <= 7) $date = substr($date, 2);
				$ymd = array(substr($date, 0, 2), substr($date, 2, 2));
				if($len==5 || $len==6) $ymd[] = substr($date, 4);
			}
		}
		return $ymd;
	}

	//--------------------------------------------------
	//	機能：日付が存在するかチェック
	//	引数：日付（配列可）、区切り文字
	//	返値：true or false
	public static function Check_dateExist($date, $deli="-")
	{
		if(!is_array($date)) $date = explode($deli, $date);
		$max = date("t", mktime(1, 1, 1, intval($date[1]), 1, intval($date[0])));
		if(intval($date[2]) > $max) return false;
		return true;
	}

	//--------------------------------------------------
	//	機能：曜日の取得
	//	引数：曜日（日曜から始まる配列）、日付（配列可）、区切り文字
	public static function Get_dayofweek($week, $date, $deli="-")
	{
		if(!is_array($date)) $date = explode($deli, $date);
		$w = date("w", mktime(1, 1, 1, intval($date[1]), intval($date[2]), intval($date[0])));
		return $week[$w];
	}

	//--------------------------------------------------
	//	機能：時間計測（マイクロ秒）
	public static function Get_microtime($st_time="")
	{
		list($msec, $sec) = explode(" ", microtime());
		$time = (float)$msec + (float)$sec;
		if($st_time) $time -= $st_time;
		return $time;
	}

	//	■ファイル関連
	//--------------------------------------------------
	//	機能：ファイル削除
	//	引数：ディレクトリ名、ファイル名（配列可）
	public static function Delete_file($dir, $file)
	{
		if($file && is_array($file)) {
			foreach($file as $value) {
				if($value && file_exists($dir.$value)) unlink($dir.$value);
			}
		}else if($file && file_exists($dir.$file)) {
			unlink($dir.$file);
		}
	}

	//--------------------------------------------------
	//	機能：ファイル名から拡張子を取得
	//	引数：ファイル名
	//	返値：拡張子（小文字）
	public static function Get_extension($file)
	{
		$ex = ($pos = strrpos($file, ".")) ? substr($file, $pos) : "";
		return strtolower($ex);
	}

	//--------------------------------------------------
	//	機能：ファイル名から拡張子以前を取得
	//	引数：ファイル名
	public static function Get_filebase($file)
	{
		$file = basename($file);
		return ($pos = strrpos($file, ".")) ? substr($file, 0, $pos) : "";
	}

	//--------------------------------------------------
	//	機能：ファイルサイズフォーマット
	//	引数：ファイルサイズ、小数点以下桁数
	public static function Format_size($size, $pre=0)
	{
		if($size > 1024*1024) $fsize = round($size/(1024*1024), $pre)." M";
		else if($size > 1024) $fsize = round($size/1024, $pre)." k";
		else $fsize = intval($size);
		return $fsize;
	}

	//--------------------------------------------------
	//	機能：ファイルサイズフォーマット(k)
	//	引数：ファイルサイズ、小数点以下桁数
	public static function Format_size_k($size, $pre=0)
	{
		return round($size/1024, $pre);
	}



	//	■データ関連
	//--------------------------------------------------
	//	機能：register_globals = on の場合GET,POST変数のグローバル登録を破棄
	public static function Unset_globals()
	{
		if(ini_get('register_globals')) {
			foreach(array_keys($_GET) as $key) unset($GLOBALS[$key]);
			foreach(array_keys($_POST) as $key) unset($GLOBALS[$key]);
		}
	}

	//--------------------------------------------------
	//	機能：GET,POST変数のクォート除去
	public static function Unquotes_str()
	{
		if(ini_get('magic_quotes_sybase')) {
			$_GET = str_replace("''", "'", $_GET);
			$_POST = str_replace("''", "'", $_POST);
		}else {
			$_GET = Stripslashes_array($_GET);
			$_POST = Stripslashes_array($_POST);
		}
	}

	//--------------------------------------------------
	//	機能：stripslashesを配列に適用
	public static function Stripslashes_array($value)
	{
		return (is_array($value)) ? array_map('Stripslashes_array', $value) : stripslashes($value);
	}

	//--------------------------------------------------
	//	機能：addslashesを配列に適用
	public static function Addslashes_array($value)
	{
		return (is_array($value)) ? array_map('Addslashes_array', $value) : addslashes($value);
	}

	//--------------------------------------------------
	//	機能：URIリダイレクト
	//	引数：相対URI or 絶対UR
	public static function Redirect_uri($uri="")
	{
		$loc = "location: ";
		if(strpos($uri, "http://")===false) {
			//host
			$loc .= "http://".$_SERVER['HTTP_HOST']."/";
			//dir（「../」の数分減らす）
			if($dir = trim(dirname($_SERVER['PHP_SELF']), "/\\")) {
				$dir_each = explode("/", $dir);
				$max = count($dir_each) - substr_count($uri, "../");
				$uri = str_replace("../", "", $uri);
				for($i=0;$i<$max;$i++){ $loc .= $dir_each[$i]."/"; }
			}
			//base
			if($uri=="") {
				$uri = basename($_SERVER['PHP_SELF']);
				if($_SERVER['QUERY_STRING']){ $uri .= "?".$_SERVER['QUERY_STRING'];	}
			}
		}
		$loc .= $uri;
		header($loc);
		exit;
	}

	//--------------------------------------------------
	//	機能：半角カナ文字チェック
	public static function Check_hankana($str)
	{
		$cha = array("ｱ","ｲ","ｳ","ｴ","ｵ",
                 "ｶ","ｷ","ｸ","ｹ","ｺ",
                 "ｻ","ｼ","ｽ","ｾ","ｿ",
                 "ﾀ","ﾁ","ﾂ","ﾃ","ﾄ",
                 "ﾅ","ﾆ","ﾇ","ﾈ","ﾉ",
                 "ﾊ","ﾋ","ﾌ","ﾍ","ﾎ",
                 "ﾏ","ﾐ","ﾑ","ﾒ","ﾓ",
                 "ﾗ","ﾘ","ﾙ","ﾚ","ﾛ",
                 "ﾔ","ﾕ","ﾖ","ﾜ","ﾝ","ﾟ","ﾞ"," ",
                 "1","2","3","4","5","6","7","8","9","0");
		/*
		 $cnt=0;
		 for ($i=0; $i<strlen($str); $i++){
		 for($j=0; $j<count($cha);$j++){
			if ((strcmp($str[$i],$cha[$j])==0)) {
			$cnt++;
			break;
			}
			}
			}
			if ($cnt == strlen($str))return ture;
			else return false;
			*/
		if (preg_match('/^(?:\xEF\xBD[\xA1-\xBF]|\xEF\xBE[\x80-\x9F]|[a-zA-Z0-9]|[\w-]|\s)+$/D', $str)) {
			return true;
		}
		else {
			return false;
		}
	}
	//--------------------------------------------------
	//	機能：全角文字チェック
	public static function Check_zenkaku($str)
	{
		if (!preg_match("/(?:\xEF\xBD[\xA1-\xBF]|\xEF\xBE[\x80-\x9F])|[\x20-\x7E]/", $str)) {
			return true;
		}
		else {
			return false;
		}
	}

	//テスト用
	public static function microtime_float ()
	{
		list ($msec, $sec) = explode(' ', microtime());
		$microtime = (float)$msec + (float)$sec;
		return $microtime;
	}

	public static function Get_week_start($ymd)
	{
		$ymdnum = mktime (0, 0 , 0 , intval(substr($ymd,2,2)), intval(substr($ymd,4,2)), intval('20'.substr($ymd,0,2)));
		$ymd_youbi = date("w",$ymdnum);
		$ymd_s = date("ymd",$ymdnum - 86400 * $ymd_youbi);
		return $ymd_s;
	}

	public static function Get_week_end($ymd)
	{
	 $ymdnum = mktime (0, 0 , 0 , intval(substr($ymd,2,2)), intval(substr($ymd,4,2)), intval('20'.substr($ymd,0,2)));
	 $ymd_youbi = date("w",$ymdnum);
	 $ymd_e = date("ymd",$ymdnum  + 86400 * (6 - $ymd_youbi));
	 return $ymd_e;
	}

}
?>