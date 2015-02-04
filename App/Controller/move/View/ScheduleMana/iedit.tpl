<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title><?php echo $this->formBean['form_title'];?></title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
        .style1 {font-size: 12px}
		.style2 {font-size: 12px}
		.style4 {font-size: 8px}
        .style3 {font-size: 19px}
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td width="1%">&nbsp;                    </td>
                  <td width="98%">                    <div align="center"><span class="style3">【<?php echo $this->formBean['form_title'];?>】</span></div></td>
                    <td width="1%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td>&nbsp;                    </td>
                    <td>
                        <table width="100%" border="0">
                            
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td width="94%">
                                    <div align="center" class="style11">iスケジュール名
                                      <br>
									  <form name ="titleform" action="" method="post">
                                          <input name="ititle" type="text" value="<?php echo $this->formBean['title']; ?>" 
										  size="50" maxlength="50">
										  <input type="hidden" name="schedule_add" value=""/>
										  <input type="hidden" name="go_iconfirm" value=""/>
										  <br>
										  	<div align="center">編集用パスワード：
										  	  <input name="i_password" type="text" value="<?php echo $this->formBean['i_password']; ?>" size="6" maxlength="4" istyle="4" format="*N" MODE="numeric">
</div>
										  <br>
										  <div  class="red" ><strong>
            <label id="senderrmsg" style="visibility:hidden">             </label>
			 </strong></div>	
									  </form>
                                  </div>								  </td>
                            </tr>
                            <tr>
                              <td align="center"><span class="style3">スケジュールリスト </span></td>
                            </tr>
                            <tr>
                                <td>
                                    <div align="center">
                                        <table width="99%" border="1" align="center" cellspacing="1">
                                            <tr class="sty-td1">
                                                <td width="30%" align="center" class="sty-td1 style2">
                                                    日付                                                </td>
                                                <td width="50%" align="center"><span class="style2">
                                                  タイトル                                                </span></td>
                                                <td width="10%" align="center">&nbsp; </td>
                                                <td width="10%" align="center">&nbsp; </td>
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
                                                            <span class="style2">
															 <span class="style4"><?php echo $this->formBean['value']['create_date']; ?></span>
														    <input type="hidden" name="title" 
															 value="<?php echo $this->formBean['value']['title']; ?>"/>														
														  </span></td>
                                                        <td align="center">
                                                            <span class="style2"><?php echo $this->formBean['value']['title'];?>
															<input type="hidden" name="title" 
														value="<?php echo $this->formBean['value']['title']; ?>"/>														
															</span></td>
                                                        <td align="center"><span class="style4">
                                                        <input name="schedule_edit" type="submit" value="編集" />
                                                        <input type="hidden" name="start_date" 
															value="<?php echo $this->formBean['value']['start_date']; ?>" />
                                                          <input type="hidden" name="end_date" 
															value="<?php echo $this->formBean['value']['end_date']; ?>" />
                                                          <input type="hidden" name="place" 
															value="<?php echo $this->formBean['value']['place']; ?>" />
                                                          <input type="hidden" name="detail" 
															value="<?php echo $this->formBean['value']['detail']; ?>" />
                                                          <input type="hidden" name="kind" 
															value="<?php echo $this->formBean['value']['kind']; ?>" />													  
                                                          </span></td>
                                                        <td align="center">
                                                            <span class="style4">
															<input name="schedule_del" type="submit" value="削除" />
															<input type="hidden" name="list_id" 
														value="<?php echo $this->foreachArray['loop']['iteration']-1; ?>"/>														
															</span></td>
                                                    </form>
                                                </tr>
                                                <?php endforeach; else: ?>
                                                    <tr>
                                                        <td align="center" colspan="9">
                                                            <span class="style7 style1">該当データがありません。</span> </td>
                                                    </tr>
                                                    <?php endif; unset($_from); ?>
                                        </table>
                                    </div>
                                        <br>                                </td>
                            </tr>
                            <tr>
                                <td>
                                    
                                       
										<div align="center">
                                            <input type="submit" name="btn_schedule_add" value="スケジュール追加" class="style6"
											onClick="
											document.titleform.action='<?php echo $this->formBean["schedule_add"];?>';
											document.titleform.submit();
											return false;
											"
											>
                                        </div>                                   						    </td>
                            </tr>
                        </table>
						 <div align="center">
						     <br>
						     <span class="style6"><a href="" onClick="if (form_check()){
						 document.titleform.action='<?php echo $this->formBean["go_iconfirm"]; ?>';
						 document.titleform.submit();}
						 return false;">登録確認
					         </a>                            
						     <br>
						    
						      <a href="<?php echo $this->formBean["goback"]; ?>">
					          ＜＜戻る				              </a>
						      <br>
						     
						     <a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a>		                  </span></div></td>
                    <td>&nbsp;                    </td>
                </tr>
                <tr>
                    <td>&nbsp;                    </td>
                    <td>&nbsp;                    </td>
                    <td>&nbsp;                    </td>
                </tr>
            </table>
    </body>
	<script type="text/javascript">
	function form_check()
{
	if (document.titleform.ititle.value == ""){
    	document.titleform.ititle.focus();
		show_send_err_msg("タイトルを入力してください");
        return(false);
    }
	//var pass=document.titleform.i_password.value;
	//if (pass!="" && !isNumber(pass)){
	  //  document.titleform.i_password.focus();
	//	show_send_err_msg("パスワードを数字で入力してください");
    //    return(false);
    //}
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

function isNumber(str)
         {
             if(""==str)
             {
                 return false;
             }
            
             var reg = /\D/;
             return str.match(reg)==null;
         }

	</script>

</html>