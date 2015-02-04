<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>配信者追加</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style1 {
	font-size: 18px;
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
                                                
                                                <div align="center" class="style1">
                                                  <p>【配信者追加】</p>
                                                </div></td>
                                        </tr>
      </table>
	  <br>   	
	  <form name="form1"  action="<?php echo $this->formBean['to_add_user']; ?>" method="post"  >
	<table width="100%" border="1">
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="93%"><table width="200" border="1" align="center" cellspacing="1"  >
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
        <td align="center" colspan="6"> 該当データがありません。 </td>
      </tr>
      <?php endif; unset($_from); ?>
      <tr>
        <td align="center" colspan="6"><input type="submit" name="btn_select_gp" value="グループ決定" >        </td>
      </tr>
    </table></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td height="27">&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	
	<?php 
		foreach($this->formBean['user_list'] as $gp_id=> $user_list_info){ 
		?>
	
	
	<table width="383" border="1" align="center" cellspacing="1"  id="gp<?php echo $gp_id; ?>">
      <tr class="sty-td1">
        <td width="375" align="center"><p><?php echo $this->formBean["gpname_list"][$gp_id]; ?></p></td>
      </tr>
      <?php 
	$_from = $user_list_info; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    if ($this->foreachArray['loop']['total'] > 0):
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
    $this->foreachArray['loop']['iteration']++;
?>
      <tr <?php if ( $this->foreachArray['loop']['iteration']%2==0 ) echo 'class="odd"' ?> >
        <td align="left"> 
		<input type="checkbox" name="send_userids[]" value="<?php echo $this->formBean['value']['user_id']; ?>" 
		<?php if($this->formBean['value']['is_user_select']) echo 'checked' ?> >
		<?php echo $this->formBean['value']['name']; ?>		</td>
      </tr>
      <?php endforeach;  ?>
	  
	  <tr>
        <td align="center" colspan="6"> <input type="button" value="全選択" 
		onClick=" var <?php echo "gp".$gp_id; ?> = new Group('<?php echo "gp".$gp_id; ?>');<?php echo "gp".$gp_id; ?>.check(); "  />
        <input type="button" value="全解除" 
		onClick=" var <?php echo "gp".$gp_id; ?> = new Group('<?php echo "gp".$gp_id; ?>');<?php echo "gp".$gp_id; ?>.reset(); "  /> </td>
      </tr>
	<?php  else: ?>
      <tr>
        <td align="center" colspan="6"> 該当グループにユーザが存在しません </td>
      </tr>
      <?php endif; unset($_from); ?>
    </table>
	<br>
	<?php } ?>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_change_user_list" value="   ユーザ選択   " >
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="btn_cancel_change" value="   キャンセル   " >
    </div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
	
      <p>&nbsp;</p>
    <p></p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a></td>
    <td>&nbsp;</td>
  </tr>
</table>

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