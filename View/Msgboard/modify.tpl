<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>伝言修正登録</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
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
    <td >&nbsp;</td>
    <td>
		<table width="100%" border="1">
  <tr>
    <td><p align="center" class="style1">【伝言修正登録】
</p></td>
  </tr>
</table>
<br>	

<table width="100%" border="1">
<form action="" method="post" enctype="multipart/form-data">
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="88%"><span class="red"><div align="center"><?php if (isset($this->formBean['err'])) echo $this->formBean['err'];?></div></span>      </td>
    <td width="5%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>タイトル<br>
	    <input name="title" type="text" 
		value="<?php if (isset($this->formBean['title'])) echo $this->formBean['title'];?>" ></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>詳細<br>
      <textarea name="detail" cols="30" rows="8"><?php if (isset($this->formBean['detail'])) echo $this->formBean['detail'];?></textarea></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>添付画像<br>
	
	<?php 
			if (strlen($this->formBean["map"]) > 0)
		    {
			 print "<img name='stdkimg'  onLoad='ResizeImage(50,50);' src=\"../../App/Tools/ShowImage.php?map_id=".$this->formBean['id']."\" /><br>\n";
			?>
<input name="changefile" type="radio" value="0" checked onClick="document.getElementById('selectfile').style.display='none';">
画像変更しない
<input name="changefile" type="radio" value="1" onClick="document.getElementById('selectfile').style.display='block';"> 
画像変更する
<table width="100%" border="0" style="display:none" id ="selectfile">
  <tr>
    <td>ファイル名：<input name="map_file" type="file" id="map_file" /></td>
  </tr>
</table>
			<?php
			}
            else 
			{ ?>
		ファイル名：<input name="map_file" type="file" id="map_file" />
				<?php } ?></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="regbtn" value="登録確認" />
	  <input type="hidden" name="id" value="<?php echo $this->formBean['id']; ?>" />
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><input type="submit" name="cancelbtn" value="キャンセル" /></div></td>
    <td>&nbsp;</td>
  </tr>
</form>
</table>
	</td>
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