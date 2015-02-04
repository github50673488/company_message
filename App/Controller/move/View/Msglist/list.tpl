<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>メッセージ一覧</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style2 {font-size: 14px}
.style3 {font-size: 11px}
.style4 {font-size: 10px}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>


<table width="100%" border="0">
  <tr>
    <td width="98%"><div align="center" >【メッセージ一覧】
    </div></td>
  </tr>
  <tr>
    <td>
	<div align="center"> 
             <table width="100%" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="30%" align="center" ><span class="style3">作成日</span></td>
                    <td width="48%" align="center"><span class="style3">タイトル</span></td>
                    <td width="22%" align="center"><span class="style3">送信者</span></td>
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
        <td align="center"><span class="style4"><?php echo $this->formBean['value']['entry_date_str']; ?></span></td>
	    <td align="center">
		<a href="<?php echo $this->formBean['value']['detail_link'];?>" >
     		<span class="style2"><?php echo $this->formBean['value']['title']; ?></span>		</a>		</td>
        <td align="center"><span class="style4"><?php echo $this->formBean['value']['stuff_str'];?></span>		</td>
        </form>
  </tr>
<?php endforeach; else: ?>
  <tr>
    <td align="center" colspan="8"> <span class="style2">該当データがありません。 </span></td>
  </tr>
<?php endif; unset($_from); ?>
        </table>
</div>
                <br />
<div align="center"><span class="style3"><?php include ('../../View/pagecontrol.tpl'); ?></span></div>	
<div align="center">
  <!-- ページコントロール 　ＪＳ　chg_page　関数を一緒に使用してくださ-->					
  <br>
  <a href="<?php echo $this->formBean["go_back"]; ?>" accesskey="0" >0:メニューに戻る</a></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>