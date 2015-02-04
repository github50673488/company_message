<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>伝言詳細</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
	</head>
	

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
    <td><p align="center" class="style1">【伝言詳細】
</p></td>
  </tr>
</table>
<br>	

<table width="100%" border="1">
<form  action="<?php if (isset($this->formBean['to_detail'])) echo $this->formBean['to_detail'];?>" method="post" >
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="88%">&nbsp;</td>
    <td width="5%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>タイトル：<?php if (isset($this->formBean['title'])) echo $this->formBean['title'];?><br>	    </td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>詳細：<?php if (isset($this->formBean['detail'])) echo $this->formBean['detail'];?><br>       </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>画像<br>
	    <div align="center">
								<?php 

				if (strlen($this->formBean['map']) > 0)
		    {
		        print "<img name='stdkimg'  onLoad='ResizeImage(300,300);' src=\"../../App/Tools/ShowImage.php?map_id=".$this->formBean['id']."\" /><br>\n";
			}
		?>
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
    <td><div align="center">
      <input type="submit" name="modifybtn" value="修正" />
	  <input type="hidden" name="id" value="<?php echo $this->formBean['id']; ?>" />
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="delbtn" value="削除" />
	 
    </div></td>
    <td>&nbsp;</td>
  </tr>
</form>
</table>


<br>
	<a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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