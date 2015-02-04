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
                                    <div align="center">
                                        <p class="style1">
                                            【<?php echo $this->formBean["form_title"] ?>】
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <br>
						<form action="<?php echo $this->formBean['to_confirm']; ?>" method="post">
                        <table width="100%" border="1">
                            <tr>
                                <td width="7%" height="24">&nbsp;                                </td>
                                <td width="85%" align="center">  <span class="red"><strong><?php echo $this->formBean["err_msg"] ?></strong> </span></td>
                                <td width="8%">&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    タイトル
                                    <br>
                                    <input name="title" type="text" value="<?php echo $this->formBean["title"] ?>">                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    開始日時
                                    <br>
              <input name="start_date" type="text" value="<?php echo $this->formBean["start_date"] ?>" size="10" maxlength="8">
              (例:<?=$this->formBean["exampledate"]?>)                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                              <td>
                                    終了日時
                                    <br>
                  <input name="end_date" type="text" value="<?php echo $this->formBean["end_date"] ?>" size="10" maxlength="8">
(例:<?=$this->formBean["exampledate"]?>) </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    場所
                                    <br>
                                    <input name="place" type="text" value="<?php echo $this->formBean["place"] ?>">                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    詳細
                                    <br>
                                    <input name="detail" type="text" value="<?php echo $this->formBean["detail"] ?>">                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>
                                    <label>
                                        <input type="submit" name="Submit" value="登録確認">
										<input type="hidden" name="kind" value="<?php echo $this->formBean["kind"] ?>">
                                        <input type="hidden" name="id" value="<?php echo $this->formBean["id"] ?>">
                                    </label>                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                            
                            <tr>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                                <td>&nbsp;                                </td>
                            </tr>
                        </table>
						</form>
						<br>
						<br>
                        <a href="<?php echo $this->formBean["goback"]; ?>">
                            ＜＜戻る
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