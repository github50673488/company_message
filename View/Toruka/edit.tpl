<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title><?php echo $this->formBean["form_title"] ?></title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
            <!-- .style1 { font-size: 24px; font-weight: bold; } -->
        </style>
    </head>
    
    <body>
	
        <?php include ( '../../View/site.tpl'); ?>
		
            <table width="99%" border="0">
                <tr>
                    <td width="14%">&nbsp;
                        
                    </td>
                    <td width="78%">&nbsp;
                        
                    </td>
                    <td width="8%">&nbsp;
                        
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
                                        【<?php echo $this->formBean["form_title"] ?>】
                                    </p>
                                </td>
                            </tr>
                        </table>
						<form action="<?php echo $this->formBean['to_confirm']; ?>" method="post" name="form1">
                        <table width="100%" border="1">
                            <tr>
                                <td width="3%">&nbsp;
                                    
                                </td>
                                <td width="9%">&nbsp;
                                    
                                </td>
                                <td width="86%">&nbsp;
                                    
                                </td>
                                <td width="2%">&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>
                                    <p>
                                        トルカ分類
                                    </p>
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>
                                  
   <input name="kind" type="radio" value="1" checked <?php if (isset($this->formBean["kind"]) && $this->formBean["kind"]!=0)  echo 'checked="checked"'; ?>>
                                        iトルカ
                                  
                                </td>
                                <td>
                                   
<input name="kind" type="radio" value="0" <?php if (isset($this->formBean["kind"]) &&  $this->formBean["kind"]==0)  echo 'checked="checked"'; ?> >
                                        通常トルカ
                                   
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>
                                    <p>
                                        タイトル
                                    </p>
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td colspan="2">
                                    <label>
                                        <input name="title" type="text" size="120" 
										value="<?php if (isset($this->formBean["title"])) echo $this->formBean["title"] ?>">
                                    </label>
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>
                                    <p>
                                        本文
                                    </p>
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td colspan="2">
                                    <input name="content" type="text" size="120"
									value="<?php if (isset($this->formBean["content"])) {echo $this->formBean["content"];} ?>">
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td>
                                    <p>
                                        見出し
                                    </p>
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td colspan="2">
                                    <input name="subtitle" type="text" size="120"
									value="<?php if (isset($this->formBean["subtitle"])) echo $this->formBean["subtitle"] ?>">
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td colspan="2">
                                    <label>
                                        <input type="submit" name="Submit" value="登録確認" onClick="return form_check();">
                                    </label>
									    <input type="hidden" name="id" value="<?php if (isset($this->formBean["id"])) echo $this->formBean["id"] ?>">
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;
                                    
                                </td>
                                <td colspan="2"><div  class="red" ><strong>
            <label id="senderrmsg" style="visibility:hidden">             </label>
			 </strong></div>
                                    
                                </td>
                                <td>&nbsp;
                                    
                                </td>
                            </tr>
                        </table>
						</form>
                        <br>
                        <br>
                        <a href="<?php echo $this->formBean["to_mana"]; ?>">
                            ＜＜戻る
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
	<script type="text/javascript">
	function form_check()
{
	if (document.form1.title.value == ""){
		show_send_err_msg("タイトルを入力してください");
        return(false);
    }
}
	
	
	
	function show_send_err_msg(err_msg)
{
   document.getElementById("senderrmsg").style.visibility ="visible";
   document.getElementById("senderrmsg").innerHTML =err_msg;
}
	</script>

</html>