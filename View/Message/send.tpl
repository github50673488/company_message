<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <title>メッセージ配信</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
	<script type="text/javascript" src="FCKeditor/fckeditor.js"></script>		
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAE7ssOeJFTNY-10sx0bwNhhTznr4Q46aU03sQrzV8coAb5h24dxSjI1znVWu70RQqG6CGmuBI3B39qQ" type="text/javascript"></script>

</head>
<body onLoad="on_load()">
<body>
      <?php include ('../../View/site.tpl'); ?>
<table width="99%" border="0">
  
  <tr>
    <td width="10%" >&nbsp;</td>
    <td width="83%">
	  <table width="100%" border="1">
                                        <tr>
                                            <td height="64"><img src="../../Stuff/image/t_menu01.gif" alt="メッセージ配信" width="592" height="50" border="0"
                                                                    /></td>
                                        </tr>
      </table>
	  <br>   	
	  <form name="formgps" action="#" onSubmit="showAddress(this.addressview.value); return false">
	  <div align="center">
	    <table width="100%" border="1" style="display:block" id ="gps" >
	      
	      <tr>
	        <td colspan="4"></td>
        </tr>
	      <tr>
	        <td height="17">&nbsp;</td>
        <td colspan="2"  align="center"><strong>GPS配信設定</strong></td>
        <td colspan="-4">&nbsp;</td>
      </tr>
	      
	      <tr>
	        <td height="18">&nbsp;</td>
	        <td colspan="2" align="left"><input type="text" size="60" name="addressview" value="<?php if(isset($this->formBean['address'])) echo $this->formBean['address'];?>" disabled/>
          <input type="submit" value="検索" /><a target="_blank" href="<?php echo $this->formBean['to_map']; ?>">Googlemap</a>         </td>
	        <td colspan="-4">&nbsp;</td>
	        </tr>
	      <tr>
	        <td height="49" rowspan="7">&nbsp;</td>
        <td width="324" rowspan="7" align="left">
          <div id="map" style="width:450px; height:450px"></div></td>
        <td width="397" height="42" align="center"><div align="left">緯度<br>    
          <input type="text" name="longitudeview" disabled  size="17" value="<?php if(isset($this->formBean['longitude'])) echo $this->formBean['longitude'];?>">
        (23.4209～46.0856)（日本国内に限る）</div></td>
        <td colspan="-4" rowspan="7">&nbsp;</td>
      </tr>
	      <tr>
	        <td height="42" align="center"><div align="left">経度<br> 	          
	          <input type="text" name="latitudeview" disabled size="17" value="<?php if(isset($this->formBean['latitude'])) echo $this->formBean['latitude'];?>">
	          (122.2485～149.1203)（日本国内に限る）</div></td>
	        </tr>
	      <tr>
	        <td height="42" align="center"><div align="left">半径<br>  
	          <input type="text" name="radiusview" disabled size="5" maxlength="5" value="<?php if(isset($this->formBean['radius'])) echo $this->formBean['radius'];?>">
	          (50～10000)単位：メートル</div></td>
	        </tr>
	      <tr>
	        <td height="42" align="center"><div align="left">配信開始日<br> 
	            <input type="text" name="sdateview" disabled size="10" maxlength="8" 
				value="<?php if(isset($this->formBean['sdate'])) echo $this->formBean['sdate'];?>"
				>
	          (例: 20100401)</div></td>
	        </tr>
	      <tr>
	        <td align="center" height="42"><div align="left">
	          配信終了日<br> <input type="text" name="edateview" disabled size="10" maxlength="8" 
			  value="<?php if(isset($this->formBean['edate'])) echo $this->formBean['edate'];?>">
	          (例: 20100402) </div></td>
	        </tr>
	      <tr>
	        <td align="center" height="42"><div align="left">
	          配信開始時刻<br> <input type="text" name="stimeview" disabled size="5" maxlength="4"
			  value="<?php if(isset($this->formBean['stime'])) echo $this->formBean['stime'];?>"
			  >
	          (例: 0910) </div></td>
	        </tr>
	      <tr>
	        <td align="center" height="42"><div align="left">
	          配信終了時刻<br> <input type="text" name="etimeview" disabled size="5" maxlength="4"
			  value="<?php if(isset($this->formBean['etime'])) echo $this->formBean['etime'];?>"
			  >
			  (例: 1650) </div></td>
	        </tr>
	      
	      <tr>
	        <td width="1" height="18">&nbsp;</td>
        <td><div align="left"> <label>
          中心座標：
<input type="text" name="txtmapcenter"  size="40" disabled="disabled">（緯度,経度）
          </label></div></td>
        <td>&nbsp;</td>
        <td width="4" colspan="-4">&nbsp;</td>
      </tr>
        </table>
	    </div>
	</form>
	  
	  
	  
	<form name="form1"   method="post" >
	
	<table width="100%" border="1">
  
  <tr>
    <td width="4%">&nbsp;</td>
    <td width="16%"><div align="right">分類 &nbsp;</div></td>
    <td width="76%">&nbsp;&nbsp;
      <label>
      <input id="sendmode" name="sendmode" type="radio" value="1" checked onClick="igps.off();document.getElementById('gps').style.display='none';document.form1.isgpsview.value=0;">
通常配信 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="sendmode" type="radio" value="2" onClick="igps.on();document.form1.isgpsview.value=1;document.getElementById('gps').style.display='block';">
オートGPS配信</label></td>
    <td width="4%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right">タイトル</div></td>
    <td><textarea cols="28" rows="2" name="title"><?php if(isset($this->formBean["title"])) echo $this->formBean["title"];?></textarea>      
      (全角１４文字×２行)</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right">メール本文</div></td>
    <td> <textarea cols="18" rows="10" name="free_word"><?php if(isset($this->formBean["free_word"])) echo $this->formBean["free_word"];?></textarea>    <font size="2">(全角１２文字×５行
)      </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="right">サイト内容</div></td>
    <td><textarea cols="18" rows="10" name="detail"><?php if(isset($this->formBean["detail"])) echo $this->formBean["detail"];?></textarea>(全角３００文字)  </td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><div align="right">添付ファイル</div></td>
    <td>
     <select id="filelist" name="addfile">
	 <option value="-1" <?= ($this->formBean["isfileselect"] == 0) ? "selected" : ""?>>選択なし</option>
	 <?php foreach($this->formBean["file_name_list"]  as $value)
	 {
	 ?>
	  <option value="<?=$value?>" <?= ($this->formBean["file_name"] == $value && $this->formBean["isfileselect"] == 1 ) ? "selected" : ""?>><?=$value?></option>
	 <?php }?>
    </select> 
			</td>
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
		<INPUT type="hidden" name="isgpsview" >
			</td>
    <td>&nbsp;</td>
  </tr>
</table>


<table width="100%" border="1">
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="50%">&nbsp;</td>
    <td width="30%">&nbsp;</td>
  </tr>
  <tr>
    <td height="52" valign="top"><div align="right">　配信対象
</div></td>
    <td>

 <table width="383" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="375" align="center"><p>配信対象者</p></td>
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
	<input type="hidden" name="user_sendways[]" value="<?php echo $this->formBean['value']['sendway']; ?>" />
	</td>
  </tr>
<?php endforeach; else: ?>
<tr>
    <td align="center" colspan="6"> 該当データがありません。 </td>
  </tr>
<?php endif; ?>
<input type="hidden" name="user_num" value="<?php echo $this->foreachArray['loop']['total']; ?>" />
<?php unset($_from); ?>
			  </table>	</td>
    <td valign="top"><div align="left">
      
      <input type="submit" name="btn_add_user" value="    配信者選択    " 
	  onClick="copyGps();document.form1.target='_self'; document.form1.action='<?php echo $this->formBean["to_add_user"];?>';"></div>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td></td>
  </tr>
</table>
</form>

	<table width="100%" border="0">
      <tr>
        <td>
		<div align="center">
		  <input type="button" name="btn_send_msg" value="    配信確認    "  
		  onClick="if (form_check()) {document.form1.action='<?php echo $this->formBean["to_confirm"];?>';document.form1.target='_blank';document.form1.submit();}" >
		</div>		</td>
      </tr>
      <tr>
        <td><a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a></td>
      </tr>
    </table>
	</td>
    <td width="7%">&nbsp;</td>
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
    var oFCKeditor = new FCKeditor( 'detail' );
    oFCKeditor.BasePath = 'FCKeditor/';
    oFCKeditor.Width = '180';
    oFCKeditor.Height = '200';
    oFCKeditor.ToolbarSet = 'MyToolbar';
    oFCKeditor.ReplaceTextarea();
	
	if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(32.8320206, 130.8171751), 13);
		document.formgps.txtmapcenter.value=map.getCenter().toString();
		map.addControl(new GLargeMapControl());
        var mapControl = new GMapTypeControl();
        map.addControl(mapControl);
		GEvent.addListener(map, "click", function(marker, point) {
  if (marker) {
    map.removeOverlay(marker);
	document.formgps.txtmapcenter.value= center.toString();
  } else {
    map.addOverlay(new GMarker(point));
  }
  
  if (point) {
		document.formgps.longitudeview.value=point.lat();
		document.formgps.latitudeview.value=point.lng();
	}
  
  
});
		
		
		
		GEvent.addListener(map, "moveend", function() {
        var center = map.getCenter();
        document.formgps.txtmapcenter.value= center.toString();
        });
        geocoder = new GClientGeocoder();// GClientGeocoderを初期化
      }
	 
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
        alert("タイトルを入力してください。");
        return(false);
    }
	str = document.form1.title.value;
    str = str.replace(/\r\n/g, "");
    str = str.replace(/\n/g, "");
	str = str.replace(/<\/?[^>]+>/gi, "");
	n = str.length;
	if (n > 28){
        alert("タイトルは28文字以内にしてください。");
        return(false);
    }
	
    if (document.form1.free_word.value == ""){
       alert("メール本文を入力してください。");
       return(false);
    }
	str = document.form1.free_word.value;
    str = str.replace(/\r\n/g, "");
    str = str.replace(/\n/g, "");
	str = str.replace(/<\/?[^>]+>/gi, "");
	n = str.length;
	if (n > 60){
        alert("メール本文は60文字以内にしてください。");
        return(false);
    }

	str = document.form1.detail.value;
    str = str.replace(/\r\n/g, "");
    str = str.replace(/\n/g, "");
	str = str.replace(/<\/?[^>]+>/gi, "");
	n = str.length;
	if (n > 300){
        alert("サイト内容は300文字以内にしてください");
        return(false);
    }
	
	
	if (document.form1.user_num.value==0) {
	   alert("ユーザを選択してください。");
	   return(false);
	}
	
	return(true);
}

var map = null;
    var geocoder = null;
    // 「検索」ボタンを押されると実行されます
    function showAddress(address) {
      if (geocoder) {
        geocoder.getLatLng(
          address,
          function(point) {
            if (!point) {
              alert(address + " not found");
            } else {
              map.setCenter(point, 13);
              var marker = new GMarker(point);
              map.addOverlay(marker);
document.formgps.longitudeview.value = point.lat();
document.formgps.latitudeview.value = point.lng();

//              marker.openInfoWindowHtml(address +
//                         "<br>(lat=" + point.lat() +
//                         ", lng=" + point.lng() + ")");
            }
          }
        );
      }
    }

 function copyGps() {
    document.form1.stime.value=document.formgps.stimeview.value;
	document.form1.etime.value=document.formgps.etimeview.value;
	document.form1.sdate.value=document.formgps.sdateview.value;
	document.form1.edate.value=document.formgps.edateview.value;
	document.form1.longitude.value=document.formgps.longitudeview.value;
	document.form1.latitude.value=document.formgps.latitudeview.value;
	document.form1.radius.value=document.formgps.radiusview.value;
	document.form1.address.value=document.formgps.addressview.value;
  }

</script>


</html>