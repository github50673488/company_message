<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title><?php if (isset($this->formBean["form_title"])) echo $this->formBean["form_title"] ?></title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">

.style6 {font-size: 16px}
     
-->
        </style>
    </head>
    
    <body>
	
        <?php include ( '../../View/site.tpl'); ?>
		
            <table width="99%" border="0">
                <tr>
                    <td width="1%">&nbsp;                    </td>
                    <td width="98%">                    <div align="center" class="style3">【<?php if (isset($this->formBean["form_title"])) echo $this->formBean["form_title"] ?>】</div></td>
                    <td width="1%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                  <td><form action="<?php echo $this->formBean['to_confirm']; ?>"  name="form1" method="post">
                        <table width="100%" border="0">
                            
                            <tr>
                              <td>&nbsp;</td>
                              <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td width="1%">&nbsp;                                </td>
                                <td colspan="2">
                                  
   <input name="kind" type="radio" value="1" checked <?php if (isset($this->formBean["kind"]) && $this->formBean["kind"]!=0)  echo 'checked="checked"'; ?>>
                              <span class="style6">iトルカ                                </span>
                                   
                              <input name="kind" type="radio" value="0" <?php if (isset($this->formBean["kind"]) &&  $this->formBean["kind"]==0)  echo 'checked="checked"'; ?> >
                              <span class="style6">通常トルカ                                </span></td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td width="48%">
                                    <p class="style4 red">
                                        タイトル                                    </p>                                </td>
                                <td width="51%">&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="2">
                                    <label>
                                    <input name="title" type="text" class="style2" 
										value="<?php if (isset($this->formBean["title"])) echo $this->formBean["title"] ?>" size="30">
                                    </label>                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <p class="style4 red">
                                        本文                                    </p>                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="2">
                                    <input name="content" type="text" size="50" class="style2"
									value="<?php if (isset($this->formBean["content"])) {echo $this->formBean["content"];} ?>">                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <p class="style4 red">
                                        見出し                                    </p>                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="2">
                                    <input name="subtitle" type="text" size="50" class="style2"
									value="<?php if (isset($this->formBean["subtitle"])) echo $this->formBean["subtitle"] ?>">                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="2">
                                    <label>
                                        <div align="center">
                                          <input type="submit" name="Submit" value="登録確認" onClick="return form_check();">
                                            </div>
                                    </label>
									    <div align="center">
									      <input type="hidden" name="id" value="<?php if (isset($this->formBean["id"])) echo $this->formBean["id"] ?>">                                
							      </div></td>
                            </tr>
                        </table>
						</form>
                        <div align="center">
                            <br>
                            <a href="<?php echo $this->formBean["to_mana"]; ?>">
                              ＜＜戻る
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
	<script type="text/javascript">
	function form_check()
{
	if (document.form1.title.value == ""){
		show_send_err_msg("タイトルを入力してください");
        return(false);
    }
	return true;
}
	
	
	
	function show_send_err_msg(err_msg)
{
   document.getElementById("senderrmsg").style.visibility ="visible";
   document.getElementById("senderrmsg").innerHTML =err_msg;
}
	</script>

</html>