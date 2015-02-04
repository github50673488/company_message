<?php
require_once("../../Env/dbconn.class.php");
require_once("../Tools/CommUtil.php");
require_once("../../Env/Setting.php");
require_once("ModelAction.php");
require_once("../Model/ParaModel.php");
class ReserveModel extends ModelAction{
	private  static  $reserveModel=null;
	static function  getInstant() {
		if (self::$reserveModel==null){self::$reserveModel=new ReserveModel();}
		return self::$reserveModel;
	}
	
function getRecordCount($user_id) {
		return $this->getValue("select count(-1) from reserve 
		where send_flg=1 
       and  DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= date(entry_date)
       and (
             staff_cd='".$user_id."' 
             or 
             id in (  select reserve_id from send_history  where    user_id='".$user_id."')
           )       ");
		
	}

	function select($page,$user_id) {
		$sql = " select a.*,
	    DATE_FORMAT(entry_date,'%Y/%m/%d') as entry_date_str,
	    case when a.send_mode=2 then 'オートGPS' else '普通'  end as send_mode_str ,
	    b.name as stuff_str,
       case when  length(ifnull(a.toruca,''))>0  then a.toruca 
            when length(ifnull(a.schedule,''))>0  then a.schedule 
            else ''  end as addfilename,
       case when  length(ifnull(c.filename,''))>0  then c.title
            when length(ifnull(d.filename,''))>0  then d.title
            else ''  end as addfiletitle 
	    from reserve a
       left join user b on a.staff_cd=user_id  
       left join toruka c on a.toruca=c.filename
       left join schedule d on a.schedule=d.filename
       where a.send_flg=1 
       and  DATE_SUB(CURDATE(), INTERVAL 7 DAY) <= date(a.entry_date)
       and (
             a.staff_cd='".$user_id."' 
             or 
             a.id in (  select reserve_id from send_history  where    user_id='".$user_id."')
           )       
       order by a.entry_date desc ";
	   $linePerPage = ParaModel::getInstant()->get_para_value("LINE_PER_PAGE");
	   $sql.= CommUtil::makePageLimitStr($page,$linePerPage);
	   return $this->getAll($sql);
	}

	function del($id) {
		$mysqli = DBConn::getConn ();
		$mysqli->autocommit(false);
		$mysqli->query("SET NAMES 'utf8'");
		$res1= $mysqli->query("delete from reserve where id=".$id);
		$res2=$mysqli->query("delete from send_history where reserve_id=".$id);
		$result=$res1&&$res2;
		$result?$mysqli->commit():$mysqli->rollback();
		$mysqli->close ();
		return $result;
	}
	

	function getRevInfo($reserve_id) {
		$mysqli = DBConn::getConn ();
		$mysqli->query("SET NAMES 'utf8'");
		$revInfo=array();
		$sql = "select * from reserve where id= '".$reserve_id."' limit 1 ";
		if ($result = $mysqli->query($sql)) {
		    $revInfo = $result->fetch_array(MYSQLI_BOTH);
			$result->close();
		}
		$mysqli->close ();
		return $revInfo;
	}
	
   function insert($reserve) {
		return $this->insertGetID("reserve",$reserve);
	}
	
   function update($reserve,$con) {
		return $this->db_update("reserve",$reserve,$con);
	}
	
	
}

?>