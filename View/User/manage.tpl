<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>登録者管理</title>
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
    <td width="60%">&nbsp;</td>
    <td width="20%">&nbsp;</td>
  </tr>
  <tr>
    <td height="70">&nbsp;</td>
    <td>
	<table width="100%" border="1">
  <tr>
    <td>
	 <img src="../../Stuff/image/t_menu04.gif" alt="登録者管理" width="592" height="60" border="0"/>  
	</td>
  </tr>
</table>
	<br>
	<table width="389"  align = "center" cellspacing="0">
<form action="" method="post">
  <tr>
    <td align="right">ユーザID</td>
    <td><input type="text" name="serarch_user_id" size="10" maxlength="10" value = ""></td>
    <td><input type="submit" name="btn_search_id" value="検索"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="30%" align="right">所属Gr</td>
    <td width="19%">	<div align="right">
      <?php 
	if (isset($this->formBean["gpLst"]) && count($this->formBean['gpLst'])>0)
	{
	   echo $this->html_options(array('name' => 'gpLst','options' => $this->formBean['gpLst'],'selected' => $this->formBean['group_id']));
	}?>
    </div></td>
    <td width="24%"><input type="submit" name="btn_search_group" value="検索"></td>
    <td width="27%">&nbsp;</td>
  </tr>
</form>
</table>

	<hr>
	<div align="center"> 
             <table width="534" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="155" align="center" >ユーザID</td>
                    <td width="366" align="center">所属Gr</td>
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
    <td align="center" >
	<a href="<?php echo $this->formBean['value']['detail_link'];?>" >
	<?php echo $this->formBean['value']['user_id'];?></a>	
	<input type="hidden" name="id" value="<?php echo $this->formBean['value']['id']; ?>" />	</td>
    <td align="center"><?php echo $this->formBean['value']['group_name'];?></td>
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
		<br />					
        <?php include ('../../View/pagecontrol.tpl'); ?>
        <table width="30%"  align = "center" cellspacing="0">
<form action="" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doRegister" value="新規登録"></td>
  </tr>
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