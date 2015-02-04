<?php
error_reporting(2039);//for qdmail
require_once("Controller_Action.php");
require_once('./include/qdmail.php');
require_once('./include/qdsmtp.php');
require_once('./include/jphpmailer.php');
require_once ("../Model/ScheduleModel.php");
require_once ("../Model/TorukaModel.php");
require_once ("../Model/UserModel.php");
require_once ("../Model/GroupModel.php");
require_once ("../Model/ReserveModel.php");
require_once ("../Model/AccessCountModel.php");
require_once ("../Model/SendHistoryModel.php");
require_once ("../Tools/SendUtil.php");
require_once ("../Tools/CommUtil.php");
require_once("../../Env/Setting.php");
require_once("../Model/ParaModel.php");

class SendMessageController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_back"]=$this->getUrl('Main','main_menu');
		session_start();//session使用
	}
	
	function addgroupAction() {
		if (isset($_POST["btn_cancel_change"]))
		{
			$_POST["send_userids"]=$_SESSION["send_userids"];//send画面のユーザリストを復元
			$this->forward("SendMessage","send");
			return;
		}
	    else if (isset($_POST["btn_select_gp"]))
		{
			$this->forward("SendMessage","adduser");
			return;
		}
		if (isset($_POST["btn_add_user"]))//==>send画面から,send画面のデータをsessionに保存
		{
			$_SESSION["send_userids"]=$_POST["send_userids"];
			$_SESSION["title"]=$_POST["title"];
			$_SESSION["free_word"]=$_POST["free_word"];
			$_SESSION["detail"]=$_POST["detail"];
			//$_SESSION["address"]=$_POST["address"];//liu 2010/08/23
			$_SESSION["longitude"]=$_POST["longitude"];
			$_SESSION["latitude"]=$_POST["latitude"];
			$_SESSION["radius"]=$_POST["radius"];
			$_SESSION["sdate"]=$_POST["sdate"];
			$_SESSION["edate"]=$_POST["edate"];
			$_SESSION["stime"]=$_POST["stime"];
			$_SESSION["etime"]=$_POST["etime"];
			$_SESSION["file_name"]=$_POST["addfile"];
			$_SESSION["isgpsview"]=$_POST["isgpsview"];
		}
		
		$gp_list=GroupModel::getInstant()->selectGp();
		
		$user_list=array();
		$gpname_list=array();
		$i=0;
		foreach ($gp_list as $gp)
		{
			$gp_list[$i]['is_gp_select']=$this->findGpSelect($gp["id"],$_POST["send_groupids"]);//
			if ($gp_list[$i]['is_gp_select'])
			{
				$gpname_list[$gp["id"]]=$gp["group_name"];
			}
			$i++;
		}
        $this->formBean["is_exist_group"]=count($gp_list)>0;
		$this->formBean["gp_list"]=$gp_list;
		$this->formBean["gpname_list"]=$gpname_list;
		$this->formBean["to_add_group"]=$this->getUrl("SendMessage","addgroup");
	}

	function adduserAction() {
		if (isset($_POST["btn_cancel_change"]))
		{
			$_POST["send_userids"]=$_SESSION["send_userids"];//send画面のユーザリストを復元
			$this->forward("SendMessage","send");
			return;
		}
		else if (isset($_POST["btn_change_user_list"]))
		{
			$this->forward("SendMessage","send");
			return;
		}
		
		$gp_list=GroupModel::getInstant()->selectGp();
		$user_list=array();
		$gpname_list=array();
		$i=0;
		foreach ($gp_list as $gp)
		{
			$gp_list[$i]['is_gp_select']=$this->findGpSelect($gp["id"],$_POST["send_groupids"]);//
			if ($gp_list[$i]['is_gp_select'])
			{
				$userOfGroup=UserModel::getInstant()->getGroupUserInfo($gp["id"]);
				if (count($userOfGroup)>0)
				{
					$j=0;
					foreach($userOfGroup as $user )
					{
						$userOfGroup[$j]['is_user_select']=$this->findUserSelect($user["user_id"],$_SESSION["send_userids"]);
						$j++;
					}
				}
				$user_list[$gp["id"]]=$userOfGroup;
				$gpname_list[$gp["id"]]=$gp["group_name"];
			}
			$i++;
		}
		$this->formBean["is_exist_user"]=count($user_list)>0;
		$this->formBean["gp_list"]=$gp_list;
		$this->formBean["gpname_list"]=$gpname_list;
		$this->formBean["to_add_user"]=$this->getUrl("SendMessage","adduser");
		$this->formBean["user_list"]=$user_list;
	}

	private function findGpSelect($gp_id,$select_groupids)
	{
		if (!isset($select_groupids)|| count($select_groupids)==0){return false;}
		foreach ($select_groupids as $groupid)
		{
			if ($gp_id==$groupid) {return true;}
		}
		return false;
	}

	private function findUserSelect($user_id,$select_userids)
	{
		if (!isset($select_userids)|| count($select_userids)==0){return false;}
		foreach ($select_userids as $uid)
		{
			if ($user_id==$uid) {return true;}
		}
		return false;
	}

	function sendAction() {
		$this->formBean["isfileselect"]=0;
		$isFromUedit=(isset($_POST["btn_change_user_list"])||isset($_POST["btn_cancel_change"]));//配信者変更画面からかどうか
		$isFromOperArea=(isset($_REQUEST["do_openarea"])&&$_REQUEST["do_openarea"]==1);
		if (isset($_POST["t_makemessage"])||isset($_POST["s_makemessage"]))//トルカ、スゲジュール画面から
		{
			$this->formBean["file_name"]=$_POST["filename"];
			$this->formBean["isfileselect"]=1;
		}
		//===>メッセージリスト画面返信機能から
		else if (isset($_POST["is_from_msg_list"])&& $_POST["is_from_msg_list"]==1)
		{
			$_POST["send_userids"]=SendHistoryModel::getInstant()->getReserveUserLst($_POST["reserve_id"]);
		}
		//------------------------liu 2010/08/23 add ↓----------------------
	    else if($isFromOperArea)
		{
			$this->formBean["longitude"]=$_POST["LAT"];//ごめんなさい、変数の名前が間違えました。
			$this->formBean["latitude"]=$_POST["LON"];
		}
		//------------------------liu 2010/08/23 add ↑----------------------
		

		$this->formBean["title"]=$isFromUedit?$_SESSION["title"]:"";
		$this->formBean["free_word"]=$isFromUedit?$_SESSION["free_word"]:"";
		$this->formBean["detail"]=$isFromUedit?$_SESSION["detail"]:"";
		//$this->formBean["address"]=$isFromUedit?$_SESSION["address"]:"熊本市　小山";//liu 2010/08/23 del
		
		//------------------------liu 2010/08/23  ↓----------------------
//		$this->formBean["longitude"]=$isFromUedit?$_SESSION["longitude"]:"32.8320206";
//		$this->formBean["latitude"]=$isFromUedit?$_SESSION["latitude"]:"130.8171751";
        if ($isFromUedit)
        {
          $this->formBean["longitude"]=$_SESSION["longitude"];
          $this->formBean["latitude"]=$_SESSION["latitude"];
        }
        //------------------------liu 2010/08/23  ↓----------------------

		$this->formBean["radius"]=$isFromUedit?$_SESSION["radius"]:"5000";
		$this->formBean["sdate"]=$isFromUedit?$_SESSION["sdate"]:date("Ymd");
		$this->formBean["edate"]=$isFromUedit?$_SESSION["edate"]:date("Ymd");
		$this->formBean["stime"]=$isFromUedit?$_SESSION["stime"]:date('Hi',strtotime("+5 minute"));
		$this->formBean["etime"]=$isFromUedit?$_SESSION["etime"]:date('Hi',strtotime("+65 minute"));
		$this->formBean["isgpsview"]=$isFromUedit?$_SESSION["isgpsview"]:0;
		if ($isFromOperArea) 
		{
			$this->formBean["isgpsview"]=1;
			$this->formBean["isFromOperArea"]=1;
			
		}//liu 2010/08/23 add

		if ($isFromUedit&& isset($_SESSION["file_name"])&& $_SESSION["file_name"]!=-1)
		{
			$this->formBean["isfileselect"]=1;
			$this->formBean["file_name"]=$_SESSION["file_name"];
		}
		$file_name_list=array();
		$scnamelist=ScheduleModel::getInstant()->getNameLst();
		foreach ($scnamelist as $name)
		{
			$file_name_list[]=$name;
		}
		$torukanamelist=TorukaModel::getInstant()->getNameLst();
		foreach ($torukanamelist as $name)
		{
			$file_name_list[]=$name;
		}
		$this->formBean["file_name_list"]=$file_name_list;
		$this->formBean["to_map"]=ParaModel::getInstant()->get_para_value("map_url");;
		$this->formBean["confirmErr"]=$_POST["confirmErr"];
		$this->formBean["to_confirm"]=$this->getUrl("SendMessage","confirm");
		$this->formBean["to_myself"]=$this->getUrl("SendMessage","send");
		$this->formBean["to_add_group"]= $this->getUrl("SendMessage","addgroup");
		$this->formBean["user_list"]= $this->getSendUsersInfo($_POST["send_userids"]);//ユーザ追加画面選択されたユーザ
		
		$this->formBean["operarea_url"]="http://w1m.docomo.ne.jp/cp/iarea?ecode=OPENAREACODE&msn=OPENAREAKEY".
		"&nl=http://dcm2.dmpw.jp/info/App/Controller/move/App/Controller/default.php".
		"&arg1=PHPSESSID%3D".$_REQUEST['PHPSESSID'].
		"&arg2=do_openarea%3D1".
		"&posinfo=1";//liu 2010/08/23 
		
		
	}

	private function getSendUsersInfo($select_userids)
	{
		if (!isset($select_userids) || count($select_userids)==0 ){return array();}
		return UserModel::getInstant()->getUserInfoByUidList($select_userids);
	}

	function confirmAction() {
		if (isset($_POST["testsend"]))
		{
			$testSendErr=$this->getTestSendErr($_POST["testuserid"],$_POST["testmailaddr"]);
			if (strlen(trim($testSendErr))>0)
			{
				$_POST['confirmErr']=$testSendErr;
				$this->forward("SendMessage","confirmerr");
			}
			else
			{
				//$area=CommUtil::getGpsStr($_POST["longitude"],$_POST["latitude"],$_POST["radius"]);// liu 2010/08/23
				$area=CommUtil::getGpsStr1($_POST["longitude"],$_POST["latitude"],$_POST["radius"]);// liu 2010/08/23
				$this->testSend($_POST["testuserid"],$_POST["testmailaddr"],$_POST["title"],$_POST["free_word"],
				$this->makeHtmlFile($_POST["detail"],$_POST["addfile"]),$_POST["sendmode"]==2,
				$area,
				$_POST["sdate"],$_POST["stime"],$_POST["edate"],$_POST["etime"]);
				
			}
			return;
		}

		elseif(isset($_POST["upd"]))//配信
		{
			$info_name=$this->makeHtmlFile($_POST["detail"],$_POST["addfile"]);
			if(AccessCountModel::getInstant()->insert(array("free_word"=>$_POST["free_word"],"url"=>$info_name,"count" =>0)))
			{
				CommUtil::Get_log("情報配信(ＵＲＬ)登録\tＵＲＬ：".$info_name);
			}
			$this->startReserveSend($info_name,$_POST["send_userids"],$_POST["user_sendways"],
			$_POST["sendmode"],$_POST["addfile"], $_POST["title"], $_POST["free_word"], $_POST["detail"]);
			return;
		}

		$is_GPS= $_POST['sendmode']==2;
		$this->formBean["is_GPS"]=$is_GPS;
		if ($is_GPS)//ＧＰＳ配信入力チェック
		{
			$gpsErr=$this->getGpsErr($_POST['longitude'],$_POST['latitude'],
			$_POST['radius'],$_POST['sdate'],$_POST['edate'],$_POST['stime'],$_POST['etime']);
			if (strlen(trim($gpsErr))!=0)
			{
				$_POST['confirmErr']=$gpsErr;
				$this->forward("SendMessage","confirmerr");
				return;
			}
			$this->loadGpsView($_POST['longitude'],$_POST['latitude'],
			$_POST['radius'],$_POST['sdate'],$_POST['edate'],$_POST['stime'],$_POST['etime']);
		}

		//---------------------------送信情報表示---------------------
		$this->formBean["title"]=$_POST['title'];
		$this->formBean["sendmode"]=$_POST['sendmode'];
		$this->formBean["sendmode_str"]=$is_GPS?'GPS配信':'通常配信';
		$this->formBean["free_word"]=$_POST['free_word'];
		$this->formBean["detail"]=$_POST['detail'];
		$this->formBean["send_userids_name"]=implode("、", $_POST['send_userids_name']);
		$this->formBean["user_sendways"]=$_POST['user_sendways'];
		$this->formBean["send_userids"]=$_POST['send_userids'];
		$this->formBean["addfile"]=$_POST['addfile'];
		$this->formBean["addfile1"]=$_POST['addfile']==-1?"":$_POST['addfile'];
	}

	private function getGpsErr($longitude,$latitude,$radius,$sdate,$edate,$stime,$etime)//dateformat:20090401,timeformat:0940
	{
		if (strlen(trim($longitude))==0||strlen(trim($latitude))==0
		||strlen(trim($radius))==0||strlen(trim($sdate))==0||strlen(trim($edate))==0)
		{
			return "全部ＧＰＳアイテムを入力してください";	
		}
//		if (!is_numeric($longitude)||!is_numeric($latitude)||!is_numeric($radius)||!is_numeric($sdate)
//		||!is_numeric($edate)||!is_numeric($stime)||!is_numeric($etime))
		if (!is_numeric($radius)||!is_numeric($sdate)||!is_numeric($edate)||!is_numeric($stime)||!is_numeric($etime))
		{
			return "ＧＰＳアイテムを数字で入力してください";
		}
		if(!preg_match("/^[| 0-9 |\+\.]+$/",$longitude)||!preg_match("/^[| 0-9 |\+\.]+$/",$latitude))
		{
			return "正しい緯度、経度を入力してください。";
		}
		
		//if ($longitude<23.420922222222||$longitude>46.085675833333){return "日本国内の緯度を入力して下さい";}//liu 2010/08/23 del
		//if ($latitude<122.24856277778||$latitude>149.12034138889){return "日本国内の経度を入力して下さい";}//liu 2010/08/23 del
		if ($radius<50||$radius>10000){return "正しい半径を入力して下さい";}
		$dateErr=CommUtil::checkStartEndDateStr($sdate,$edate);
		if (strlen($dateErr)>0){return $dateErr;}
		if ($sdate<date("Ymd")||$sdate<date("Ymd")){return "現在日以降の日付を入力してください";}
		if (strtotime(CommUtil::makeDBDateStr($sdate))>= strtotime("+92 day")
		||strtotime(CommUtil::makeDBDateStr($edate))>= strtotime("+92 day"))
		{
			return "現在日 + 有効期間指定上限日( 92日 )範囲以内を入力して下さい";
		}
		if (!CommUtil::check_time_str($stime) || !CommUtil::check_time_str($etime)){return "正しい時間フォーマットで入力してください";}
		if ($stime>$etime){return "開始時刻以降の終了時刻を入力してください";}
		if (($sdate.$stime)<(date("YmdHi"))){return "現在時刻以降の時刻を入力してください";}  
		//if (($stime+10)>$etime){return "開始時刻10分以降の終了時刻を入力してください";}
		return "";
	}

	private function loadGpsView($longitude,$latitude,$radius,$sdate,$edate,$stime,$etime)
	{
		$this->formBean["longitude"]=$longitude;
		$this->formBean["latitude"]=$latitude;
		$this->formBean["radius"]=$radius;
		$this->formBean["sdate"]=$sdate;
		$this->formBean["edate"]=$edate;
		$this->formBean["stime"]=$stime;
		$this->formBean["etime"]=$etime;
	}

	private function getTestSendErr($testUserId,$testMail)
	{
		if (strlen(trim($testUserId))==0  && strlen(trim($testMail))==0) {return "テスト対象を入力してください";}
		if (strlen(trim($testMail))>0 && !CommUtil::mail_check($testMail)) {return "正しいメールアドレスを入力ください";}
		if (strlen(trim($testUserId))>0 && UserModel::getInstant()->checkRegister($testUserId) ){return "テストユーザＩＤ存在していません。";}	
		return "";
	}

	private function makeHtmlFile($P_detail,$P_addfile)
	{
		$add_file_down_url="";
		if($P_addfile!=-1)//添付ある
		{
			$fileExt=substr($P_addfile,-4);
			if ($fileExt=='.trc')//トルカ
			{
				//$reserve["toruca"] = $P_addfile;//ＤＢ更新準備
				$add_file_down_url = "<br><a href='".toruka_down_url.$P_addfile."'>ダウンロード</a>";//トルカダウンロード設定
			}
			elseif ($fileExt=='.vcs')//スゲジュール
			{
				//$reserve["schedule"] = $_POST["addfile"];//ＤＢ更新準備
				$add_file_down_url = "<br><a href='".schedule_down_url.$P_addfile."'>ダウンロード</a>";//スゲジュールダウンロード設定
			}
		}
		
		$to_menu_url = "<br><a href='".
		'../App/Controller/default.php?'.CTL_KEY.'=Login&'.ACT_KEY.'=login'."&key=mybox"
		."'>TOPメニューへ</a><br>";//liu 2010/08/19 add

		//html 作成
		//$title =  "★". stripslashes(sj_str($P_title))."★"."<br><br>";
		//$entrydate="■".date("Y/m/d")."<br><br>";
		$detail = str_replace ('<span style="color: ', '<font color="', stripslashes(CommUtil::sj_str($P_detail)));
		$detail = str_replace ('</span>', '</font>', $detail);
		//$top_move = "<br><a href='javascript:history.back(-1)'>メニューに戻る</a>";
		$info_name = date("YmdHis", time()).'_'.$_SESSION["user_id"].'.php';
		$info_head = "<meta http-equiv='Content-Type' content='text/html; charset=shift_jis'><title>社内情報配信システム</title>";

		$html = <<<HTMLFILE
<?php
require_once("../../../../Env/Setting.php");
\$sql = "update access_count set count = count + 1 where url = '$info_name' LIMIT 1";
\$mysqli= new mysqli (DB_SERVER, DB_USER, DB_PSW, DB_NAME );
\$stmt = \$mysqli->prepare (\$sql);
\$result=\$stmt->execute();
\$mysqli->close ();
?>
<html><head>$info_head</head>$detail<div>$add_file_down_url</div><div>$to_menu_url</div></body></html>
HTMLFILE;
		$filename=info_path1.$info_name;//ＨＴＭＬファイル作成		
		$fp = fopen($filename, 'w');//ファイルオープン
		if(!$fp){exit('ファイルが開けません');}
		flock($fp, LOCK_EX);//ファイルのロック処理
		if(fwrite($fp, $html) === false){exit('ファイルに書き込めませんでした');}
		fclose($fp);
		return $info_name;
	}

	private function testSend($user_id,$email,$title,$free_word,$info_name,$isGpsSend,$area,$sdate,$stime,$edate,$etime)
	{
		if (strlen(trim($email))>0)//メールテスト
		{
			$body =$free_word."\n\n詳細はコチラ"."\n".HTML_PATH.$info_name;

			$mailResult=SendUtil::DoMailSend($email,$title."テスト",$body)?"OK":"NG";
			$logStr="テスト　メール送信:"."\t送信者(職員)：".$_SESSION['user_id']."\tメールアドレス：".$email."\t送信結果：";
			CommUtil::Get_log($logStr.$mailResult);
		}

		if (strlen(trim($user_id))>0)//ユーザ情報にっよって送信テスト
		{
			$user_info=UserModel::getInstant()->getUserInfo($user_id);
			switch ($user_info["sendway"])
			{
				case 1:
					$popup_msg=ParaModel::getInstant()->get_para_value("popup_msg");
					if ($isGpsSend)
					{
						$headers=SendUtil::DoGpsSend($user_id."\r\n",$popup_msg."(GPSテスト)",date("YmdHi"),
						$title,$free_word,HTML_PATH.$info_name,$area,$sdate,$stime,$edate,$etime);
					}
					else
					{
						$headers=SendUtil::DoIconcierSend($user_id."\r\n",$popup_msg."(テスト)",date("YmdHi"),
						$title,$free_word,HTML_PATH.$info_name);
						//						$headers=SendUtil::DoIconcierSend($user_id."\r\n","「ＮＴＴドコモ」からのお知らせ！(テスト)",date("YmdHi"),
						//						$title,$free_word,"http://125.206.253.233/demo/App/Controller/move/index.php");
					}
					$result=substr($headers[8],7,2);
					$detailcode = substr($headers[9],11,5);
					$logTitle=$isGpsSend?"テスト　ｉコンシェルGPS送信:":"テスト　ｉコンシェル送信:";
					$logStr=$logTitle."\t送信者(職員)：".$_SESSION['user_id']."受信者".$user_id."\tリターンコード：".$result."\t送信結果：";
					CommUtil::Get_log($logStr.($result=="00"?"OK":"NG,\tdetailcode:".$detailcode));
					break;
				case 2:
					$free_word = nl2br($free_word);//メール本文
					$free_link = "<div><A href=\"".HTML_PATH.$info_name."\">詳細はコチラ</a></div>";//URL
					$free_word = $free_word .$free_link;
					$return_flag=SendUtil::DoMsg_rSend($title."(テスト)","\t\t".$user_id."\r\n",$free_word);
					CommUtil::Get_log("メッセージＲ送信:"."\t送信者(職員)：".$_SESSION['user_id']."受信者".$user_id."\t送信結果：".$return_flag."");
					break;
				case 3:
					$body =$free_word."\n\n詳細はコチラ"."\n".HTML_PATH.$info_name;
					$mailResult=SendUtil::DoMailSend($user_info["email"],$title."(テスト)",$body)?"OK":"NG";
					$logStr="テスト　Eメール送信:"."\t送信者(職員)：".$_SESSION['user_id']."\t会員コード：".$user_id."\tメールアドレス：".$user_info["email"]."\t送信結果：";
					CommUtil::Get_log($logStr.$mailResult);
					break;
				default:
					break;
			}
		}
		$this->redirect("SendMessage","finish");//テスト完了
	}

	private function startReserveSend($info_name,$send_userids,$user_sendways,$sendmode,$addfile,
	$title,$free_word,$detail)
	{
		$reserve=array();
		$reserve["title"] =$title;
		$reserve["free_word"] =$free_word;
		$reserve["detail"] = $detail;
		$reserve["send_flg"] = "0";
		$reserve["entry_date"] = date("Y/m/d H:i:s");
		$reserve["filename"] = $info_name;
		$reserve["staff_cd"] = $_SESSION['user_id'];
		$reserve["send_mode"] = $sendmode;
		if($addfile!=-1)//添付ある
		{
			$fileExt=substr($addfile,-4);
			if ($fileExt=='.trc'){$reserve["toruca"] = $addfile;}
			elseif ($fileExt=='.vcs'){$reserve["schedule"] = $addfile;}
		}

		$reserveID=ReserveModel::getInstant()->insert($reserve);
		if($reserveID!=-1)
		{
			CommUtil::Get_log("情報配信登録\tＩＤ：".$reserveID);
			$reserve["id"]=$reserveID;
			$this->iconcier_send($reserve,$this->getSendwayUsers(1,$send_userids,$user_sendways),$sendmode);//ｉコンシェル(gps)配信
			if ($sendmode==1)//通常配信,(GPSではない)
			{
				$this->msg_r_send($reserve,$this->getSendwayUsers(2,$send_userids,$user_sendways));//メッセージＲ配信
				$this->email_send($reserve,$this->getSendwayUsers(3,$send_userids,$user_sendways));//Ｅメール配信
			}
			$this->reserve_end($reserveID);//配信完了
			$this->redirect("SendMessage","finish");
		}
		else
		{
			$_POST['confirmErr']="配信テーブル追加エラー!";
			$this->forward("SendMessage","confirmerr");
		}
	}

	private function getSendwayUsers($sendway,$send_userids,$user_sendways)
	{
		$result=array();
		foreach ($send_userids as $key=>$userid)
		{
			if ($user_sendways[$key]==$sendway)
			{
				$result[]=$userid;
			}
		}
		return $result;
	}

	private function iconcier_send($reserve,$iconcier_users,$sendmode)
	{
		$isGps=$sendmode==2;
		$gps_msg=$isGps?"GPS":"";
		$user_count=count($iconcier_users);
		if($user_count==0)
		{
			CommUtil::Get_log("ｉコンシェル".$gps_msg."配信:"."\t配信ＩＤ：".$reserve['id']."\t配信者(職員)：".
			$reserve['staff_cd']."\t対象者が存在しません");
			return;
		}

		$member="";
		foreach($iconcier_users as $user){
			$member.=$user."\r\n";//配信ユーザリスト!!
		}

		$popup_msg=ParaModel::getInstant()->get_para_value("popup_msg");
		if ($isGps)
		{
			//$area=CommUtil::getGpsStr($_POST["longitude"],$_POST["latitude"],$_POST["radius"]);// liu 2010/08/23
			$area=CommUtil::getGpsStr1($_POST["longitude"],$_POST["latitude"],$_POST["radius"]);// liu 2010/08/23
			$headers=SendUtil::DoGpsSend($member,$popup_msg,date("YmdHi"),$reserve["title"],$reserve["free_word"],
			HTML_PATH.$reserve["filename"],$area,$_POST["sdate"],$_POST["stime"],$_POST["edate"],$_POST["etime"]);
		}
		else
		{
			$headers=SendUtil::DoIconcierSend($member,$popup_msg,date("YmdHi"),$reserve["title"],
			$reserve["free_word"],HTML_PATH.$reserve["filename"]);
		}

		$result=substr($headers[8],7,2);
		$is_success=$result=="00";
		if($is_success)
		{
			CommUtil::Get_log("ｉコンシェル".$gps_msg."送信:"."\t送信者(職員)：".$reserve['staff_cd']
			."\tリターンコード：".$result."\t送信結果：OK");
			foreach($iconcier_users as $user)//送信歴史テーブルに保存
			{
				SendHistoryModel::getInstant()->insert($this->getSendHisUpdateArray($user,$reserve,1,$sendmode));
			}
			if(ReserveModel::getInstant()->update(array("send_way1"=>$user_count),"WHERE id = ".$reserve['id']." LIMIT 1"))
			{
				CommUtil::Get_log("情報配信\t：ｉコンシェル".$gps_msg."送信件数"."更新OK");
			}
		}
		else
		{
			$detailcode = substr($headers[9],11,5);
			$recno = substr($headers[10],6,5);
			CommUtil::Get_log("ｉコンシェル".$gps_msg."送信:"."\t送信者(職員)：".$reserve['staff_cd']."\tリターンコード：".
			$result.$detailcode.$recno."\t送信結果：ＮＧ");
		}
		return $is_success;
	}

	private function getSendHisUpdateArray($userid,$reserve,$sendway,$sendmode)
	{
		$send_history=array();
		$send_history["user_id"]  = $userid;//送信履歴登録
		$send_history["reserve_id"] = $reserve["id"];
		$send_history["title"] = $reserve["title"];
		$send_history["filename"]   = $reserve["filename"];
		$send_history["entry_date"] = $reserve["entry_date"];
		$send_history["send_way"] = $sendway;
		$send_history["send_mode"] = $sendmode;
		return $send_history;
	}

	private function msg_r_send($reserve,$msg_r_users)
	{
		$user_count=count($msg_r_users);
		if($user_count==0)
		{
			CommUtil::Get_log("メッセージＲ配信:"."\t配信ＩＤ：".$reserve['id']."\t配信者(職員)：".
			$reserve['staff_cd']."\t対象者が存在しません");
			return;
		}

		$free_word = nl2br($reserve["free_word"])."<div><A href=\"".HTML_PATH.$reserve["filename"]."\">詳細はコチラ</a></div>";
		$member="";
		foreach($msg_r_users as $user)
		{
			$member .= "\t\t".$user."\r\n";//配信ユーザリスト!!
		}

		$send_result=SendUtil::DoMsg_rSend($reserve['title'],$member,$free_word);
		CommUtil::Get_log("メッセージＲ送信:\t送信者(職員)：".$reserve['staff_cd']."\t送信結果：".$send_result."");
		if ($send_result)
		{
			foreach($msg_r_users as $user)
			{
				SendHistoryModel::getInstant()->insert($this->getSendHisUpdateArray($user,$reserve,2,1));
			}
			if(ReserveModel::getInstant()->update(array("send_way2"=>$user_count),"WHERE id = ".$reserve['id']." LIMIT 1"))
			{
				CommUtil::Get_log("情報配信\t：メッセージＲ送信件数更新OK");
			}
		}
		return $send_result;
	}

	private function email_send($reserve,$mail_users)
	{
		if(count($mail_users)==0)
		{
			CommUtil::Get_log("Eメール配信:"."\t配信ＩＤ：".$reserve['id']."\t配信者(職員)：".
			$reserve['staff_cd']."\t対象者が存在しません");
			return;
		}

		$mail_usersInfo=UserModel::getInstant()->getUserInfoByUidList($mail_users);
		$cnt=0;
		foreach($mail_usersInfo as $user)
		{
			$body =$reserve["free_word"]."\n\n詳細はコチラ"."\n".HTML_PATH.$reserve["filename"];

			if(SendUtil::DoMailSend($user["email"],$reserve["title"],$body))
			{
				CommUtil::Get_log("Eメール送信:"."\t送信者(職員)：".$reserve['staff_cd'].
				"\t会員コード：".$user['user_id']."\tメールアドレス：".$user['email']."\t送信結果：OK");
				SendHistoryModel::getInstant()->insert($this->getSendHisUpdateArray($user["user_id"],$reserve,3,1));
				$cnt++;
			}
			else
			{
				CommUtil::Get_log("Eメール送信:"."\t送信者(職員)：".$reserve['staff_cd'].
				"\t会員コード：".$user['user_id']."\tメールアドレス：".$user['email']."\t送信結果：ＮＧ");
			}
		}
		if(ReserveModel::getInstant()->update(array("send_way3"=>$cnt),"WHERE id = ".$reserve['id']." LIMIT 1"))
		{
			CommUtil::Get_log("情報配信\t：Ｅメール送信件数更新OK");
		}
	}

	private function reserve_end($reservID)
	{
		$result=ReserveModel::getInstant()->update(array("send_flg"=>1), " WHERE id = ".$reservID." LIMIT 1");
		CommUtil::Get_log("情報配信\t予約番号：".$reservID."送信フラグ更新".($result?"OK":"NG"));//ログ出力
	}

	function confirmerrAction() {
		$this->formBean["confirmErr"]=$_POST['confirmErr'];
	}

	function finishAction() {

	}
}
?>