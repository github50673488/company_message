<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>スケジュール登録確認</title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
		<script type="text/javascript">
function OneTimeAction(f) {
var e = f.elements['update'];
if (e.value == '  登録  ') {
    e.value = '登録中';
    //e.disabled = true;
    return true;
}
return false;
}
</script>
        <style type="text/css">
            <!-- .style3 {font-size: 18px}
			.style5 {font-size: 16px}

-->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td colspan="3">                                        <div align="center" class="style3">【スケジュール登録確認】 </div>                    </td>
                </tr>
                <tr>
                    <td width="1%">&nbsp;                    </td>
                    <td width="98%">
					<form action="" method="post" onSubmit="return OneTimeAction(this);">
                        <table width="98%" border="0">
                            <tr>
                              <td></td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="style7">
                                        登録内容                                    </p>                                                                </td>
                            </tr>
                            <tr>
                                <td height="23"><span class="style7">
                                  ●タイトル:                                </span>
                                   <span class="style7"><?php echo $this->formBean["title"] ?> 
								   <input type="hidden" name="title" value="<?php echo $this->formBean["title"] ?>">                           
							      </span></td>
                            </tr>
                            <tr>
                                <td><span class="style7">
                                  ●開始日時:</span><span class="style5"><?php echo $this->formBean["start_date"] ?> 
							      <input type="hidden" name="start_date" value="<?php echo $this->formBean["start_date"] ?>">                        
							      </span></td>
                            </tr>
                            <tr>
                                <td><span class="style7">
                                  ●終了日時:</span><span class="style5"><?php echo $this->formBean["end_date"] ?> 
								    <input type="hidden" name="end_date" value="<?php echo $this->formBean["end_date"] ?>">                   
						           </span></td>
                            </tr>
                            <tr>
                                <td><span class="style7">
                                  ●詳細:                                </span>
                                    <span class="style7"><?php echo $this->formBean["detail"] ?> 
								    <input type="hidden" name="detail" value="<?php echo $this->formBean["detail"] ?>">                          
						           </span></td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="style7">
                              ●場所:                    
                                    <span class="style7"><?php echo $this->formBean["place"] ?> 
								    <input type="hidden" name="place" value="<?php echo $this->formBean["place"] ?>">                              
					           </span></td>
                            </tr>
                            <tr>
                                <td><span class="style7">
                                  で登録します。よろしいですか？                                </span></td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        <div align="center" >
                                          <input type="submit" name="update" value="  登録  ">
                                          <input type="hidden" name="id" value="<?php echo $this->formBean["id"] ?>">
                                          <input type="hidden" name="kind" value="<?php echo $this->formBean["kind"] ?>">
                                  </div>
                                    </label>                                
                                    <label>                                    </label></td>
                            </tr>
                            <tr>
                                <td>                                                                                                                                    <div align="center">
                                  <div align="center"><span class="red"><span class="style6"><?php if(isset($this->formBean["err"])) echo $this->formBean["err"] ?></span>
                                  </span>                     </div>
                                </div></td>
                            </tr>
                        </table>
					  </form>
						<br>
                        <div align="center"><a href="<?php echo $this->formBean["cancel"]; ?>">
                          ＜＜キャンセル
                          </a>
                          <br>
                            <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a> </div></td>
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