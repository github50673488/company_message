<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>ユーザ新規登録</title>
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
    <td><div align="center" class="style1">【ユーザ新規登録】</div></td>
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
    <td>ユーザID<br><input name="user_id" type="text" value="<?php if(isset($this->formBean["user_id"])) echo $this->formBean["user_id"]; ?>" ></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>名前<br><input name="name" type="text" value="<?php if(isset($this->formBean["name"])) echo $this->formBean["name"]; ?>" ></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>パスワード
<br><input name="password" type="text" value="<?php if(isset($this->formBean["password"])) echo $this->formBean["password"]; ?>" size="4" maxlength="4"></td>
    <td>&nbsp;</td>
  </tr>
  <? if(isset($this->formBean["isDocomo"]) && !$this->formBean["isDocomo"]){ ?>
  <tr>
    <td>&nbsp;</td>
    <td>メールアドレス
<br>
<input name="email" type="text" value="<?php if(isset($this->formBean["email"])) echo $this->formBean["email"]; ?>"></td>
    <td>&nbsp;</td>
  </tr>
      <? } ?>
  <tr>
    <td>&nbsp;</td>
    <td>配信方法
        <select name="sendway" >
    <? if (isset($this->formBean["isDocomo"]) && $this->formBean["isDocomo"]){ ?>
      <? ( isset($this->formBean["sendway"])&&$this->formBean["sendway"] == "1" ) ? $val = "selected" : $val = "" ; ?>
      <option value="1" <?= $val?>>ｉコンシェル</option>
	  <? ( isset($this->formBean["sendway"])&&$this->formBean["sendway"] == "2" ) ? $val = "selected" : $val = "" ; ?>
      <option value="2" <?= $val?>>メッセージＲ</option>
    <? } else { ?>
      <? ( isset($this->formBean["sendway"])&&$this->formBean["sendway"] == "3" ) ? $val = "selected" : $val = "" ; ?>
      <option value="3" <?= $val?>>Ｅメール</option>
    <? } ?>
    </select>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>所属Gr
	<?php 
	if (isset($this->formBean["gpLst"]) && count($this->formBean['gpLst'])>0)
	{
	   echo $this->html_options(array('name' => 'gpLst','options' => $this->formBean['gpLst'],'selected' => $this->formBean['group_id']));
	}?></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>権限:
	 <select name="authority" >
	 <? ( isset($this->formBean["authority"])&&$this->formBean["authority"] == "1" ) ? $val = "selected" : $val = "" ; ?>
      <option value="2" <?= $val?>>一般</option>
      <? ( isset($this->formBean["authority"])&&$this->formBean["authority"] == "2" ) ? $val = "selected" : $val = "" ; ?>
      <option value="1" <?= $val?>>管理者</option>
    </select>
	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="doRegister" value="       登録       ">
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"></div></td>
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
