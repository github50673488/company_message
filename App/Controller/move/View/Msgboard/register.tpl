<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>伝言新規登録</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--

.style4 {font-size: 14px}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>
<table width="99%" border="0">
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><div align="center">【伝言新規登録】 </div></td>
    <td width="1%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>	
<table width="100%" border="0">
<form action="" method="post" enctype="multipart/form-data">
  
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><span class="style3">タイトル<br>
	    <input name="title" type="text" 
		value="<?php if (isset($this->formBean['title'])) echo $this->formBean['title'];?>" >
    </span></td>
    <td width="1%">&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">詳細<br>
        <textarea name="detail" cols="30" rows="6"><?php if (isset($this->formBean['detail'])) echo $this->formBean['detail'];?></textarea>
    </span></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><span class="style3">添付画像<br>
	
	        <input name="map_file" type="file" id="map_file" />
		
		</span></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><?php if (isset($this->formBean['err'])) echo $this->formBean['err'];?></div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="regbtn" value=" 登録確認 " />
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
    <td><div align="center"><a href="<?php echo $this->formBean["go_menu"]; ?>"  accesskey="0" >0:メニューに戻る</a></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>