<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>伝言新規登録</title>
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
    <td><p align="center" class="style1">【伝言新規登録】
</p></td>
  </tr>
</table>
<br>	

<table width="100%" border="1">
<form action="" method="post" enctype="multipart/form-data">
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="88%"><span class="red"><div align="center"><?php if (isset($this->formBean['err'])) echo $this->formBean['err'];?></div></span>
      </td>
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
	    ファイル名：<input name="map_file" type="file" id="map_file" />
		
		</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="submit" name="regbtn" value="登録確認" />
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
</html>