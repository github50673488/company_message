<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>トルカ詳細</title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
            <!-- .style2 {font-size: 14px}

-->
        </style>
    </head>
    
    <body>
	
        <?php include ( '../../View/site.tpl'); ?>
		
            <table width="99%" border="0">
                <tr>
                    <td width="1%">&nbsp;                    </td>
                    <td width="98%">
                        
                  <div align="center" class="style2">【添付ファイル（トルカ）詳細】</div></td>
                    <td width="1%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                  <td>
						<form action="" method="post">
                        <table width="100%" border="0">
                            
                            <tr>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td width="3%">&nbsp;                                </td>
                                <td>
                                  <span class="style3"><span class="red">タイトル：</span>
                                  <?php if (isset($this->formBean["title"])) echo $this->formBean["title"] ?>                                
                                  </span></td>
                            </tr>
                            
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <p class="style3">
                                        <span class="red">本文：</span>
                                        <?php if (isset($this->formBean["content"])) {echo $this->formBean["content"];} ?>
                                    </p>                                                                </td>
                            </tr>
                            
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <p class="style3">
                                        <span class="red">見出し：</span>
                                      <?php if (isset($this->formBean["subtitle"])) echo $this->formBean["subtitle"] ?>
                                    </p>                                                                </td>
                            </tr>
                            
                            <tr>
                              <td>&nbsp;</td>
                              <td><span class="style3"><span class="red">作成日：</span>
                              <?php if (isset($this->formBean["create_date"])) echo $this->formBean["create_date"] ?>
                              </span></td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td><span class="style3"><span class="red">作成者：</span>
                              <?php if (isset($this->formBean["create_user"])) echo $this->formBean["create_user"] ?>
                              </span></td>
                            </tr>
                            
                            <tr>
                              <td>&nbsp;</td>
                              <td><a href="<?php echo $this->formBean['down_link'];?>" class="style3" >
	ダウンロード</a></td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
									    <div align="center">
										<input type="submit" name="btn_edit" value="  編集  ">
									     <input type="hidden" name="id" value="<?php if (isset($this->formBean["id"])) echo $this->formBean["id"] ?>">                                
							      </div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td><div align="center">
                                  <input type="submit" name="btn_del" value="  削除  ">
                                </div></td>
                            </tr>
                        </table>
						</form>
                        <div align="center">
                            <br>
                            <a href="<?php echo $this->formBean["to_mana"]; ?>">
                              ＜＜トルカ管理に戻る

                          </a>
                            <br>
                            <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a>
                        </div></td>
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