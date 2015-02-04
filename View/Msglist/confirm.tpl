<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>お知らせ</title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <link rel="stylesheet" href="../../Stuff/css/style2.css" type="text/css"
        />
        <link rel="stylesheet" href="../../Stuff/css/common.css" type="text/css"
        />
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
            <!-- .style2 {font-size: 24px}
-->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
	
        <table width="99%" border="0">
                <tr>
                    <td width="1%">&nbsp;                    </td>
                    <td width="96%">&nbsp;                    </td>
                    <td width="3%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td height="70">&nbsp;
                        
                    </td>
                    <td>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <div align="center" class="style2" >
                                        【メッセージ確認】                                    </div>                                </td>
                            </tr>
                        </table>
                        <br>
						<br>
						<br>
                        <table width="100%" border="0">
                            <tr>
                                <td width="7%" height="47">&nbsp;                              </td>
                                <td valign="top"><div align="right"></div></td>
                                <td valign="top"><strong>★<?php echo $this->formBean["title"]; ?>★ </strong></td>
                                <td width="1%">&nbsp;                              </td>
                            </tr>
							<tr>
							  <td height="18">&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>&nbsp;</td>
						  </tr>
							<tr>
                                <td height="16">&nbsp;                              </td>
                              <td width="29%">                                    <div align="right"></div></td>
                              <td width="63%"><div align="left">■日時<br>
							  &nbsp;&nbsp;&nbsp;&nbsp;<?php echo $this->formBean["entry_date_str"]; ?>
							  </div></td>
                                <td>&nbsp;                              </td>
                            </tr>
							
                            <tr>
                              <td height="23">&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;                              </td>
                                <td>                                     <div align="right"></div></td>
                                <td><div align="left">■本文<br>
								&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $this->formBean["free_word"]; ?></div></td>
                                <td>&nbsp;                              </td>
                            </tr>
							<tr>
							  <td height="29">&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>&nbsp;</td>
						  </tr>
							<tr>
							  <td height="29">&nbsp;</td>
							  <td>							    <div align="right"></div></td>
							  <td><div align="left">■<?php echo $this->formBean["detail"]; ?></div></td>
							  <td>&nbsp;</td>
						  </tr>
							
							<tr>
							  <td height="28">&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>&nbsp;</td>
						  </tr>
						  <?php if(isset($this->formBean["is_file_exist"]) && $this->formBean["is_file_exist"]==1){ ?>
							<tr>
							  <td height="28">&nbsp;</td>
							  <td>&nbsp;</td>
							  <td>添付ファイル：
							<a href="<?php if(isset($this->formBean["filepath"])) echo $this->formBean["filepath"]; ?>">
					<?php if(isset($this->formBean["filetitle"])) echo $this->formBean["filetitle"]; ?></a>							</td>
							  <td>&nbsp;</td>
						  </tr>
						 <?php }?>
						  
							<tr>
							  <td height="28">&nbsp;</td>
							  <td colspan="2"><div align="center"></div></td>
							  <td>&nbsp;</td>
						  </tr>
							<tr>
							  <td height="28">&nbsp;</td>
							  <td colspan="2"><div align="center">
							  <table width="30%"  align = "center" cellspacing="0">
 <form action="<?php echo $this->formBean['to_msg_send']; ?>" method="post">
  <tr>
    <td align="center" width="50%"><input type="submit" name="doRegister"  value="       返信      ">
	<input type="hidden" name="is_from_msg_list" value="<?php echo $this->formBean['is_from_msg_list']; ?>" />
	<input type="hidden" name="reserve_id" value="<?php echo $this->formBean['id']; ?>" />	
	</td>
  </tr>
  </form>
</table>		
							  
							  </div></td>
							  <td>&nbsp;</td>
						  </tr>
							<tr>
							  <td height="28">&nbsp;</td>
							  <td colspan="2"><div align="le"><a href="<?php echo $this->formBean["go_menu"]; ?>"  >＜＜メニューに戻る</a></div></td>
							  <td>&nbsp;</td>
						  </tr>
                        </table>
                        <br>
                        <br>
                       <div align="center">
                                            <div class="return">
                         </div>
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
    </body>

</html>