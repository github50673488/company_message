<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>ユーザ認証</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style2 {font-size: 12px}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>
	  	<table width="100%" border="0">
  <tr>
    <td><div align="center">【ユーザ認証】</div></td>
  </tr>
  <tr>
    <td><div align="center" ></div></td>
  </tr>
</table>

<table width="99%" border="0">
  <tr>
    <td width="2%">&nbsp;</td>
    <td width="96%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>
	
	<form action="" method="post">
	<table width="100%" border="0">
  
  

  <tr>
    <td width="0%">&nbsp;</td>
    <td width="99%"><div align="center">パスワード
      <input name="password" type="password" istyle="4" format="*N" MODE="numeric"
	  value="<?php echo $this->formBean["password"]; ?>" size="6" maxlength="4" >
    </div></td>
    <td width="1%">&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_check_user" value="   認証   ">
      
    </div>	</td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td height="25">&nbsp;</td>
    <td><span class="red"></span>
      <div align="center"><span class="style2"><span class="red"><?php echo $this->formBean["err"]; ?></span></span></div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td> <div align="center"><a href="<?php echo $this->formBean["go_back"]; ?>" accesskey="0" >0:メニューに戻る</a></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>
