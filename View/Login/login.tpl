<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="content-style-type" content="text/css">
<title>ログイン画面</title>
<link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css" />
<style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>
</head>
<body bgcolor="white">
<br>
    <table width="99%" cellpadding="3" cellspacing="0">
    <tr>
       <td width="62%"><img border="0" src="../../Stuff/image/logo01.gif" width="567" height="68"></td>
	   <td width="18%">&nbsp;</td>
	   <td align="center" valign="bottom" width="20%">
   	  </td>
   </tr>
	<tr><td height="5" colspan="3" bgcolor="#13439C"></td></tr>
</table>
<br>

<CENTER>
<br>
<br>

<table width="99%" border="0">
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="60%"><div align="center">ログインIDとパスワードを入力してください</div></td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td align= "center"><form name="loginFrom" action="" method="POST" > 
<table width="288" border="0" bgcolor=#FAF4E7>
 <tr>
    <td colspan="2" align= "center" ><?php echo $this->formBean["err"];?></td>
    </tr>
    <tr>
    <td width="114" border="1"  align="right">ID：</td>
    <td width="164" ><INPUT type="text" name="user_id"  size="13" maxlength="14" 
	value = "<?php if(isset($this->formBean["user_id"])) echo $this->formBean["user_id"]; ?>"></td>
  </tr>
  <tr>
    <td width="114"  align="right">パスワード：</td>
    <td><INPUT type="password" name="password"  size="15" maxlength="15" 
	value = "<?php if(isset($this->formBean["password"])) echo $this->formBean["password"]; ?>"></td>
  </tr>
   <tr>
     <td align="center">&nbsp;</td>
     <td align="left"><input type="SUBMIT" name="login" value="メニュー画面へ"></td>
   </tr>
</table>

</form></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>



</center>
<br>

</body>
</html>
