<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title><?php if (isset($this->formBean["form_title"])) echo $this->formBean["form_title"] ?></title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
        .style1 {font-size: 12px}
		.style4 {font-size: 18px}
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
            <table width="99%" border="0">
                <tr>
                    <td colspan="3">                                        <div align="center" class="style4">【<?php if (isset($this->formBean["form_title"])) echo $this->formBean["form_title"] ?>】 </div>                    </td>
                </tr>
                <tr>
                    <td width="0%">&nbsp;                    </td>
                  <td width="99%">
						<form action="<?php echo $this->formBean['to_confirm']; ?>" method="post">
                        <table width="100%" border="0">
                            
                            <tr>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td width="99%"><span class="style3">
                                  タイトル
                                  <br>
                                  <input name="title" type="text" value="<?php echo $this->formBean["title"] ?>">
                              </span></td>
                            </tr>
                            <tr>
                                <td><span class="style3">
                                  開始日時
                                  <br>
                                <input name="start_date" type="text" value="<?php echo $this->formBean["start_date"] ?>" size="9" maxlength="8" istyle="4" format="*N" MODE="numeric">
                                <span class="style1">(例: <?php echo $this->formBean['exam_date']; ?>)                                </span></span></td>
                            </tr>
                            <tr>
                              <td><span class="style3">
                                  終了日時
                                  <br>
                              <input name="end_date" type="text" value="<?php echo $this->formBean["end_date"] ?>" size="9" maxlength="8" istyle="4" format="*N" MODE="numeric">
                              <span class="style1">(例: <?php echo $this->formBean['exam_date']; ?>)</span> </span></td>
                            </tr>
                            <tr>
                                <td><span class="style3">
                                  場所
                                  <br>
                                  <input name="place" type="text" value="<?php echo $this->formBean["place"] ?>">                                
                                  </span></td>
                            </tr>
                            <tr>
                                <td><span class="style3">
                                  詳細
                                  <br>
                                  <input name="detail" type="text" value="<?php echo $this->formBean["detail"] ?>">                                
                                  </span></td>
                            </tr>
                            
                            <tr>
                              <td>
                                    <label>
                                        <div align="center">
                                          <input type="submit" name="Submit" value="登録確認">
                                          <input type="hidden" name="kind" value="<?php echo $this->formBean["kind"] ?>">
                                          <input type="hidden" name="id" value="<?php echo $this->formBean["id"] ?>">
                                            </div>
                                    </label>                                <div align="center"></div></td>
                            </tr>
                            
                            <tr>
                              <td><div align="center"><span class="red"><strong><span class="style7"><?php echo $this->formBean["err_msg"] ?></span></strong> </span></div></td>
                            </tr>
                            <tr>
                                <td>                                </td>
                            </tr>
                        </table>
						</form>
						<br>
						<div align="center">
						    <a href="<?php echo $this->formBean["goback"]; ?>">
						      ＜＜戻る					      </a>
			      <br><a href="<?php echo $this->formBean["go_menu"]; ?>" accesskey="0" >0:メニューに戻る</a>				        </div></td>
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