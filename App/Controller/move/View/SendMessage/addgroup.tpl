<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>配信グループ選択</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
.style2 {font-size: 9px}
-->
    </style>
</head>
<body>
<?php include ('../../View/site.tpl'); ?>
 <form name="form1"  action="<?php echo $this->formBean['to_add_group']; ?>" method="post"  >
<table width="99%" border="0">
  
  <tr>
    <td width="1%" >&nbsp;</td>
    <td width="98%">
	 <table width="100%" border="0">
                                        <tr>
                                          <td> <div align="center" class="style1">
                                                  <p>【配信グループ選択】</p>
                                                </div></td>
                                        </tr>
                                        <tr>
                                            <td height="9">                                               </td>
                                        </tr>
      </table>   	
	 
	  <table width="200" border="0" align="center" cellspacing="1"  >
      <tr class="sty-td1">
        <td width="246" align="center"><p>グループ選択</p></td>
      </tr>
      <?php 
	$_from = $this->formBean['gp_list']; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    if ($this->foreachArray['loop']['total'] > 0):
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
    $this->foreachArray['loop']['iteration']++;
?>
      <tr <?php if ( $this->foreachArray['loop']['iteration']%2==0 ) echo 'class="odd"' ?> >
        <td align="left"><input type="checkbox" name="send_groupids[]" value="<?php echo $this->formBean['value']['id']; ?>" 
		<?php if($this->formBean['value']['is_gp_select']) echo 'checked' ?> >
            <?php echo $this->formBean['value']['group_name']; ?> </td>
      </tr>
      <?php endforeach; else: ?>
      <tr>
        <td align="center" colspan="6"> <span class="style2">該当データがありません。</span> </td>
      </tr>
      <?php endif; unset($_from); ?>
      <tr>
        <td align="center" colspan="6">     </td>
      </tr>
    </table><br>    </td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<?php if(isset($this->formBean["is_exist_group"])&& $this->formBean["is_exist_group"]) {?>
	<div align="center">
      <input type="submit" name="btn_select_gp" value="  グループ決定  "  tabindex="1">   
    </div>
	
	<?php }?>
	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_cancel_change" value="   キャンセル   "  tabindex="2">
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
    <td><div align="center"><a href="<?php echo $this->formBean["go_back"]; ?>" accesskey="0"  tabindex="3">＜＜0:メニューに戻る</a></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>

</body>

<script type="text/javascript">
var Group = function ( parent ) {
　if( parent ) {
　　var prnt = document.getElementById( parent );
　　this.list = prnt.getElementsByTagName( 'INPUT' );
　} else {
　　this.list = [ ];
　}

　this.on = function () {
　　for( var cnt = 0, o; o = this.list[ cnt++ ]; )
　　　o.disabled = false;
　};
　
　this.off = function () {
　　for( var cnt = 0, o; o = this.list[ cnt++ ]; )
　　　o.disabled = true;
　};

　this.reset = function () {
　　for( var cnt = 0, o; o = this.list[ cnt++ ]; )
　　　if( 'checkbox' == o.type ) o.checked = false;
　};

　this.check = function () {
　　for( var cnt = 0, o; o = this.list[ cnt++ ]; )
　　　if( 'checkbox' == o.type ) o.checked = true;
　};

　this.add = function ( group ) {
　　for( var cnt = 0, o; o = group.list[ cnt++ ]; )
　　　this.list.push( o );
　};
};

</script>

</html>