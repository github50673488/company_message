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
            <!-- .style2 {font-size: 36px} .style3 {font-size: 24px} -->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td width="20%">&nbsp;
                        
                    </td>
                    <td width="60%">&nbsp;
                        
                    </td>
                    <td width="20%">&nbsp;
                        
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                    <td align="center">
                        <table width="99%" border="0">
                            <tr>
                                <td width="16%" height="18">&nbsp;                                </td>
                                <td width="65%">&nbsp;                                </td>
                              <td width="19%">&nbsp;                              </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>
                                    <div align="center">
                                        <table width="305" cellpadding="0" cellspacing="0" border="0" background="../../Stuff/image/bg.gif">
                                            <tr>
                                                <td height="62">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="15">
                                                </td>
                                                <td align="center">
                                                    <table width="250" cellpadding="0" cellspacing="0" border="0">
                                                        
                                                        <tr>
                                                            <td height="40" valign="top">
                                                                <a href="<?php echo $this->formBean["go_msg_send"]; ?>">
                                                                    <img src="../../Stuff/image/menu01.gif" alt="メッセージ配信" width="250" height="30" border="0"
                                                                    />                                                                </a>                                                            </td>
                                                        </tr>
														<tr>
                                                          <td height="40">
														  <a href="<?php echo $this->formBean["go_msg_list"]; ?>">●メッセージ一覧</a></td>
                                                        </tr>
                                                        <tr>
                                                            <td background="../../Stuff/image/menu02_bg.gif">
                                                                <table cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td colspan="2" height="40">                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td rowspan="2" width="20">                                                                        </td>
                                                                        <td height="40" valign="top">
                                                                      <a href="<?php echo $this->formBean["go_toruka_manage"];?>">
                         <img src="../../Stuff/image/menu02-1.gif" alt="トルカ管理" width="183" height="30" border="0"/>                                                                            </a>                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" height="40"><a href="<?php echo $this->formBean["go_schedule_manage"]; ?>"><img src="../../Stuff/image/menu02-2.gif" alt="スケジュール管理" width="183" height="30"
                                                                                border="0" /></a></td>
                                                                    </tr>
                                                                </table>                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="40">
                                                                <a href="<?php echo $this->formBean["go_msgboard_manage"]; ?>">●伝言板管理
</a>                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="40">
                                                                <a href="<?php echo $this->formBean["go_changeuser"]; ?>">
                                                                    <img src="../../Stuff/image/menu04.gif" alt="登録者管理" width="250" height="30" border="0"
                                                                    />                                                                </a>                                                            </td>
                                                        </tr>
																												 <?php 
	if (isset($this->formBean["isAdmin"]) && $this->formBean['isAdmin'])
	{
	?>
                                                        <tr>
                                                            <td height="40">

	
                                            <a href="<?php echo $this->formBean["go_master_manage"]; ?>"> ●マスタ管理
											
                                                                                                                                    </a>                                                            </td>
                                                        </tr>
                                                       	 <?php } ?>
                                                        <tr>
                                                            <td height="6">        </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>&nbsp;
                        
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                    <td>&nbsp;
                        
                    </td>
                    <td>&nbsp;
                        
                    </td>
                </tr>
            </table>
    </body>

</html>