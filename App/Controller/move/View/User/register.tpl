<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>ユーザ登録</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style4 {font-size: 12px}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>
	  <br>
<table width="100%" border="0">
  <tr>
    <td><div align="center" >【ユーザ登録】</div></td>
  </tr>
</table>
	<form action="" method="post">
	<table width="100%" border="0">
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><div align="center"><span class="red"><span class="style4"><strong>
	<?php if(isset($this->formBean["info"])) echo $this->formBean["info"]; ?>
	</strong></span></span></div></td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■ユーザID<br>
        <input name="user_id" type="text"  istyle="4" format="*N" MODE="numeric"
		value="<?php if(isset($this->formBean["user_id"])) echo $this->formBean["user_id"]; ?>" size="10" maxlength="10"  >    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■名前<br>
      <input name="name" type="text" value="<?php if(isset($this->formBean["name"])) echo $this->formBean["name"]; ?>" size="25" maxlength="25"></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>■パスワード
<input name="password" type="text" istyle="4" format="*N" MODE="numeric" value="<?php if(isset($this->formBean["password"])) echo $this->formBean["password"]; ?>" size="4" maxlength="4" ></td>
    <td>&nbsp;</td>
  </tr>
  <? if(isset($this->formBean["isDocomo"]) && !$this->formBean["isDocomo"]){ ?>	
  <tr>
    <td>&nbsp;</td>

    <td>■メールアドレス
      <input name="email" type="text" istyle="3" format="*x" mode="alphabet" 
value="<?php if(isset($this->formBean["email"])) echo $this->formBean["email"]; ?>" size="30" maxlength="50"></td>

    <td>&nbsp;</td>
  </tr>
  <? } ?>
  <tr>
    <td>&nbsp;</td>
    <td>■配信方法   	 
      <select name="sendway" >
    <? if (isset($this->formBean["isDocomo"]) && $this->formBean["isDocomo"]){ ?>
      <? ( isset($this->formBean["sendway"])&& $this->formBean["sendway"] == "1" ) ? $val = "selected" : $val = "" ; ?>
      <option value="1" <?= $val?>>ｉコンシェル</option>
	  <? ( isset($this->formBean["sendway"])&& $this->formBean["sendway"] == "2" ) ? $val = "selected" : $val = "" ; ?>
      <option value="2" <?= $val?>>メッセージＲ</option>
    <? } 
	
	else { ?>
      <? ( isset($this->formBean["sendway"])&& $this->formBean["sendway"] == "3" ) ? $val = "selected" : $val = "" ; ?>
      <option value="3" <?= $val?>>Ｅメール</option>
    <? } ?>
    </select>	</td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>所属グループ
	<?php 
	if (isset($this->formBean["gpLst"]) && count($this->formBean['gpLst'])>0)
	{
	   echo $this->html_options(array('name' => 'gpLst','options' => $this->formBean['gpLst'],'selected' => $this->formBean['group_id']));
	}?></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="27">&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="doRegister" value="      登録       ">
      <input type="hidden" name="id" value="<?php if(isset($this->formBean['id'])) echo $this->formBean['id']; ?>" />
    </div>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"></div></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
