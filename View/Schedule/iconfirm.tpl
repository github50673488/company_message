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
if (e.value == '登録') {
    e.value = '登録中';
    //e.disabled = true;
    return true;
}
return false;
}
</script>
        <style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {
	font-size: 24px;
	font-weight: bold;
}
-->
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
                                    
                                        <div align="center" class="style2">iスケジュール登録確認                                </div></td>
                            </tr>
                        </table>
						
						<form action="" method="post" onSubmit="return OneTimeAction(this);">
                        <table width="98%" border="1">
                            <tr>
                                <td>
                                    <div align="center" class="style1">                                    </div>                                </td>
                                <td colspan="2">
                                    <p><strong>
                                      登録内容                                    </strong></p>                                                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td width="5%">&nbsp;                                </td>
                                <td colspan="2">
                                    タイトル 「 <?php  echo $this->formBean["iSchedule_title"] ; ?> 」 &nbsp;　　　　　　　　　　　　　　　　</td>
                                <td width="16%">&nbsp;                                </td>
                                <td width="5%">&nbsp;                                </td>
                                <td width="17%">&nbsp;                                </td>
                            </tr>
							
							 <?php 
	$_from = $this->formBean['data']; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
        $this->foreachArray['loop']['iteration']++;
    ?>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="2"><?php echo $this->formBean['value']['title']; ?>                                    </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                 <?php endforeach; unset($_from); ?>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td colspan="3">
                                    で登録します。よろしいですか？                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td height="26">&nbsp;                                </td>
                                <td colspan="3"><div align="center"><span class="red"><?php if(isset($this->formBean["err"])) echo $this->formBean["err"] ?></span>
                     </div>                                                                                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td width="27%">
                                    <label>
                                        <input type="submit" name="update" value="登録">
							<input type="hidden" name="i_password" value="<?php echo $this->formBean['i_password']; ?>"/>
                                    </label>                                </td>
                                <td width="30%">
                                    <label>                                    </label>                                </td>
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
                           キャンセル
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