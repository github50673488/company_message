<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>スケジュール管理</title>
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
    <td width="15%">&nbsp;</td>
    <td width="70%">&nbsp;</td>
    <td width="15%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>
	<table width="100%" border="1">
  <tr>
    <td>
	 <img src="../../Stuff/image/t_menu02-2.gif" alt="スケジュール管理" width="592" height="60" border="0"
                                                                    />   </td>
  </tr>
</table>
<br>
	<div align="center"> 
	
             <table width="700" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="189" align="center" class="sty-td1">作成日</td>
                    <td width="161" align="center">分類</td>
                    <td width="161" align="center">タイトル</td>
                    <td width="83"  align="center" >作成者</td>
                    <td width="83"  align="center" >&nbsp;</td>
					<td width="88"  align="center" >&nbsp;</td>
					<td width="88"  align="center" >&nbsp;</td>
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
	  <td align="center"><?php echo $this->formBean['value']['kind_name'];?></td>
	  <td align="center"><?php echo $this->formBean['value']['title'];?>
	  <input type="hidden" name="title" value="<?php echo $this->formBean['value']['title']; ?>" />	  </td>
	  <td align="center"><?php echo $this->formBean['value']['create_user'];?></td>
	  <td align="center"><input name="doUpdate" type="submit" value="修正" />
	  <input type="hidden" name="start_date" value="<?php echo $this->formBean['value']['start_date']; ?>" />
	  <input type="hidden" name="end_date" value="<?php echo $this->formBean['value']['end_date']; ?>" />
	  <input type="hidden" name="place" value="<?php echo $this->formBean['value']['place']; ?>" />
	  <input type="hidden" name="detail" value="<?php echo $this->formBean['value']['detail']; ?>" />
	  <input type="hidden" name="kind" value="<?php echo $this->formBean['value']['kind']; ?>" />	  </td>
	  <td align="center"><input name="doDel" type="submit" value="削除" />
	  <input type="hidden" name="id" value="<?php echo $this->formBean['value']['id']; ?>" />
	  <input type="hidden" name="s_id" value="<?php echo $this->formBean['value']['s_id']; ?>" /></td>
	  <td align="center"><input type="submit" name="s_makemessage" value="メッセージ作成">
	  <input type="hidden" name="filename" value="<?php echo $this->formBean['value']['filename']; ?>" />	  </td>
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
			
			
<?php include ('../../View/pagecontrol.tpl'); ?>	<!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->	
				
	<br>
	
		<br />	
				<table width="30%"  align = "center" cellspacing="0">
<form action="<?php echo $this->formBean["to_edit"]; ?>" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doRegister"  value="スケジュール新規作成"></td>
  </tr>
  </form>
  <form action="<?php echo $this->formBean["to_iedit"]; ?>" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doiRegister" value="iスケジュール新規作成"></td>
  </tr>
</form>
</table>			
	<br>	
	<br />				
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