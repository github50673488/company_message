<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>入力エラー</title>
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
<br>
<table width="100%" border="0">
  <tr>
    <td><div align="center" class="style1">[入力エラー]</div></td>
  </tr>
</table>
<br>
<table width="90%"  align = "center" cellspacing="0">
  <tr align="center">
    <td>

      <b></b><span class="style1"><?php echo $this->formBean["confirmErr"] ?></span><br>
      <br>
      <input type=button onclick='window.close()' value=閉じる>
      <br>
      <br>
    </td>
  </tr>
</table>
</body>
