<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>トルカ管理</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">

.style3 {font-size: 11px}
    .style4 {font-size: 14px}
    .style5 {font-size: 11px}
	.style6 {font-size: 9px}
	.style7 {font-size: 8px}
    .style8 {font-size: 12px}
    </style>
</head>
<body>
<?php include ('../../View/site.tpl'); ?>
<table width="99%" border="0">
  <tr>
    <td width="98%"><div align="center" class="style4">【添付ファイル（トルカ）管理】 </div></td>
  </tr>
  <tr>
    <td>
	<div align="center">
	  <table width="99%" border="1" align="center" cellspacing="1"  >
        <tr class="sty-td1">
          <td width="28%" align="center" ><span class="style5">作成日</span></td>
          <td width="63%" align="center"><span class="style5">タイトル</span></td>
          <td width="9%"  align="center" >&nbsp;</td>
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
            <td align="center"><span class="style6"><?php echo $this->formBean['value']['create_date']; ?></span></td>
            <td align="center"><span class="style4"> <a href="<?php echo $this->formBean['value']['detail_link'];?>" > <?php echo $this->formBean['value']['title']; ?> </a> </span>
                <input type="hidden" name="id" value="<?php echo $this->formBean['value']['id']; ?>" />
                <input type="hidden" name="kind" value="<?php echo $this->formBean['value']['kind']; ?>" />
                <input type="hidden" name="filename" value="<?php echo $this->formBean['value']['filename']; ?>" />            </td>
            <td align="center"><input name="t_makemessage" type="submit" class="style7" value="メッセージ作成">            </td>
          </form>
        </tr>
        <?php endforeach; else: ?>
        <tr>
          <td align="center" colspan="8"> <span class="style8">該当データがありません。</span> </td>
        </tr>
        <?php endif; unset($_from); ?>
      </table>
	</div>
              <br>
			
<div align="center"><span class="style3"><?php include ('../../View/pagecontrol.tpl'); ?></span></div>	<!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->	
		<br />	
		<table width="30%"  align = "center" cellspacing="0">
<form action="<?php echo $this->formBean["to_edit"]; ?>" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doRegister" value="トルカ新規作成"></td>
  </tr>
</form>
</table>			
	    <div align="center"><br>
          <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>