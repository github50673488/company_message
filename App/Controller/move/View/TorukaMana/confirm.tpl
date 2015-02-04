<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>トルカ登録確認</title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">

-->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td colspan="3">                    
                        
                      <div align="center" class="style2">【トルカ登録確認画面】</div>                    </td>
                </tr>
                <tr>
                    <td width="4%">&nbsp;                    </td>
                  <td width="95%">
                        
                        <form action="" method="post">
                            <table width="98%" border="0">
                                <tr>
                                  <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <p class="style4">
                                  登録内容                                        </p>                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="style4">
                                      ●分類<span class="style3">：</span></span>
                                        <span class="style4"><?php echo $this->formBean["kind_name"] ?> 
										<input type="hidden" name="kind" value="<?php echo $this->formBean["kind"] ?>">										                                                                                                           
									  </span></td>
                                    <td width="4%">&nbsp; </td>
                                </tr>
                                <tr>
                                    <td><span class="style4">
                                      ●タイトル<span class="style3">：</span></span>
                                         <span class="style4"><?php echo $this->formBean["title"] ?> 
										 <input type="hidden" name="title" value="<?php echo $this->formBean["title"] ?>">                                                                                                           
									  </span></td>
                                    <td>&nbsp; </td>
                                </tr>
                                <tr>
                                    <td><span class="style4">
                                      ●本文<span class="style3">：</span></span>
                                         <span class="style4"><?php echo $this->formBean["content"] ?> 
										 <input type="hidden" name="content" value="<?php echo $this->formBean["content"] ?>">                                                                                                           
									  </span></td>
                                    <td>&nbsp; </td>
                                </tr>
                                
                                <tr>
                                  <td><span class="style3"><span class="style4">●</span>見出し：</span><span class="style4"><?php echo $this->formBean["subtitle"] ?> 
										 <input type="hidden" name="subtitle" value="<?php echo $this->formBean["subtitle"] ?>">                                                     
								  </span></td>
                                  <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <p class="style4">
                                  で登録します。よろしいですか？                                        </p>                                    </td>
                                    <td>&nbsp; </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p class="style4">
                                  ※iトルカを編集している場合は、更新を実施します                                        </p>                                    </td>
                                    <td>&nbsp; </td>
                                </tr>
                                
                                
                                <tr>
                                    <td>&nbsp;                                                                                                                                                </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div align="center">
                                          <input type="submit" name="update" value="登録">
                                          <input type="hidden" name="id" value="<?php echo $this->formBean["id"] ?>">                                                                                                                                                                            
                                        </div></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><div align="center"><span class="red"><?php if(isset($this->formBean["err"])) echo $this->formBean["err"] ?></span>
                     </div>                                                                                                                                                                                        </td>
                                </tr>
                            </table>
                        </form>
                        <div align="center"><br>
                            <a href="<?php echo $this->formBean["cancel"]; ?>">
                              ＜＜キャンセル                          </a>
                            <br>
                        <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a>                        </div></td>
                    <td width="1%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td>&nbsp;                    </td>
                    <td>&nbsp;                    </td>
                    <td>&nbsp;                    </td>
                </tr>
            </table>
    </body>

</html>