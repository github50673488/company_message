<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>ユーザ情報変更</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">

    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>
<table width="99%" border="0">
  <tr>
    <td width="98%" height="15"><div align="center">【ユーザ情報変更】</div></td>
    </tr>
  <tr>
    <td height="70">
	<form action="" method="post">
	<table width="100%" border="0">
  
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><span class="red"><strong><?php echo $this->formBean["err"]; ?></strong></span></div></td>
  </tr>
  <tr>
    <td width="2%">&nbsp;</td>
    <td width="98%"><span class="style3">ユーザID<br>
        <?php echo $this->formBean["user_id"]; ?>
	    <input type="hidden" name="user_id" value="<?php echo $this->formBean['user_id']; ?>" />	  
	    </span></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">名前<br>
        <input name="name" type="text" value="<?php echo $this->formBean["name"]; ?>" size="30" maxlength="50">
    </span></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">パスワード
        <br>
        <input name="password" type="text" value="<?php echo $this->formBean["password"]; ?>" size="6" maxlength="4" >
    </span></td>
    </tr>
  	<? if(isset($this->formBean["isDocomo"]) && !$this->formBean["isDocomo"]){ ?>	
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">メールアドレス
        <br>
        <input name="email" type="text" value="<?php echo $this->formBean["email"]; ?>" size="30" maxlength="50" >
    </span></td>
    </tr>
    <? } ?>
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">配信方法
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
            </select>
    </span></td>
    </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">権限:
	    <select name="authority" >
	         <?php ( isset($this->formBean["authority"])&&$this->formBean["authority"] == "1" ) ? $val = "selected" : $val = "" ; ?>
	        <option value="1" <?= $val?>>一般</option>
	      
	       <?php if ($this->formBean["isAdmin"])
	   {
	   ?>
	        <?php ( isset($this->formBean["authority"])&&$this->formBean["authority"] == "2" ) ? $val = "selected" : $val = "" ; ?>
	        <option value="2" <?= $val?>>管理者</option>
	       <?php 
	   }
	   ?>
	          </select>
    </span></td>
    </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_update_user" value="   変更    ">
	 
    </div>	</td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_del_user" value="情報配信解除" onClick="return(confirm('解除してもよろしいですか？\n\n解除したくない場合は[キャンセル]ボタンを押して下さい'))">
    </div></td>
    </tr>
</table>
</form>
	<br>
	<div align="center"><a href="<?php echo $this->formBean["go_back"]; ?>" class="style4" accesskey="0" >0:メニューに戻る</a></div></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    </tr>
</table>

	
</body>
</html>
