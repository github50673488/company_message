<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>グループ新規登録</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style1 {
	font-size: 24px;
	font-weight: bold;
}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>

<table width="99%" border="0">
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="60%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>
	<table width="99%" border="0">
  <tr>
    <td width="20%" height="15">&nbsp;</td>
    <td width="60%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td height="70">&nbsp;</td>
    <td>
	<table width="100%" border="1">
  <tr>
    <td><div align="center" class="style1">【グループ新規登録】</div></td>
  </tr>
</table>

	<br>
	<form action="" method="post">
	<table width="100%" border="1">
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="92%"><div align="center"><span class="red"><strong><?php echo $this->formBean["info"]; ?></strong></span></div></td>
    <td width="4%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">グループ名<br>
        <input name="group_name" type="text" value="<?php if(isset($this->formBean["group_name"])) echo $this->formBean["group_name"]; ?>" >
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <? if(isset($this->formBean["isDocomo"]) && !$this->formBean["isDocomo"]){ ?>
      <? } ?>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="doRegister" value="       登録       ">
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="docancel" value="   キャンセル   " >
    </div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
	<br>
	<a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
