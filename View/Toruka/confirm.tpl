<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>トルカ登録確認画面</title>
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
            <!-- .style1 {font-size: 24px} -->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td width="20%">&nbsp;
                        
                    </td>
                    <td width="60%">
                        
                      <div align="center"><span class="red"><?php if(isset($this->formBean["err"])) echo $this->formBean["err"] ?></span>
                     </div></td>
                    <td width="20%">&nbsp;
                        
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                    <td>
                        <table width="389" align="center" cellspacing="0">
                            <tr>
                                <td width="30%" align="center">
                                    <p class="style1">
                                        【トルカ登録確認画面】
                                    </p>
                                </td>
                            </tr>
                        </table>
                        <form action="" method="post" onSubmit="return OneTimeAction(this);">
                            <table width="98%" border="1">
                                <tr>
                                    <td width="3%">&nbsp;                                    </td>
                                    <td colspan="5">
                                        <p>
                                            登録内容                                        </p>                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td width="25%">
                                        トルカ分類                                    </td>
                                    <td width="29%">
                                        <?php echo $this->formBean["kind_name"] ?> 
										<input type="hidden" name="kind" value="<?php echo $this->formBean["kind"] ?>">
										                                   </td>
                                    <td width="27%">&nbsp;                                    </td>
                                    <td width="2%">&nbsp;                                    </td>
                                    <td width="14%">&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td>
                                        タイトル                                    </td>
                                    <td>
                                         <?php echo $this->formBean["title"] ?> 
										 <input type="hidden" name="title" value="<?php echo $this->formBean["title"] ?>">                                   </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td>
                                        本文                                    </td>
                                    <td>
                                         <?php echo $this->formBean["content"] ?> 
										 <input type="hidden" name="content" value="<?php echo $this->formBean["content"] ?>">                                   </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td>
                                        見出し                                    </td>
                                    <td>
                                        <?php echo $this->formBean["subtitle"] ?> 
										<input type="hidden" name="subtitle" value="<?php echo $this->formBean["subtitle"] ?>">                                   </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td colspan="4">
                                        <p>
                                            で登録します。よろしいですか？                                        </p>                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td colspan="4">
                                        <p>
                                            ※iトルカを編集している場合は、更新を実施します                                        </p>                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                
                                
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                  </td>
                                    <td>
                                        <input type="submit" name="update" value="登録">
										<input type="hidden" name="id" value="<?php echo $this->formBean["id"] ?>">                                    </td>
                                    <td>&nbsp;                                  </td>
                                    <td>&nbsp;                                  </td>
                                    <td>&nbsp;                                  </td>
                                    <td>&nbsp;                                  </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                        </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                    <td>&nbsp;                                    </td>
                                </tr>
                            </table>
                        </form>
                        <br>
                        <a href="<?php echo $this->formBean["cancel"]; ?>">
                            ＜＜キャンセル
                        </a>
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