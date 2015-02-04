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
            <!-- .style5 {font-size: 24px}
-->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
		
			<table width="100%" border="0">
  <tr>
    <td><div align="center" class="style5" >【メニュー】</div></td>
  </tr>
</table>
<table width="450" border="0">
  
  <tr>
    <td width="8">&nbsp;</td>
    <td width="413"><table  cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="415" height="40"  valign="middle">
                                                               <a href="<?php echo $this->formBean["to_sendmessage"]; ?>">                                                                 <p>●メッセージ配信</p>
																</a></td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td height="40">
                                                                <a href="<?php echo $this->formBean["go_msg_list"]; ?>">                                                                 <p>●メッセージ一覧</p>
																</a>                                                               </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="40">
                                                                
                                                                    ●添付ファイル管理<br>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $this->formBean["to_toruka_mana"]; ?>" >●トルカ</a><br>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $this->formBean["to_schedule_mana"]; ?>" >●スケジュール</a>                                                            </td>
                                                        </tr>
                                                        <tr>
                                                          <td height="40">
														  <a href="<?php echo $this->formBean["to_msg_board"]; ?>">
																●伝言板                                                                </a>    </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="40">
                                                                <a href="<?php echo $this->formBean["to_toruka"]; ?>">
																●iトルカDL                                                                </a>                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="40">
                                                                <a href="<?php echo $this->formBean["to_schedule"]; ?>">
                                                                    ●iスケジュールDL                                                                </a>                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="40">
                                                                <a href="<?php echo $this->formBean["to_user"]; ?>">
                                                                   ●登録情報変更                                                                </a>                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td height="6">                                                            </td>
                                                        </tr>
                                              </table></td>
    <td width="7">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

		
		
		                                
		
		
    </body>

</html>