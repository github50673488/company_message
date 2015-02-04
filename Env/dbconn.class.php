<?php
require_once("Setting.php");
class DBConn {
	private static $db_host = DB_SERVER;
	private static $db_user = DB_USER;
	private static $db_psw = DB_PSW;
	private static $db_name = DB_NAME;
	private static $connection;
	static function getConn() {
		$connection = new mysqli (self::$db_host, self::$db_user, self::$db_psw, self::$db_name );
		return $connection;
	}
}
?>