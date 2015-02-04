<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>メッセージ一覧</title>
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
    <td width="5%">&nbsp;</td>
    <td width="91%"><div align="center" class="style1">【メッセージ一覧】
    </div></td>
    <td width="4%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>
		<table width="389"  align = "center" cellspacing="0">

  <tr>
    <td width="30%" align="left">
	
	 
	
	</td>
    
  </tr>

</table>
<br>
<br>
	<div align="center"> 
	
             <table width="900" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="96" align="center" class="sty-td1">　　　作成日</td>
                    <td width="111" align="center">　　分類</td>
                    <td width="197" align="center">　　　タイトル</td>
                    <td width="180" align="center">　　　送信者</td>
                    <td width="67"  align="center" >&nbsp;</td>
					<td width="82"  align="center" >&nbsp;</td>
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
        <td align="center"><?php echo $this->formBean['value']['entry_date_str']; ?></td>
	    <td align="center"><?php echo $this->formBean['value']['send_mode_str']; ?></td>
    	<td align="center"><?php echo $this->formBean['value']['title']; ?></td>
        <td align="center"><?php echo $this->formBean['value']['stuff_str'];?></td>
        <td align="center"><input name="reMessage" type="submit" value="返信" /></td>
		<td align="center"><input name="doDel" type="submit" value="削除" />
		<input type="hidden" name="id" value="<?php echo $this->formBean['value']['id']; ?>" />	
		<input type="hidden" name="title" value="<?php echo $this->formBean['value']['title']; ?>" />	
		<input type="hidden" name="entry_date_str" value="<?php echo $this->formBean['value']['entry_date_str']; ?>" />	
		<input type="hidden" name="free_word" value="<?php echo $this->formBean['value']['free_word']; ?>" />
		<input type="hidden" name="detail" value='<?php echo $this->formBean['value']['detail']; ?>' />
		<input type="hidden" name="addfilename" value="<?php echo $this->formBean['value']['addfilename']; ?>" />
		<input type="hidden" name="addfiletitle" value="<?php echo $this->formBean['value']['addfiletitle']; ?>" />	
	</td>
    </form>
  </tr>
<?php endforeach; else: ?>
  <tr>
    <td align="center" colspan="11"> 該当データがありません。 </td>
  </tr>
<?php endif; unset($_from); ?>
        </table>
</div>
                <br />
				 <br />
<?php include ('../../View/pagecontrol.tpl'); ?>	
<!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->	
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