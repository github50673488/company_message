<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>スケジュール登録確認 </title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
		<script type="text/javascript">
function OneTimeAction(f) {
var e = f.elements['update'];
if (e.value == '登録') {
    e.value = '登録中';
    //e.disabled = true;
    return true;
}
return false;
}
</script>
        <style type="text/css">
            <!-- .style1 {font-weight: bold} .style2 { font-size: 24px; font-weight:
            bold; } -->
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
                    <td>
                        <table width="100%" border="1">
                            <tr>
                                <td>
                                    <div align="center" class="style2">
                                        スケジュール登録確認
                                    </div>
                                </td>
                            </tr>
                        </table>
						<br>
					<form action="" method="post" onSubmit="return OneTimeAction(this);">
                        <table width="98%" border="1">
                            <tr>
                              <td>&nbsp;</td>
                              <td colspan="4"><div align="center"><span class="red"><?php if(isset($this->formBean["err"])) echo $this->formBean["err"] ?></span>
                     </div></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <div align="center" class="style1">                                    </div>                                </td>
                                <td>
                                    <p>
                                        登録内容                                    </p>                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td width="5%">&nbsp;                                </td>
                                <td width="27%">
                                    タイトル                                </td>
                                <td width="30%">
                                   <?php echo $this->formBean["title"] ?> 
								   <input type="hidden" name="title" value="<?php echo $this->formBean["title"] ?>">                           </td>
                                <td width="16%">&nbsp;                                </td>
                                <td width="5%">&nbsp;                                </td>
                                <td width="17%">&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    開始日時                                </td>
                                <td>
                                   <?php echo $this->formBean["start_date"] ?> 
								   <input type="hidden" name="start_date" value="<?php echo $this->formBean["start_date"] ?>">                        </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    終了日時                                </td>
                                <td>
                                    <?php echo $this->formBean["end_date"] ?> 
								   <input type="hidden" name="end_date" value="<?php echo $this->formBean["end_date"] ?>">                   </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    詳細                                </td>
                                <td>
                                    <?php echo $this->formBean["detail"] ?> 
								   <input type="hidden" name="detail" value="<?php echo $this->formBean["detail"] ?>">                          </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <p>
                                        場所                                    </p>                                </td>
                                <td>
                                    <?php echo $this->formBean["place"] ?> 
								   <input type="hidden" name="place" value="<?php echo $this->formBean["place"] ?>">                              </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="3">
                                    で登録します。よろしいですか？                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td height="44">&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <label>
                                        <input type="submit" name="update" value="登録">
										<input type="hidden" name="id" value="<?php echo $this->formBean["id"] ?>">
										<input type="hidden" name="kind" value="<?php echo $this->formBean["kind"] ?>">
                                    </label>                                </td>
                                <td>
                                    <label>                                    </label>                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                    </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                        </table>
					  </form>
						  <br>
						<br>
                        <a href="<?php echo $this->formBean["cancel"]; ?>">
                            ＜＜キャンセル
                        </a>
                        <br>
                        <br>
                        <a href="<?php echo $this->formBean["go_menu"]; ?>">
                            ＜＜管理メニューに戻る
                        </a>
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