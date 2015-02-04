<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>スケジュール詳細</title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
            <!-- .style2 {
	font-size: 12px;
	font-weight: bold;
}
.style9 {font-size: 18}

-->
        </style>
    </head>
    
    <body>
	
        <?php include ( '../../View/site.tpl'); ?>
		
            <table width="99%" border="0">
                <tr>
                    <td width="1%">&nbsp;                    </td>
                    <td width="98%">
                        
                  <div align="center" class="style2">【添付ファイル(スケジュール)詳細】</div></td>
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
                            </tr>
                            <tr>
                              <td><span class="style6"><span class="red">タイトル：</span>
                              <?php if (isset($this->formBean["title"])) {echo $this->formBean["title"];} ?>
                                <input type="hidden" name="title" value="<?php if (isset($this->formBean["title"])) echo $this->formBean["title"] ?>">
                              </span></td>
                            </tr>
							<?php if (isset($this->formBean["kind"]) && $this->formBean["kind"]==0 ) {?>
                            <tr>
                              <td width="96%"><span class="red">開始日時：</span><span class="style9">
                              <?php if (isset($this->formBean["start_date"])) {echo $this->formBean["start_date"];} ?>
                              <input type="hidden" name="start_date" value="<?php if (isset($this->formBean["start_date"])) echo $this->formBean["start_date"] ?>">								
                              </span></td>
                            </tr>
                            <tr>
                              <td><span class="red">終了日時：</span><span class="style9">
                              <?php if (isset($this->formBean["end_date"])) {echo $this->formBean["end_date"];} ?>
	                          <input type="hidden" name="end_date" value="<?php if (isset($this->formBean["end_date"])) echo $this->formBean["end_date"] ?>">							  
	                          </span></td>
                            </tr>
                            <tr>
                              <td><span class="style3"><span class="red">詳細：</span>
                              <?php if (isset($this->formBean["detail"])) {echo $this->formBean["detail"];} ?>
						      <input type="hidden" name="detail" value="<?php if (isset($this->formBean["detail"])) echo $this->formBean["detail"] ?>">								
							  </span></td>
                            </tr>
                            <tr>
                              <td><p class="style3"><span class="red">場所：</span>
                                <?php if (isset($this->formBean["place"])) echo $this->formBean["place"] ?>
										<input type="hidden" name="place" value="<?php if (isset($this->formBean["place"])) echo $this->formBean["place"] ?>">
                                    </p> </td>
                            </tr>
						<?php } ?>
                            <tr>
                                <td>
                                    <p class="style3"><span class="red">分類：</span>
                                      <?php if (isset($this->formBean["kindname"])) {echo $this->formBean["kindname"];} ?>
									<input type="hidden" name="kind" value="<?php if (isset($this->formBean["kind"])) echo $this->formBean["kind"] ?>">
                                    </p>                                                                </td>
                            </tr>
                            
                            <tr>
                                <td><span class="red">作成日：</span><span class="style9">
                                <?php if (isset($this->formBean["create_date"])) echo $this->formBean["create_date"] ?>                     
                                <input type="hidden" name="create_date" value="<?php if (isset($this->formBean["create_date"])) echo $this->formBean["create_date"] ?>">								  
                                </span></td>
                            </tr>
                            

                            <tr>
                              <td><a href="<?php echo $this->formBean['down_link'];?>" class="style3" >
	ダウンロード</a></td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
									    <div align="center" class="style5">
										<input type="submit" name="btn_edit" value="  編集  ">
									      <input type="hidden" name="id" value="<?php if (isset($this->formBean["id"])) echo $this->formBean["id"] ?>">
										  <input type="hidden" name="s_id" value="<?php if (isset($this->formBean["s_id"])) echo $this->formBean["s_id"] ?>">                                
							      </div></td>
                            </tr>
                            <tr>
                                <td><div align="center" class="style5">
                                  <input type="submit" name="btn_del" value="  削除  ">
                                </div></td>
                            </tr>
                        </table>
						</form>
                    <div align="center"><br>
                        <span class="style5"><a href="<?php echo $this->formBean["to_mana"]; ?>">
                          ＜＜スケジュール管理に戻る</a><br><br>
                          <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a>                            </span></div></td>
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