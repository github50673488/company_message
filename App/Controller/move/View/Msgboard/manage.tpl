<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>伝言一覧</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
	<link rel="stylesheet" href="../../Stuff/css/style2.css" type="text/css" />
	<link rel="stylesheet" href="../../Stuff/css/common.css" type="text/css" />
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style2 {font-size: 10px}
.style3 {font-size: 14px}
.style4 {font-size: 11px}
-->
    </style>
</head>
<body>

      <?php include ('../../View/site.tpl'); ?>
	  

<table width="99%" border="0">
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><div align="center">【伝言一覧】</div></td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td height="70">&nbsp;</td>
    <td><div align="center"> 
             <table width="98%" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="31%" align="center"><span class="style3">日付
                    </span>
                    <td width="69%" align="center"><div align="center" class="style3">タイトル
				  </div>                    </tr>
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
    <td align="center"><span class="style2"><?php echo $this->formBean['value']['create_date_str'];?></span></td>
	<td align="center"> 
<a href="<?php echo $this->formBean['value']['detail_link'];?>"><span class="style3"><?php echo $this->formBean['value']['title'];?></span> </a>
<input type="hidden" name="id" value="<?php echo $this->formBean['value']['id']; ?>" />
<input type="hidden" name="create_date_str" value="<?php echo $this->formBean['value']['create_date_str']; ?>" />
		<input type="hidden" name="title" value="<?php echo $this->formBean['value']['title']; ?>" />
		<input type="hidden" name="map" value="<?php echo base64_encode($this->formBean['value']['map']); ?>" />
		<input type="hidden" name="detail" value="<?php echo $this->formBean['value']['detail']; ?>" />	</td>
	</form>
  </tr>
<?php endforeach; else: ?>
  <tr>
    <td align="center" colspan="5"> <span class="style3">該当データがありません。</span> </td>
  </tr>
<?php endif; unset($_from); ?>
        </table>
</div>
<div align="center"><span class="style4"><?php include ('../../View/pagecontrol.tpl'); ?></span></div>	<!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->	
		<br />					
<table width="30%"  align = "center" cellspacing="0">
<form action="" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doRegister" value="伝言新規作成">
      </td>
  </tr>
</form>
</table>
<br>
<div class="return">  
  <div align="center"><a href="<?php echo $this->formBean["go_menu"]; ?>"  accesskey="0" >0:メニューに戻る</a></div>
</div></td>
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