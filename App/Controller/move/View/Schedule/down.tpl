<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>iスケジュールダウンロード</title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <link rel="stylesheet" href="../../Stuff/css/style2.css" type="text/css"
        />
        <link rel="stylesheet" href="../../Stuff/css/common.css" type="text/css"
        />
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
            <!-- .style2 {font-size: 12px}
.style3 {font-size: 14px}
-->
        </style>
    </head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
	
        <table width="99%" border="0">
                
                <tr>
                    <td width="1%" height="70">&nbsp;                    </td>
                    <td width="98%">
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                   
                                        <div align="center">★iスケジュールDL★                                                              </div></td>
                            </tr>
                        </table>
						<br>
						<table width="250" border="1" align="center" cellspacing="1"  >
                  <tr class="sty-td1">
                    <td width="80" align="center" class="sty-td1">日付</td>
                    <td width="170" align="center"><span class="w80">タイトル</span><br/>                    </td>
                    </tr>
    <?php 
	$_from = $this->formBean['data']; 
	if (!is_array($_from) && !is_object($_from)) {settype($_from, 'array'); }
	$this->foreachArray['loop'] = array('total' => count($_from), 'iteration' => 0);
    if ($this->foreachArray['loop']['total'] > 0):
    foreach ($_from as $this->formBean['key'] => $this->formBean['value']):
        $this->foreachArray['loop']['iteration']++;
?>
  <tr <?php if ( $this->foreachArray['loop']['iteration']%2==0 ) echo 'class="odd"' ?> >

    <td align="center"><span class="style2"><?php echo $this->formBean['value']['entry_date']; ?></span></td>
    <td align="center"><a href="<?php echo $this->formBean['value']['down_link'];?>" >
	<?php echo $this->formBean['value']['title'];?></a></td>

  </tr>
<?php endforeach; else: ?>
  <tr>
    <td align="center" colspan="7"><span class="style3"> 該当データがありません。</span> </td>
  </tr>
<?php endif; unset($_from); ?>
        </table>
                        <br>
                        
                       <div align="center">
                                            <div class="return">                         </div>
                      </div>                    </td>
                    <td width="1%">&nbsp;                    </td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;                    </td>
                    <td>                    <div align="center"><a href="<?php echo $this->formBean["go_back"]; ?>" accesskey="0" >0:メニューに戻る</a></div></td>
                    <td>&nbsp;                    </td>
                </tr>
            </table>
    </body>

</html>