<?php 
$page="http://dcm2.dmpw.jp/info/App/Controller/move/App/Controller/default.php?ctl=SendMessage&action=send".
"&PHPSESSID=".$_POST['PHPSESSID']."&LAT=".$_POST['LAT']."&LON=".$_POST['LON'];
echo "<script>window.location = \"".$page."\";</script>;"
?>
