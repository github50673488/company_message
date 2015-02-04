<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>ユーザ情報変更</title>
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
    <td><div align="center" >【ユーザ情報変更】</div></td>
  </tr>
</table>
	<form action=" <?php echo $this->formBean['to_changeinfo']; ?>" method="post">
	<table width="100%" border="0">
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><div align="center"><span class="red"><strong><?php echo $this->formBean["info"]; ?></strong></span></div></td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■ユーザID<br>
	<?php echo $this->formBean["user_id"]; ?>
        <input name="user_id" type="hidden" value="<?php echo $this->formBean["user_id"]; ?>" size="10" maxlength="10"  >
    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■名前<br>
      <input name="name" type="text" value="<?php echo $this->formBean["name"]; ?>" size="25" maxlength="25"></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>■パスワード
<input name="password" type="text" istyle="4" format="*N" MODE="numeric" value="<?php echo $this->formBean["password"]; ?>" size="4" maxlength="4" ></td>
    <td>&nbsp;</td>
  </tr>
  	<? if(isset($this->formBean["isDocomo"]) && !$this->formBean["isDocomo"]){ ?>	
  <tr>
    <td>&nbsp;</td>

    <td>■メールアドレス
<input name="email" type="text" istyle="3" format="*x" MODE="alphabet" value="<?php echo $this->formBean["email"]; ?>" size="30" maxlength="50"></td>

    <td>&nbsp;</td>
  </tr>
  <? } ?>
  <tr>
    <td>&nbsp;</td>
    <td>■配信方法
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
    <td><span class="red"><strong>情報配信設定
    </strong></span></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><?php echo $this->formBean["title"]; ?>
<br>■<?php echo $this->formBean["n1"]; ?>&nbsp;1.
 <?php 
	if (count($this->formBean['n1list'])>0)
	{
	echo $this->html_options(array('name' => 'p1','options' => $this->formBean['n1list'],
	'selected' => $this->formBean['n1list_selected']));
	}?>
</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■<?php echo $this->formBean["n2"]; ?>
&nbsp;2.
<label>
<?php 
	if (count($this->formBean['n2list'])>0)
	echo $this->html_options(array('name' => 'p2','options' => $this->formBean['n2list'],
	'selected' => $this->formBean['n2list_selected']));?>
</label>
</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>■<?php echo $this->formBean["n3"]; ?>
&nbsp;3.
<label>
<?php 
	if (count($this->formBean['n3list'])>0)
	echo $this->html_options(array('name' => 'p3','options' => $this->formBean['n3list'],'selected' => $this->formBean['n3list_selected']));?>
</label>
</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="red"><strong>配信情報設定

    </strong></span></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="checkbox" name="p4" value="1" <?php  echo $this->formBean['p4check']; ?> >
      <?php echo $this->formBean["n4"]; ?>
</label></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="checkbox" name="p5" value="1" <?php  echo $this->formBean['p5check']; ?>><?php echo $this->formBean["n5"]; ?>

    </label></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="checkbox" name="p6" value="1" <?php  echo $this->formBean['p6check']; ?>>
	  <?php echo $this->formBean["n6"]; ?>

    </label></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="checkbox" name="p7" value="1"<?php  echo $this->formBean['p7check']; ?>>
	  <?php echo $this->formBean["n7"]; ?>

    </label></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><label>
      <input type="checkbox" name="p8" value="1" <?php  echo $this->formBean['p8check']; ?>>
	  <?php echo $this->formBean["n8"]; ?>

    </label></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="checkbox" name="p9" value="1" <?php  echo $this->formBean['p9check']; ?>>
	<?php echo $this->formBean["n9"]; ?></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_update_user" value="     変更      ">
      <input type="hidden" name="id" value="<?php if(isset($this->formBean['id'])) echo $this->formBean['id']; ?>" />
    </div>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_del_user" value="  情報配信解除 ">
    </div></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td> <div align="center"><a href="<?php echo $this->formBean["go_back"]; ?>" accesskey="0" >0:メニューに戻る</a>
	</div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
    
</body>
</html>
