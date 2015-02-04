<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title><?php echo $this->formBean["form_title"] ?></title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
            <!-- .style1 {font-size: 24px} -->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td width="16%">&nbsp;
                        
                    </td>
                    <td width="68%">&nbsp;
                        
                    </td>
                    <td width="16%">&nbsp;
                        
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                        
                    </td>
                    <td>
                        <table width="100%" border="1">
                            <tr>
                                <td>
                                    <div align="center" class="no_bg style1">
                                        <?php echo $this->formBean["form_title"] ?>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <table width="100%" border="1">
                            <tr>
                                <td width="4%">&nbsp;                                </td>
                                <td width="91%">                                </td>
                                <td width="5%">&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <div align="center">iスケジュール名
                                      <br>
									  <form name ="titleform" action="" method="post">
                                          <input name="ititle" type="text" value="<?php echo $this->formBean['title']; ?>" 
										  size="50" maxlength="50">
										  <input type="hidden" name="schedule_add" value=""/>
										  <input type="hidden" name="go_iconfirm" value=""/>
										   <br>
										  	<div align="center">編集用パスワード：<br> 
             <input name="i_password" type="text" value="<?php echo $this->formBean['i_password']; ?>" size="10" maxlength="10">
                              </div>
										  <br>
										  <div  class="red" ><strong>
            <label id="senderrmsg" style="visibility:hidden">             </label>
			 </strong></div>		
									  </form>
                                  </div>
								  </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td align="center">スケジュールリスト </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td><br>
									
                                    <div align="center">
                                        <table width="534" border="1" align="center" cellspacing="1">
                                            <tr class="sty-td1">
                                                <td width="189" align="center" class="sty-td1">
                                                    日付                                                </td>
                                                <td width="161" align="center">
                                                    タイトル                                                </td>
                                                <td width="83" align="center">&nbsp;                                                </td>
                                                <td width="88" align="center">&nbsp;                                                </td>
                                            </tr>
                                            <?php 
											$_from=$this->formBean['data']; 
												if (!is_array($_from) && !is_object($_from)) {settype($_from,'array'); } 
												$this->foreachArray['loop'] = array('total' => count($_from),'iteration' => 0); 
												if ($this->foreachArray['loop']['total'] > 0): 
												foreach($_from as $this->formBean['key'] => $this->formBean['value']): 
												$this->foreachArray['loop']['iteration']++;
                                              ?>
                                                <tr 
												<?php if ( $this->foreachArray['loop']['iteration']%2==0 ) echo 'class="odd"' ?> >
                                                    <form action="" method="post">
                                                        <td align="center">
                                                            <?php echo $this->formBean['value']['create_date']; ?>
															 <input type="hidden" name="title" 
															 value="<?php echo $this->formBean['value']['title']; ?>"/>														</td>
                                                        <td align="center">
                                                            <?php echo $this->formBean['value']['title'];?>
															<input type="hidden" name="title" 
														value="<?php echo $this->formBean['value']['title']; ?>"/>														</td>
                                                        <td align="center"><input name="schedule_edit" type="submit" value="編集" />
                                                          <input type="hidden" name="start_date" 
															value="<?php echo $this->formBean['value']['start_date']; ?>" />
	                                                        <input type="hidden" name="end_date" 
															value="<?php echo $this->formBean['value']['end_date']; ?>" />
	                                                        <input type="hidden" name="place" 
															value="<?php echo $this->formBean['value']['place']; ?>" />
	                                                        <input type="hidden" name="detail" 
															value="<?php echo $this->formBean['value']['detail']; ?>" />
	                                                        <input type="hidden" name="kind" 
															value="<?php echo $this->formBean['value']['kind']; ?>" />													  </td>
                                                        <td align="center">
                                                            <input name="schedule_del" type="submit" value="削除" />
															<input type="hidden" name="list_id" 
														value="<?php echo $this->foreachArray['loop']['iteration']-1; ?>"/>		
														</td>
                                                    </form>
                                                </tr>
                                                <?php endforeach; else: ?>
                                                    <tr>
                                                        <td align="center" colspan="9">
                                                            該当データがありません。                                                        </td>
                                                    </tr>
                                                    <?php endif; unset($_from); ?>
                                        </table>
                                    </div>
                                 
                                   
                                        
                                        <br />
                                        <br>                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    
                                       
										<div align="center">
                                            <input type="submit" name="btn_schedule_add" value="スケジュール追加"
											onClick="
											document.titleform.action='<?php echo $this->formBean["schedule_add"];?>';
											document.titleform.submit();
											return false;
											"
											>
                                        </div>
										
										
                                   						    </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                        </table>
						 <br>
						 <br>
						 <a href="" onClick=" if (form_check()){
						 document.titleform.action='<?php echo $this->formBean["go_iconfirm"]; ?>';
						 document.titleform.submit();}
						 return false;">登録確認
</a>                            
						 <br>
						 <br>
						<a href="<?php echo $this->formBean["goback"]; ?>">
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
	if (document.titleform.ititle.value == ""){
		show_send_err_msg("タイトルを入力してください");
        return(false);
    }
	if (checknumber(document.getElementById("i_password").value)){
	    document.getElementById("i_password").focus();
		show_send_err_msg("パスワードを数字で入力してください");
        return(false);
    }
	return true;
}
	function show_send_err_msg(err_msg)
{
   document.getElementById("senderrmsg").style.visibility ="visible";
   document.getElementById("senderrmsg").innerHTML =err_msg;
}

function checknumber(str)
{
  if (str.length==0) {return false;}
  var Letters = "1234567890";
  var i;
  var c;
  for( i = 0; i < str.length; i ++ )
  {
   c = str.charAt(i);
   if (Letters.indexOf( c ) ==-1){ return true;}
  }
   return false;
}
	</script>

</html>