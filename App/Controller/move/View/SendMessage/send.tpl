<html><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <title>メッセージ配信</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
	<!--<script type="text/javascript" src="FCKeditor/fckeditor.js"></script>	-->	
		<!--<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAE7ssOeJFTNY-10sx0bwNhhTznr4Q46aU03sQrzV8coAb5h24dxSjI1znVWu70RQqG6CGmuBI3B39qQ" type="text/javascript"></script>-->

        <style type="text/css">
<!--
.style1 {font-size: 10px}
.style2 {font-size: 9px}
-->
        </style>
</head>
<body onLoad="on_load()">
<body>
      <?php include ('../../View/site.tpl'); ?>
<table width="95%" border="0">
  
  <tr>
    <td width="1%" >&nbsp;</td>
    <td width="98%">
	  <table width="100%" border="0">
                                        <tr>
                                            <td><div align="center">[メッセージ配信]</div></td>
                                        </tr>
      </table>	
	  <form name="formgps" action="#" onSubmit="showAddress(this.addressview.value); return false">
	  <div align="center">
	   <table width="98%" border="0" style="display:block" id ="gps" >
	   <!-- <table width="98%" border="0" style="display:none" id ="gps" >-->
	      
	      <tr>
	        <td colspan="4"></td>
        </tr>
	      <tr>
	        <td height="17">&nbsp;</td>
        <td colspan="2"  align="center"><strong>GPS配信設定</strong></td>
        <td colspan="-4">&nbsp;</td>
      </tr>	     
		<!--	
	      <tr>
	        <td height="49">&nbsp;</td>
        <td colspan="2" align="left">
          <div id="map" style="width:200px; height:200px" ></div>
		  </td>
        <td colspan="-4">&nbsp;</td>
      </tr>-->
	      

	      <tr>
	        <td height="18">&nbsp;</td>
	        <td width="699"><div align="left"><span class="red">緯度</span> <br>
	            <input type="text" istyle="4" format="*N" MODE="numeric" name="longitudeview" disabled  size="15" value="<?php if(isset($this->formBean['longitude'])) echo $this->formBean['longitude'];?>">
	            <br>
          <span class="style2">(+23.25.15.320～+46.05.08.433)</span></div></td>
	        <td width="3"></td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      <tr>
	        <td height="18">&nbsp;</td>
	        <td><div align="left"><span class="red">経度</span><br> 	          
	          <input type="text" istyle="4" format="*N" MODE="numeric" name="latitudeview" disabled size="15" value="<?php if(isset($this->formBean['latitude'])) echo $this->formBean['latitude'];?>"><br>
	          <span class="style2">(+122.14.54.826～+149.7.13.229)</span></div></td>
	        <td>&nbsp;</td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
			<tr>
	        <td height="18">&nbsp;</td>
	        <td><div align="left"> 	          
	          <input type="button" name="cancel" onclick="location.href=' <?php if(isset($this->formBean['operarea_url'])) echo $this->formBean['operarea_url'];?>'" value="オープンiエリア">
	          <span class="style2"></span></div></td>
	        <td>&nbsp;</td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      
	      <tr>
	        <td height="18">&nbsp;</td>
	        <td><div align="left"><span class="red">半径 </span><br>
	          <input type="text" istyle="4" format="*N" MODE="numeric" name="radiusview" disabled size="5" maxlength="5" value="<?php if(isset($this->formBean['radius'])) echo $this->formBean['radius'];?>">
	          <span class="style2">(50～10000)</span></div></td>
	        <td>&nbsp;</td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      <tr>
	        <td height="18">&nbsp;</td>
	        <td><div align="left"><span class="red">配信開始日</span><br>
	            <input type="text" istyle="4" format="*N" MODE="numeric" name="sdateview" disabled size="9" maxlength="8" 
				value="<?php if(isset($this->formBean['sdate'])) echo $this->formBean['sdate'];?>"
				>
	            <span class="style2">(例: 20100401)</span></div></td>
	        <td>&nbsp;</td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      <tr>
	        <td height="18">&nbsp;</td>
	        <td><div align="left">
	          <span class="red">配信終了日</span><br> 
	          <input type="text" istyle="4" format="*N" MODE="numeric" name="edateview" disabled size="9" maxlength="8" 
			  value="<?php if(isset($this->formBean['edate'])) echo $this->formBean['edate'];?>">
	          <span class="style2">(例: 20100402)</span></div></td>
	        <td></td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      <tr>
	        <td height="18">&nbsp;</td>
	        <td><div align="left">
	          <span class="red">配信開始時刻</span><br>
	          <input type="text" istyle="4" format="*N" MODE="numeric" name="stimeview" disabled size="5" maxlength="4"
			  value="<?php if(isset($this->formBean['stime'])) echo $this->formBean['stime'];?>"
			  >
	          <span class="style2">(例: 0910) </span></div></td>
	        <td>&nbsp;</td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      <tr>
	        <td width="1" height="18">&nbsp;</td>
        <td><div align="left">
	          <span class="red">配信終了時刻</span><br>
	          <input type="text" istyle="4" format="*N" MODE="numeric" name="etimeview" disabled size="5" maxlength="4"
			  value="<?php if(isset($this->formBean['etime'])) echo $this->formBean['etime'];?>"
			  >
			  <span class="style2">(例: 1650) </span></div></td>
        <td></td>
        <td width="1" colspan="-4">&nbsp;</td>
      </tr>
        </table>
	    </div>
	</form>
	  <hr>
	  
	  
	<form name="form1"   method="post" >
	
	<table width="100%" border="0">
  
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="10%" valign="middle"><div align="right" class="red" ><strong>分類 </strong></div></td>
    <td width="88%">
      <label>
      <input id="sendmode" name="sendmode" type="radio" value="1" checked onClick=";igps.off();document.getElementById('gps').style.display='none';document.form1.isgpsview.value=0; document.form1.btn_add_user.focus();">
通常配信 <br>
<input name="sendmode" type="radio" value="2" onClick="igps.on();document.form1.isgpsview.value=1;document.getElementById('gps').style.display='block';
document.formgps.addressview.focus();
">
オートGPS配信<br>
      </label></td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right" class="red"><strong>タイトル</strong></div></td>
    <td><textarea cols="28" rows="2" name="title"><?php if(isset($this->formBean["title"])) echo $this->formBean["title"];?></textarea>      
      <br><font size="2">(全角１４文字×２行)</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right" class="red"><strong>メール本文</strong></div></td>
    <td> <textarea cols="18" rows="10" name="free_word"><?php if(isset($this->formBean["free_word"])) echo $this->formBean["free_word"];?></textarea>    <font size="2"><br>(全角１２文字×５行
)      </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right" class="red"><strong>サイト内容</strong></div></td>
    <td><textarea cols="18" rows="10" name="detail"><?php if(isset($this->formBean["detail"])) echo $this->formBean["detail"];?></textarea><br><font size="2">(全角３００文字)  </td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td></td>
    <td>
	<div align="right" class="red">
	  <div align="left"><strong>添付ファイル</strong></div>
	</div>
     <select id="filelist" name="addfile">
	 <option value="-1" <?= ($this->formBean["isfileselect"] == 0) ? "selected" : ""?>>選択なし</option>
	 <?php foreach($this->formBean["file_name_list"]  as $value)
	 {
	 ?>
	  <option value="<?=$value?>" <?= ($this->formBean["file_name"] == $value && $this->formBean["isfileselect"] == 1 ) ? "selected" : ""?>><?=$value?></option>
	 <?php }?>
    </select>			</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><INPUT type="hidden" name="stime" >
		<INPUT type="hidden" name="etime" >
		<INPUT type="hidden" name="sdate" >
		<INPUT type="hidden" name="edate" >
		<INPUT type="hidden" name="longitude" >
		<INPUT type="hidden" name="latitude" >
		<INPUT type="hidden" name="radius" >
		<INPUT type="hidden" name="address" >
		<INPUT type="hidden" name="isgpsview" >			</td>
    <td>&nbsp;</td>
  </tr>
</table>

 <hr>

<table width="100%" border="0">
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="96%">
      
      <div align="center">
        <input type="submit" name="btn_add_user" value="    配信者選択    " 
	  onClick="copyGps();document.form1.target='_self'; document.form1.action='<?php echo $this->formBean["to_add_group"];?>';">
      </div></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td height="52" valign="top"></td>
    <td>

 <table width="95%" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="375" align="center"><p align="center">配信対象者</p></td>
                  </tr>
<?php 
	$_from = $this->formBean['user_list']; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    if ($this->foreachArray['loop']['total'] > 0):
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
    $this->foreachArray['loop']['iteration']++;
?>
  <tr <?php if ( $this->foreachArray['loop']['iteration']%2==0 ) echo 'class="odd"' ?> >
	<td align="center">
	<?php echo $this->formBean['value']['name'];?>
	<input type="hidden" name="send_groupids[]" value="<?php echo $this->formBean['value']['group_id']; ?>" />	
	<input type="hidden" name="send_userids[]" value="<?php echo $this->formBean['value']['user_id']; ?>" />
	<input type="hidden" name="send_userids_name[]" value="<?php echo $this->formBean['value']['name']; ?>" />
	<input type="hidden" name="user_sendways[]" value="<?php echo $this->formBean['value']['sendway']; ?>" />	</td>
  </tr>
<?php endforeach; else: ?>
<tr>
    <td align="center" colspan="6"> <span class="style1">該当データがありません </span></td>
  </tr>
<?php endif; ?>
<input type="hidden" name="user_num" value="<?php echo $this->foreachArray['loop']['total']; ?>" />
<?php unset($_from); ?>
			  </table>	</td>
    <td valign="top">	</td>
  </tr>
</table>
</form>
<br>
	<table width="100%" border="0">
      <tr>
        <td>
		<div align="center">
		  <input type="button" name="btn_send_msg" value="    配信確認    "  
		  onClick="if (form_check()) {document.form1.action='<?php echo $this->formBean["to_confirm"];?>';document.form1.target='_blank';document.form1.submit();}" >
		</div>		</td>
      </tr>
      <tr>
        <td><div align="center">
		<span class="style1">
         <div  class="red" ><strong>
            <label id="senderrmsg" style="visibility:hidden">             </label>
			 </strong></div>
			 </span>
          </div>
		 </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><div align="center"><a href="<?php echo $this->formBean["go_back"]; ?>" accesskey="0" >＜＜0:メニューに戻る</a></div></td>
      </tr>
    </table>
	</td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td></td>
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

var igps = new Group('gps');

function on_load() {	 
	  <?php if ($this->formBean["isgpsview"]==1) {?>
	document.form1.sendmode[1].checked=true;
	igps.on();
	document.form1.isgpsview.value=1;
	document.getElementById('gps').style.display='block';
	    <?php } else {?>
		 document.form1.sendmode[0].checked=true;
	igps.off();
	document.form1.isgpsview.value=0;
	document.getElementById('gps').style.display='none';
		  <?php 
		  }?>
	  
	  var today=new Date();
	  var tyear=padLeft(today.getYear()+"","0",4);
	  var tmonth=padLeft((today.getMonth()+1)+"","0",2);
	  var tdate=padLeft(today.getDate()+"","0",2);
	  
      var sday = DateAdd("n",5,today);
	  var shour=padLeft(sday.getHours()+"","0",2);
	  var sminu=padLeft(sday.getMinutes()+"","0",2);
	  var eday = DateAdd("n",60,sday);
	  var ehour=padLeft(eday.getHours()+"","0",2);
	  var eminu=padLeft(eday.getMinutes()+"","0",2);
	  
	    <?php if ($this->formBean["isFromOperArea"]==1) {?>
		  document.formgps.radiusview.focus();
		 <?php } else {?>
	  document.form1.btn_add_user.focus();
	  <?php 
		  }?>
      //document.formgps.sdateview.value= tyear+tmonth+tdate;
	  //document.formgps.edateview.value= tyear+tmonth+tdate;
	  //document.formgps.stimeview.value= shour+sminu;
	  //document.formgps.etimeview.value= ehour+eminu;
	 
}


function DateAdd(interval,number,date){ 
number = parseInt(number);
if (typeof(date)=="string"){
date = date.split(/D/);
eval("var date = new Date("+date.join(",")+")");
}
if (typeof(date)=="object"){
var date = date
}
switch(interval){
case "y": date.setFullYear(date.getFullYear()+number); break;
case "m": date.setMonth(date.getMonth()+number); break;
case "d": date.setDate(date.getDate()+number); break;
case "w": date.setDate(date.getDate()+7*number); break;
case "h": date.setHours(date.getHour()+number); break;
case "n": date.setMinutes(date.getMinutes()+number); break;
case "s": date.setSeconds(date.getSeconds()+number); break;
case "l": date.setMilliseconds(date.getMilliseconds()+number); break;
}
return date;
}


function padLeft(str, pad, count) 
{
   while(str.length<count)
   {
     str=pad+str;
	}
return str;
}

function form_check()
{
	copyGps();
	if (document.form1.title.value == ""){
		show_send_err_msg("タイトルを入力してください");
        return(false);
    }
	str = document.form1.title.value;
    str = str.replace(/\r\n/g, "");
    str = str.replace(/\n/g, "");
	str = str.replace(/<\/?[^>]+>/gi, "");
	n = str.length;
	if (n > 28){
		show_send_err_msg("タイトルは28文字以内にしてください");
        return(false);
    }
	
    if (document.form1.free_word.value == ""){
		show_send_err_msg("メール本文を入力してください");
       return(false);
    }
	str = document.form1.free_word.value;
    str = str.replace(/\r\n/g, "");
    str = str.replace(/\n/g, "");
	str = str.replace(/<\/?[^>]+>/gi, "");
	n = str.length;
	if (n > 60){
	   show_send_err_msg("メール本文は60文字以内にしてください。");
        return(false);
    }

	str = document.form1.detail.value;
    str = str.replace(/\r\n/g, "");
    str = str.replace(/\n/g, "");
	str = str.replace(/<\/?[^>]+>/gi, "");
	n = str.length;
	if (n > 300){
        show_send_err_msg("サイト内容は300文字以内にしてください");
        return(false);
    }
	
	if (document.form1.user_num.value==0) {
	   show_send_err_msg("ユーザを選択してください。");
	   return(false);
	}
	document.getElementById("senderrmsg").style.visibility ="hidden";
	return(true);
}

function show_send_err_msg(err_msg)
{
   document.getElementById("senderrmsg").style.visibility ="visible";
   document.getElementById("senderrmsg").innerHTML =err_msg;
}



 function copyGps() {
    document.form1.stime.value=document.formgps.stimeview.value;
	document.form1.etime.value=document.formgps.etimeview.value;
	document.form1.sdate.value=document.formgps.sdateview.value;
	document.form1.edate.value=document.formgps.edateview.value;
	document.form1.longitude.value=document.formgps.longitudeview.value;
	document.form1.latitude.value=document.formgps.latitudeview.value;
	document.form1.radius.value=document.formgps.radiusview.value;
	//document.form1.address.value=document.formgps.addressview.value;
  }

</script>


</html>