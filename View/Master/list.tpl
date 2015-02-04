

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>
            管理メニュー
        </title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
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
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td width="35%">&nbsp;                    </td>
                  <td width="38%"><div align="center" class="style1" >【マスタ管理】</div>                    </td>
                    <td width="27%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                    <td align="center">
                        <table width="99%" border="0">
                            <tr>
                                <td width="20%" height="18">&nbsp;                                </td>
                                <td width="79%">&nbsp;                                </td>
                              <td width="1%">&nbsp;                              </td>
                            </tr>
                            <tr>
                                <td height="52">&nbsp;                                </td>
                                <td>
                                  <div align="left">
                                    <table width="305" cellpadding="0" cellspacing="0" border="0" >
                                      
                                      <tr>
                                        <td width="250" align="center">
                                          
                                          <div align="left"><a href="<?php echo $this->formBean["goto_user"]; ?>">●<u>ユーザ管理</u></a>                                            </div></td>
                                        </tr>
                                      </table>
                                  </div></td><td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                              <td height="43">&nbsp;</td>
                              <td> <div align="left"><a href="<?php echo $this->formBean["go_group"]; ?>"> ●<u>グループ管理</u> </a></div></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="43">&nbsp;                                </td>
                                <td>
                             <div align="left"><a href="<?php echo $this->formBean["go_para_setting"]; ?>"> ●<u>パラメータ設定</u> </a></div>       
                                 </td>
                                <td>&nbsp;                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>&nbsp;
                        
                    </td>
                </tr>
                <tr>
                    <td height="51">&nbsp;                    </td>
                    <td><a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a>
                        
                    </td>
                    <td>&nbsp;
                        
                    </td>
                </tr>
            </table>
    </body>

</html>