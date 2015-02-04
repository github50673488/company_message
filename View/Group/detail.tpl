<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>グループ詳細</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
	<link rel="stylesheet" href="../../Stuff/css/style2.css" type="text/css" />
	<link rel="stylesheet" href="../../Stuff/css/common.css" type="text/css" />
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
    <td width="60%"><div align="center" class="style1">【グループ詳細】</div></td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td height="42">&nbsp;</td>
    <td valign="bottom"><div align="center">グループ名：<?php echo $this->formBean['group_name'];?>
</div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="70">&nbsp;</td>
    <td>
	<table width="100%" border="1">
  <tr>
    <td>	</td>
  </tr>
</table>
	<br>
	<div align="center"> 
             <table width="383" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="375" align="center">所属者ID</td>
                    <td width="375" align="center">所属者名前</td>
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
    <td align="center"><?php echo $this->formBean['value']['user_id'];?></td>
    <form action="" method="post">
    <td align="center"><?php echo $this->formBean['value']['name'];?></td>
	</form>
  </tr>
<?php endforeach; else: ?>
  <tr>
    <td align="center" colspan="7"> 該当データがありません。 </td>
  </tr>
<?php endif; unset($_from); ?>
        </table>
</div>
                <br />
      <!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->					
     
        <table width="30%"  align = "center" cellspacing="0">
<form action="" method="post">
  <tr>
    <td align="center"><input type="submit" name="btn_changname" value="グループ名修正">
	<input type="hidden" name="id" value="<?php echo $this->formBean['id']; ?>" />
	<input type="hidden" name="group_name" value="<?php echo $this->formBean['group_name']; ?>" />
	</td>
  </tr>
  <?php if ($this->formBean["is_can_del"])  {?>
  <tr>
    <td align="center" width="50%"><input type="submit" name="btn_delgroup" value=" グループ削除 "></td>
  </tr>
   <?php }?>
  
  
</form>
</table>
<div class="return">  <a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a></div></td>
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