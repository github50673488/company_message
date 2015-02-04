<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>トルカ管理</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style2 {font-size: 24px}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>


<table width="99%" border="0">
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="91%">&nbsp;</td>
    <td width="4%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>
		<table width="389"  align = "center" cellspacing="0">

  <tr>
    <td width="30%" align="left">
	
	 <img src="../../Stuff/image/t_menu02-1.gif" alt="添付ファイル（トルカ）管理" width="592" height="60" border="0"
                                                                    />  
	
	</td>
    
  </tr>

</table>
<br>
<br>
	<div align="center"> 
	
             <table width="900" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="96" align="center" class="sty-td1">作成日</td>
                    <td width="111" align="center">分類</td>
                    <td width="197" align="center">タイトル</td>
                    <td width="204" align="center">登録者<br/>                    </td>
                    <td width="67"  align="center" >&nbsp;</td>
					<td width="82"  align="center" >&nbsp;</td>
					<td width="105"  align="center" >&nbsp;</td>
                  </tr>
    <?php 
	$_from = $this->formBean['data']; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    if ($this->foreachArray['loop']['total'] > 0):
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
        $this->foreachArray['loop']['iteration']++;
?>
  <tr <?php if ( $this->foreachArray['loop']['iteration']%2==0 ) echo 'class="odd"' ?> >
    <form action="" method="post">
        <td align="center"><?php echo $this->formBean['value']['create_date']; ?></td>
		<input type="hidden" name="create_date" value="<?php echo $this->formBean['value']['create_date']; ?>" />
	    <td align="center"><?php echo $this->formBean['value']['kind_name']; ?></td>
		<input type="hidden" name="kind" value="<?php echo $this->formBean['value']['kind']; ?>" />
    	<td align="center"><?php echo $this->formBean['value']['title']; ?></td>
		<input type="hidden" name="title" value="<?php echo $this->formBean['value']['title']; ?>" />
        <td align="center"><?php echo $this->formBean['value']['create_user'];?></td>
		<input type="hidden" name="create_user" value="<?php echo $this->formBean['value']['create_user']; ?>" />
		<input type="hidden" name="subtitle" value="<?php echo $this->formBean['value']['subtitle']; ?>" />
		<input type="hidden" name="content" value="<?php echo $this->formBean['value']['content']; ?>" />
		<input type="hidden" name="filename" value="<?php echo $this->formBean['value']['filename']; ?>" />
        <td align="center"><input name="doUpdate" type="submit" value="修正" /></td>
		<td align="center"><input name="doDel" type="submit" value="削除" />
		<input type="hidden" name="id" value="<?php echo $this->formBean['value']['id']; ?>" />
		</td>
        <td align="center"><input type="submit" name="t_makemessage" value="メッセージ作成"></td>
    </form>
  </tr>
<?php endforeach; else: ?>
  <tr>
    <td align="center" colspan="12"> 該当データがありません。 </td>
  </tr>
<?php endif; unset($_from); ?>
        </table>
</div>
                <br />
				 <br />
			
<?php include ('../../View/pagecontrol.tpl'); ?>	<!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->	
		<br />	
		<table width="30%"  align = "center" cellspacing="0">
<form action="<?php echo $this->formBean["to_edit"]; ?>" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doRegister" value="トルカ新規作成"></td>
  </tr>
</form>
</table>			
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