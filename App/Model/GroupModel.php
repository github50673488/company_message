<?php
require_once("../../Env/dbconn.class.php");
require_once("../Tools/CommUtil.php");
require_once("ModelAction.php");
class GroupModel extends ModelAction {
	private  static  $groupModel=null;
	static function getInstant() {
		if (self::$groupModel==null){self::$groupModel=new GroupModel();}
		return self::$groupModel;
	}

	function getGpLst() {
		$gpdb= $this->getAll("select id,group_name from group_info ");
		$GpLst=array();
		if (count($gpdb)>0)
		{
			foreach ($gpdb as $row)
			{
				$GpLst[$row["id"]]=$row["group_name"];
			}
		}
		return $GpLst;
	}
	
	function selectGp() {
		$sql = "select * from group_info  order by id ";
		return $this->getAll($sql);
	}

	function getRecordCount() {
		return $this->getValue("select count(-1) from group_info ");
	}

	function register($group_name) {
        return $this->execute("insert into group_info (group_name) values('".$group_name."');");
	}

	function getGroupName($id) {
		return $this->getValue("select group_name from group_info where id=".$id);
	}

	function del($id) {
		return $this->execute("delete from group_info where id=".$id);
	}
	
   function update($id,$group_name) {
		return $this->execute(" update group_info set group_name='".$group_name."' where id=".$id);
	}
}
?>