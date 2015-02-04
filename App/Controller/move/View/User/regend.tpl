<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>登録完了</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style3 {font-size: 12}
-->
    </style>
</head>
<body>
      <?php include ('../../View/site.tpl'); ?>
	  <br>
	<table width="100%" border="0">
  <tr>
    <td>&nbsp;</td>
    <td><div align="center"><strong>
	<?php if(isset($this->formBean['info'])) echo $this->formBean['info']; ?>
	</strong></div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="1%">&nbsp;</td>
    <td width="98%"><div align="center">
	<form method="post" action="<?php if(isset($this->formBean['to_menu'])) echo $this->formBean['to_menu']; ?>">
      <input type="submit" name="confirm" value="管理メニューへ       ">
	</form>
	</div></td>
    <td width="1%">&nbsp;</td>
  </tr>
</table>

    
</body>
</html>
