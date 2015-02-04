<?php
require_once("Controller_Action.php");
require_once ("../Model/ScheduleModel.php");
require_once("../Model/ParaModel.php");

//スケジュール
class ScheduleManaController extends Controller_Action
{
	public function init() {
		$this->formBean["go_logout"]=$this->getUrl('Login','logout');
		$this->formBean["go_menu"]=$this->getUrl('Main','main_menu');
		$this->formBean["to_mana"]=$this->getUrl('ScheduleMana','manage');//
		session_start();
	}

	function manageAction() {
		$scheduleModel = ScheduleModel::getInstant();
		if (isset($_POST["s_makemessage"]))
		{
			$_POST["file_kind_name"]=$_POST["kind"]==1?"iスケジュール":"スケジュール";
			$_POST["file_kind"]="2";
			$this->forward('SendMessage', 'send');
			return;
		}
		//-----------------リスト　表示,ページコントロール↓-----------------
		$scheduleModel = ScheduleModel::getInstant();
		$where=" where kind=0 or kind=1 and create_user ='".$_SESSION["user_id"]."'";//作成者あたるのだけ
		$page = 1;
		if (isset($_REQUEST["page"]) && $_REQUEST["page"] != '') {$page = $_REQUEST["page"];}
		$linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
		$recordCount = $scheduleModel->getRecordCount($where);
		$maxpage = (int)($recordCount / $linePerPage);
		if (intval($recordCount % $linePerPage) != 0) {$maxpage ++;}
		$this->formBean[URL_LIST] = $this->makePageUrlLst($maxpage,$page,'ScheduleMana','manage');
		$this->formBean[MAX_PAGE] = $maxpage;
		$this->formBean[NOW_PAGE] = $page;
		$this->formBean[TOP_PAGE] = $maxpage+1;//先頭へ
		$this->formBean[PREV_PAGE] = $maxpage+2;//前へ
		$this->formBean[NEXT_PAGE] = $maxpage+3;//次へ
		$this->formBean[LAST_PAGE] = $maxpage+4;//最後へ 
		//-----------------ページコントロール↑-----------------

		$this->formBean["data"]=$scheduleModel->select($where,$page);
		if (count($this->formBean["data"])>0)
		{
			$i=0;
			foreach ($this->formBean["data"] as $row)
			{
				$url=$this->getUrl("ScheduleMana","detail").'&id='.$row['id'];
				$this->formBean["data"][$i]['detail_link']=$url;
				$i++;
			}
		}
		$this->formBean["to_edit"]=$this->getUrl('ScheduleMana','edit');
		$this->formBean["to_iedit"]=$this->getUrl('ScheduleMana','iedit');

	}

	function detailAction() {
		$scheduleModel = ScheduleModel::getInstant();
		if (isset($_POST["btn_del"]))
		{
			if ($_POST["kind"]==0)//普通スケジュール
			{
				$scheduleModel->del($_POST["id"]);
			}
			elseif ($_POST["kind"]==1)//iスケジュール
			{
				$scheduleModel->i_del($_POST["id"],true);   //スケジュールと全部子スケジュールを削除する
			}
			$this->redirect('ScheduleMana','manage');
		}
		elseif (isset($_POST["btn_edit"]))
		{
			if ($_POST["kind"]==0)//普通スケジュール
			{
				$this->forward('ScheduleMana', 'edit');
				return;
			}
			elseif ($_POST["kind"]==1)//iスケジュール
			{
				$this->forward('ScheduleMana', 'check');//パスワード認証
			}
		}
		if (!isset($_REQUEST["id"]) || $_REQUEST["id"]<0){return;}
		$scheduleInfo= ScheduleModel::getInstant()->getScheduleInfo($_REQUEST["id"]);
		$this->formBean["id"]=$scheduleInfo["id"];
		$this->formBean["s_id"]=$scheduleInfo["s_id"];
		$this->formBean["title"]=$scheduleInfo["title"];
		$this->formBean["kindname"]=$scheduleInfo["kind"]==0?"スケジュール":"iスケジュール";
		$this->formBean["kind"]=$scheduleInfo["kind"];
		$this->formBean["place"]=$scheduleInfo["place"];
		$this->formBean["start_date"]=date("Y/m/d",strtotime($scheduleInfo["start_date"]));
		$this->formBean["end_date"]=date("Y/m/d",strtotime($scheduleInfo["end_date"]));
		$this->formBean["detail"]=$scheduleInfo["detail"];
		$this->formBean["create_date"]=date("Y/m/d",strtotime($scheduleInfo["create_date"]));
		$this->formBean['down_link']=schedule_down_url.$scheduleInfo['filename'];
	}


	function checkAction()
	{
		//==>detail から
		session_start();
		$err="";
		$pass="";
		if (isset($_POST["btn_check_pass"]))
		{
			$pass=$_POST["password"];
			if (ScheduleModel::getInstant()->checki_Pass($_POST["id"],$pass))
			{
				$_SESSION["iSchedule_id"]=$_POST["id"];
				$_SESSION["i_password"]=$pass;
				$_SESSION["iSchedule_title"]=$_POST["title"];
				$_SESSION["s_id"] = $_POST["s_id"];
				$_SESSION["schedule_list"]=ScheduleModel::getInstant()->select(" where parentid= ".$_POST["id"],0);
				$this->putScheduleListInOrder();
				$this->redirect('ScheduleMana', 'iedit');
			}
			$err="パスワードを確認してください";
		}
		$this->formBean["err"]=$err;
		$this->formBean["id"]=$_POST["id"];
		$this->formBean["password"]=$pass;
		$this->formBean["title"]=$_POST["title"];
		$this->formBean["s_id"]=$_POST["s_id"];
		$this->formBean["to_check"]=$this->getUrl("ScheduleMana","check");
		$this->formBean["go_back"]=$this->getUrl("ScheduleMana","detail").'&id='.$_POST['id'];
	}

	private function putScheduleListInOrder()//整理
	{
		if (!is_array($_SESSION["schedule_list"]) && !is_object($_SESSION["schedule_list"]))
		{
			settype($_SESSION["schedule_list"], 'array');
		}
		$_SESSION["schedule_list"] = array_values($_SESSION["schedule_list"]);
	}

	function editAction() //普通スケジュール編集
	{
		if (isset($_POST["doRegister"]))
		{
			$this->formBean["kind"]=0;//
			$this->formBean["id"]=-1;//新規フラグ
			$this->formBean["s_id"] = "";
			$this->formBean["goback"]=$this->getUrl('ScheduleMana','manage');//
		}
		elseif (isset($_POST["btn_edit"]))
		{
			$this->formBean["kind"]=0;//
			$this->formBean["id"]=$_POST["id"];
			$this->formBean["s_id"] = $_POST["s_id"];
			$this->putEditDataToBean(0);
			$this->formBean["goback"]=$this->getUrl('ScheduleMana','manage');//
		}
		elseif (isset($_POST["schedule_add"]))//iスケジュール画面 [スケジュール追加]から
		{
			$_SESSION["iSchedule_title"]=$_POST["ititle"];//i スケジュールの子スケジュールのタイトル
			$this->formBean["kind"]=2;//i スケジュールの子スケジュール
			$this->formBean["id"]=-1;//新規i スケジュールの子スケジュールフラグ
			$this->formBean["s_id"] = "";
			$this->formBean["goback"]=$this->getUrl('ScheduleMana','iedit');//
		}
		elseif (isset($_POST["schedule_edit"]))//iスケジュール画面 [編集]から
		{
			$this->formBean["kind"]=2;
			$this->formBean["id"]=$_POST["list_id"];//iスケジュールの新規i スケジュールの子スケジュールのリストid
			$this->formBean["s_id"] = $_POST["list_s_id"];
			$this->putEditDataToBean(0);
			$this->formBean["goback"]=$this->getUrl('ScheduleMana','iedit');
		}
		elseif (isset($_POST["back"]))//確認画面データチェック失敗ので、戻る時
		{
			$this->formBean["err_msg"]=$this->revPara;
			$this->putEditDataToBean(2);
		}

		$this->formBean["to_confirm"]=$this->getUrl('ScheduleMana','confirm');
		$this->formBean["form_title"]=$this->formBean["id"]>0?"スケジュール編集画面":"スケジュール新規画面";
		$this->formBean["exam_date"]=date("Ymd");
	}

	private function putEditDataToBean($dateMode)
	{
		$this->formBean["title"]=$_POST["title"];

		switch ($dateMode)
		{
			case 0:
				$this->formBean["start_date"]=date("Ymd",strtotime($_POST["start_date"]));//2009-08-15⇒20090815
				$this->formBean["end_date"]=date("Ymd",strtotime($_POST["end_date"]));//2009-08-15⇒20090815
				break;
			case 1:
				$this->formBean["start_date"]=CommUtil::makeDBDateStr($_POST["start_date"]);//20090815⇒2009-08-15
				$this->formBean["end_date"]=CommUtil::makeDBDateStr($_POST["end_date"]);//20090815⇒2009-08-15
				break;
			default:
				$this->formBean["start_date"]=$_POST["start_date"];
				$this->formBean["end_date"]=$_POST["end_date"];
		}

		$this->formBean["place"]=$_POST["place"];
		$this->formBean["detail"]=$_POST["detail"];
	}

	function confirmAction() {
		if (!isset($_POST["update"]))//Edit画面から、 まだ登録していない　,本画面表示だけ
		{
			$err_msg=strlen(trim($_POST ['title']))==0?"タイトルをチェックしてください":"";
			if ($err_msg=="")
			{
				$err_msg=CommUtil::checkStartEndDateStr($_POST ['start_date'],$_POST ['end_date']);
			}
			if ($err_msg!="")
			{
				$this->formBean["err_msg"]=$err_msg;
				$this->putEditDataToBean(2);
				$this->formBean["to_confirm"]=$this->getUrl('ScheduleMana','confirm');
				$this->formBean["goback"]=$this->getUrl('ScheduleMana','manage');//
				$this->formBean["form_title"]=$_POST["id"]>0?"スケジュール編集画面":"スケジュール新規画面";
				$this->formBean["exam_date"]=date("Ymd");
				$this->render('ScheduleMana','edit');//edit画面表示
				return;
			}

			$this->formBean["id"]=$_POST["id"];
			$this->formBean["s_id"]=$_POST["s_id"];
			$this->putEditDataToBean(1);
			$this->formBean["kind"]=$_POST["kind"];
			if ($_POST ['kind']==0)//普通スケジュール
			{
				$this->formBean["cancel"]=$this->getUrl('ScheduleMana','manage');
			}
			elseif ($_POST ['kind']==2)
			{
				$this->formBean["cancel"]=$this->getUrl('ScheduleMana','iedit');
			}
		}
		else
		{
			if ($_POST ['kind']==0)//普通スケジュール,DB更新して、管理画面に戻る
			{
				$scheduleModel = ScheduleModel::getInstant();
				if ($_POST["id"]==-1)//新規
				{
					$regItem = $this->makeRegisterArray($_POST ['kind'],false);
					while(true) {
						$s_id = $scheduleModel->getRandomString(64);
						if($scheduleModel->sid_chack($s_id)) {
							break;
						}
					}
					$regItem["s_id"] = $s_id;
					$id = $scheduleModel->register($regItem);
					$res=$scheduleModel->send_suhedule($regItem,$id);
				}
				else if ($_POST["id"]>=0)//修正
				{
					$regItem = $this->makeUpdateArray($_POST ['kind']);
					if ($regItem["s_id"] == "") {
						while(true) {
							$s_id = $scheduleModel->getRandomString(64);
							if($scheduleModel->sid_chack($s_id)) {
								break;
							}
						}
						$regItem["s_id"] = $s_id;
					}
					$scheduleModel->update($regItem,false);
					$res=$scheduleModel->send_suhedule($regItem,$regItem["id"]);
				}
				if ($res){$this->redirect('ScheduleMana', 'manage');}
				else { $this->formBean["err"]="更新失敗しました。";}
			}elseif ($_POST ['kind']==2)//iスケジュールの子スケジュール,session更新して、iスケジュール管理画面に戻る
			{
				if ($_POST["id"]==-1)//新規--->$_SESSION
				{
					$_SESSION["schedule_list"][]=$this->makeRegisterArray($_POST ['kind'],true);//新データSESSIONに追加する
				}
				else if ($_POST["id"]>=0)//修正--->$_SESSION
				{
					$_SESSION["schedule_list"][$_POST["id"]]=$this->makeUpdateArray($_POST ['kind'],true);
				}
				$this->redirect('ScheduleMana', 'iedit');
				return;
			}
		}
	}



	private function makeUpdateArray($kind,$isMakeCreateDate)
	{
		$result= array ('id' => $_POST ['id'],'s_id' => $_POST ['s_id'],'kind' => $kind,'title' => $_POST ['title'],
				'start_date' => $_POST ['start_date'],'end_date' => $_POST ['end_date'],
				'place' => $_POST ['place'],'detail' => $_POST ['detail'],
				'update_user' => $_SESSION["user_id"]);
		if ($isMakeCreateDate){$result["create_date"]=date('Y-m-d');}
		return $result;
	}


	private function makeRegisterArray($kind,$isMakeCreateDate)
	{
		$result= array ('s_id' => $_POST ['s_id'],'kind' => $kind,'title' => $_POST ['title'],
				'start_date' => $_POST ['start_date'],'end_date' => $_POST ['end_date'],
				'place' => $_POST ['place'],'detail' => $_POST ['detail'],
				'create_user' => $_SESSION["user_id"],'update_user' => $_SESSION["user_id"]);

		if ($isMakeCreateDate){$result["create_date"]=date('Y-m-d');}
		return $result;

	}

	function ieditAction() {
		session_start();
		if (isset($_POST["doiRegister"]))//管理画面 [iスケジュール新規作成]から
		{
			$_SESSION["iSchedule_id"]=-1;
			$_SESSION["iSchedule_title"]="";
			$_SESSION["s_id"]="";
			$_SESSION["schedule_list"]=array();
			$_SESSION["i_password"]="";
		}
		elseif (isset($_POST["schedule_del"]))//iスケジュール画面 [削除]から
		{
			$_SESSION["iSchedule_title"]=$_GET["ititle"];//i スケジュールの子スケジュールのタイトル
			if (isset($_SESSION["schedule_list"][$_POST["list_id"]])){
				unset ($_SESSION["schedule_list"][$_POST["list_id"]]);
			}
			$this->putScheduleListInOrder();
		}
		elseif (isset($_POST["schedule_edit"]))//iスケジュール画面 [編集]から
		{
			//$_SESSION["iSchedule_title"]=$_GET["ititle"];//i スケジュールの子スケジュールのタイトル
			$this->forward('ScheduleMana', 'edit');
			return;
		}
		$this->formBean["form_title"]=$_SESSION["iSchedule_id"]==-1?"iスケジュール新規 ":"iスケジュール編集 ";
		$this->formBean["title"]=$_SESSION["iSchedule_title"];
		$this->formBean["i_password"]=$_SESSION["i_password"];
		$this->formBean["s_id"]=$_SESSION["s_id"];
		$this->formBean["data"]=$_SESSION["schedule_list"];
		$this->formBean["schedule_add"]=$this->getUrl('ScheduleMana','edit');
		$this->formBean["go_iconfirm"]=$this->getUrl('ScheduleMana','iconfirm');
		$this->formBean["go_myself"]=$this->getUrl('ScheduleMana','iedit');
		$this->formBean["goback"]=$this->getUrl('ScheduleMana','manage');
	}

	function iconfirmAction() {
		if (isset($_POST["go_iconfirm"]))//i スケジュール編集画面から,本画面表示
		{
			$_SESSION["iSchedule_title"]=$_POST["ititle"];//i スケジュールの子スケジュールのタイトル
			$this->formBean["data"]=$_SESSION["schedule_list"];
			$this->formBean["iSchedule_title"]=$_SESSION["iSchedule_title"];
			$this->formBean["i_password"]=$_POST["i_password"];
			$this->formBean["cancel"]=$this->getURl("ScheduleMana","iedit");
		}
		if(isset($_POST["update"]))//本画面登録ボタンから
		{
			$scheduleModel = ScheduleModel::getInstant();
			if ($_SESSION["iSchedule_id"]==-1)//新規iスケジュール
			{
				// スケジュールIDの取得
				$i_sid = $scheduleModel->getSuheduleID();
				$i_schedule = $this->make_i_RegisterArray();
				$i_id=$scheduleModel->i_register($i_schedule, $i_sid);//i スケジュール保存 (kind=1), 保存id取得
				foreach($_SESSION["schedule_list"] as $key => $regItem)
				{
					$regItem["parentid"]=$i_id;
					while(true) {
						$s_id = $scheduleModel->getRandomString(64);
						if($scheduleModel->sid_chack($s_id)) {
							break;
						}
					}
					$regItem["s_id"] = $s_id;
					$scheduleModel->i_child_register($regItem); //sessionのi スケジュールの子スケジュール　保存 (kind=2)、 i スケジュール保存idーー＞parent Id
					$i_schedule["schedule_list"][] = $regItem;
				}

				$res = $scheduleModel->send_iSuhedule($i_schedule,$i_sid, $i_id,1);
			}
			else if ($_SESSION["iSchedule_id"]>=0)//iスケジュール修正
			{
				$i_schedule = $this->makeChangeTitleArray();
				$scheduleModel->update_i_schedule_title($i_schedule);//i スケジュールのタイトル変更
				$scheduleModel->i_del($_SESSION["iSchedule_id"],false);//DB全部i スケジュールの子スケジュール削除
				foreach($_SESSION["schedule_list"] as $key => $regItem)//全部sessionのiスケジュールの子スケジュール保存 (kind=2)ーー＞DB
				{
					if ($regItem["s_id"] == "") {
						while(true) {
							$s_id = $scheduleModel->getRandomString(64);
							if($scheduleModel->sid_chack($s_id)) {
								break;
							}
						}
						$regItem["s_id"] = $s_id;
					}
					$regItem["parentid"]=$_SESSION["iSchedule_id"];
					$scheduleModel->i_child_add($regItem); //sessionのi スケジュールの子スケジュール　保存 (kind=2)、 i スケジュール保存idーー＞parent Id
					$i_schedule["schedule_list"][] = $regItem;
				}
				$res =$scheduleModel->send_iSuhedule($i_schedule,$_SESSION["s_id"], $_SESSION["iSchedule_id"],2);
			}
			if ($res) {$this->redirect('ScheduleMana', 'manage');}//管理画面に戻る
			else {$this->formBean["err"]="更新失敗しました。";}
		}
	}

	private function make_i_RegisterArray()
	{
		return array ('kind' => 1,'title' => $_SESSION["iSchedule_title"],
		'create_user' => $_SESSION["user_id"],
		'update_user' => $_SESSION["user_id"],
		'i_password'=>$_POST['i_password']
		);
	}

	private function makeChangeTitleArray()
	{
		return array ('id' => $_SESSION["iSchedule_id"],
				'title' => $_SESSION["iSchedule_title"],
				'update_user' => $_SESSION["user_id"],
	            'i_password'=>$_POST['i_password']
		);
	}
}
?>