<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>ユーザ登録確認</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style3 {font-size: 12}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>
	  <br>
<table width="100%" border="0">
  <tr>
    <td><div align="center" >【ユーザ登録確認】</div></td>
  </tr>
</table>
	<form action="<?php if(isset($this->formBean["to_reglink"]))echo $this->formBean["to_reglink"];?>" method="post">
	<table width="100%" border="0">
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><div align="center"><span class="red"><strong>
	<?php if(isset($this->formBean["info"])) echo $this->formBean["info"]; ?></strong></span></div></td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■ユーザID<br>
	<?php if(isset($this->formBean["user_id"])) echo $this->formBean["user_id"]; ?>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■名前<br>
      <?php if(isset($this->formBean["name"])) echo $this->formBean["name"]; ?></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>■パスワード<br>
<?php if(isset($this->formBean["password"])) echo $this->formBean["password"]; ?></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
<? if(isset($this->formBean["isDocomo"]) && !$this->formBean["isDocomo"]){ ?>	
    <td>■メールアドレス<br>
      <?php if(isset($this->formBean["email"])) echo $this->formBean["email"]; ?>	  </td>
<? } ?>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■配信方法<br>   	 <?php if(isset($this->formBean["sendway_str"])) echo $this->formBean["sendway_str"]; ?>  </td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>■所属グループ<br>
	<?php if(isset($this->formBean["group_name"])) echo $this->formBean["group_name"]; ?></td>
  </tr>
  <tr>
    <td height="27">&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="doComfirm" value="      確認       ">
      <input type="hidden" name="id" value="<?php if(isset($this->formBean['id'])) echo $this->formBean['id']; ?>" />
    </div>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
<input type="hidden" name="user_id" size="10" maxlength="10" value = "<?php if(isset($this->formBean["user_id"])) echo $this->formBean["user_id"]; ?>">
    <input type="hidden" name="xp_id" value="<?php if(isset($this->formBean["mybox_no"])) echo $this->formBean["mybox_no"]; ?>">
    <input type="hidden" name="nl" value="<?php if(isset($this->formBean["to_regend"])) echo $this->formBean["to_regend"]; ?>">
    <input type="hidden" name="arg1" value="<?php if(isset($this->formBean["user_id"])) echo $this->formBean["user_id"]; ?>"></div></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td> </td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
    
</body>
</html>
