<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>iスケジュール登録確認 </title>
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
<!--

.style9 {font-size: 17px}
-->
        </style>
</head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td colspan="3">                                        <div align="center" class="style9" >【iスケジュール登録確認】</div>                    </td>
                </tr>
                <tr>
                    <td width="1%">&nbsp;                    </td>
                    <td width="98%"><form action="" method="post" onSubmit="return OneTimeAction(this);">
                        <table width="100%" border="0">
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <p class="style4">
                                      登録内容                                    </p>                                                                </td>
                            </tr>
                            <tr>
                                <td><span class="style6">
                                  ●タイトル「<?php  echo $this->formBean["iSchedule_title"] ; ?>」</span></td>
                            </tr>
							
							 <?php 
	$_from = $this->formBean['data']; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
        $this->foreachArray['loop']['iteration']++;
    ?>
                            <tr>
                                <td><span class="style6">●<?php echo $this->formBean['value']['title']; ?>                                    </span></td>
                            </tr>
                 <?php endforeach; unset($_from); ?>
                            <tr>
                                <td><span class="style6">
                                  で登録します。よろしいですか？                                </span></td>
                            </tr>
                            <tr>
                                <td height="26"><div align="center" class="style6"><span class="red">
                                  <input type="submit" name="update" value="  登録  ">
                                      <input type="hidden" name="i_password" value="<?php echo $this->formBean['i_password']; ?>"/>
								</span>
                     </div>                                                                                                </td>
                            </tr>
                            <tr>
                                <td height="33">
                                        <span class="style6">
                                        <label>                                        </label>
                                  </span>
                                        <span class="style6">
                                        <label></label>
                                        </span>
                                    <label><div align="center" class="style7">
                                      
                                        <?php if(isset($this->formBean["err"])) echo $this->formBean["err"] ?></div>
                                    </label>                                
                                        <span class="style6">
                                        <label>                                    </label>
                              </span></td>
                            </tr>
                        </table>
						</form>
					  <div align="center">
					     <span class="style8"><a href="<?php echo $this->formBean["cancel"]; ?>">
					       キャンセル
					       </a>
					     <br>
					    
			        <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a>			             </span></div></td>
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