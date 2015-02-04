<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>伝言修正登録</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style3 {
	font-size: 12px;
	color: #FF0000;
}
-->
    </style>
</head>
<body onLoad="on_load()">
      <?php include ('../../View/site.tpl'); ?>
	  <div align="center"></div>
	  <form  name="form1" action="" method="post" enctype="multipart/form-data">
	  <table width="100%" border="0">

  <tr>
    <td>&nbsp;</td>
    <td><div align="center">【伝言修正登録】</div></td>
    <td></td>
  </tr>
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%">タイトル<br>
    <input name="title" type="text" 
		value="<?php if (isset($this->formBean['title'])) echo $this->formBean['title'];?>" ></td>
    <td width="1%"></td>
    </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>詳細<br>
      <textarea name="detail" cols="30" rows="6"><?php if (isset($this->formBean['detail'])) echo $this->formBean['detail'];?></textarea></td>
    <td></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td>添付画像<br>
      <?php 
			if (strlen($this->formBean["map"]) > 0)
		    {
			 print "<img name='stdkimg'  onLoad='ResizeImage(50,50);' src=\"../../App/Tools/ShowImage.php?map_id=".$this->formBean['id']."\" /><br>\n";
			?>
      <input name="changefile" type="radio" value="0"  onClick="document.getElementById('selectfile').style.display='none';">
画像変更しない<br>
<input name="changefile" type="radio" value="1" checked onClick="document.getElementById('selectfile').style.display='block';">
画像変更する
<table width="100%" border="0" style="display:block" id ="selectfile">
  <tr>
    <td><input name="map_file" type="file" id="map_file" /></td>
  </tr>
</table>
<?php
			}
            else 
			{ ?>
<br>
<input name="map_file" type="file" id="map_file"  />
<?php } ?></td>
    <td>&nbsp;</td>
    </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><span class="style3"> <?php if (isset($this->formBean['err'])) echo $this->formBean['err'];?></span>
     </div></td>
    <td></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="regbtn" value=" 登録確認 " />
	  <input type="hidden" name="id" value="<?php echo $this->formBean['id']; ?>" />
    </div></td>
    <td></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><input type="submit" name="cancelbtn" value="キャンセル" /></div></td>
    <td></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a></div></td>
    <td></td>
    </tr>
</table>
</form>

</body>
<script type="text/javascript">
function on_load() {
document.form1.changefile[0].checked=true;
document.getElementById('selectfile').style.display='none';
};

function ResizeImage( max_width, max_height) 
{
	var _image=document.forms[0].stdkimg;
    var _width = _image.width;
    var _height = _image.height;
    var width_ratio = _width / max_width;
    var height_ratio = _height / max_height;
    if ( width_ratio >= height_ratio && _image.width > max_width) 
	{
        _image.width = max_width;
		
    }
    else if (height_ratio > width_ratio && _image.height > max_height) {
        _image.height = max_height;
		
     }
	
}
</script>
</html>