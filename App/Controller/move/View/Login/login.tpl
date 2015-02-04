<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="content-style-type" content="text/css">
<title>ログイン画面</title>
<link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css" />
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
	font-weight: bold;
}
.style2 {font-size: x-small}
.style3 {font-size: 9px}
.style4 {font-size: 14px}
-->
</style>
</head>
<body bgcolor="white">
<center><img border="0" src="../../Stuff/image/logo01.png"></center>
<CENTER>
<hr>
<br>

<table width="99%" border="0">
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="60%"><div align="center"><span class="style1">ユーザIＤを入力してください</span><br>
</div></td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td align= "center"><form name="" action="" method="POST" > 
<table width="243" border="0" bgcolor=#FAF4E7>
 <tr>
    <td colspan="2" align= "center" ></td>
    </tr>
    <tr>
    <td width="150" border="1"  align="right"><span class="style2">ユーザID：</span></td>
    <td width="133" >
	<INPUT type="text" name="user_id"  size="12" maxlength="10" istyle="4" format="*N" MODE="numeric" 
	value = "<?php echo $this->formBean["uid"];?>" >	</td>
  </tr>
    <tr>
      <td colspan="2" align="center"><div align="center"><span class="style2"><span class="red"><?php echo $this->formBean["err"];?></span></span></div></td>
	 
      </tr>
    <tr>
     <td align="center">&nbsp;</td>
     <td align="left"><input type="SUBMIT" name="login" value="ログイン"></td>
   </tr>
</table>

</form></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center" class="style3"><a href="../../info.html" class="style4">[メール配信登録はコチラから]</a></div></td>
    <td>&nbsp;</td>
  </tr>
</table>



</center>
<br>

</body>
</html>
