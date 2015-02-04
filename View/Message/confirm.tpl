<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="content-style-type" content="text/css">
    <title>メッセージ配信確認</title>
    <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
    <script defer type="text/javascript" src="../../Stuff/js/pngfix.js"></script>
    <style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
-->
    </style>
	<script type="text/javascript">
function OneTimeAction(f) {
var e = f.elements['upd'];
if (e.value == '配信') {
    e.value = '送信中';
    //e.disabled = true;
    return true;
}
return false;
}
</script>
</head>
<body>
<?php include ('../../View/site.tpl'); ?>
<table width="99%" border="0">
  <tr>
    <td width="15%">&nbsp;</td>
    <td width="70%">&nbsp;</td>
    <td width="15%">&nbsp;</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td>
	 <table width="100%" border="1">
                                        <tr>
                                            <td>
                                                
                                                <div align="center" class="style1">
                                                  <p>【メッセージ配信確認】</p>
                                                </div></td>
                                        </tr>
      </table>
	  <br>   	
	<br>
	<form name ="form1" action="" method="post" onSubmit="return OneTimeAction(this);">
	<table width="98%" border="1">
      
      <tr>
        <td>&nbsp;</td>
        <td colspan="3" align="center"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="5%">&nbsp;</td>
        <td width="19%">タイトル：</td>
        <td width="37%"> <?php if(isset($this->formBean["title"]) )echo $this->formBean["title"]; ?></td>
        <td width="23%">&nbsp;</td>
        <td width="16%">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>配信分類：</td>
        <td><?php if(isset($this->formBean["sendmode_str"]) )echo $this->formBean["sendmode_str"]; ?></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>メール本文：</td>
        <td>「<?php if(isset($this->formBean["free_word"]) )echo $this->formBean["free_word"]; ?>」</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>サイト内容</td>
        <td>「<?php if(isset($this->formBean["detail"]) )echo $this->formBean["detail"]; ?>」</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>添付ファイル：</td>
        <td><?php if(isset($this->formBean["addfile"]) )echo $this->formBean["addfile1"]; ?></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>対象</td>
        <td colspan="3"><?php if(isset($this->formBean["send_userids_name"]) )echo $this->formBean["send_userids_name"]; ?></td>
        </tr>
	<?php if($this->formBean["is_GPS"]) {?>	
	<tr>
        <td>&nbsp;</td>
        <td>配信地点：</td>
        <td>緯度<?php if(isset($this->formBean["send_userids_name"]) )echo $this->formBean["longitude"]; ?>、
		経度<?php if(isset($this->formBean["send_userids_name"]) )echo $this->formBean["latitude"]; ?>
		</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
	  	<?php } ?>	
      <tr>
        <td>&nbsp;</td>
        <td>          </td>
        <td><p>ユーザID</p></td>
        <td><p>メールアドレス</p></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><label>
          <input type="submit" name="testsend" value="テスト配信">
        </label></td>
        <td><label>
          <input type="text" name="testuserid">
        </label></td>
        <td><input type="text" name="testmailaddr"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="65">&nbsp;</td>
        <td><input type="submit" name="upd" value="配信">
			<input type="hidden" name="title" value = "<?php if(isset($this->formBean["title"]) )echo $this->formBean["title"]; ?>">
			<input type="hidden" name="free_word" value = "<?php if(isset($this->formBean["free_word"]) )echo $this->formBean["free_word"]; ?>">
			<input type="hidden" name="detail" value = '<?php if(isset($this->formBean['detail'])) echo $this->formBean['detail']; ?>'>
	<INPUT type="hidden" name="addfile" value="<?php echo $this->formBean["addfile"]; ?>">
	<INPUT type="hidden" name="longitude" value="<?php echo $this->formBean["longitude"]; ?>">
	<INPUT type="hidden" name="latitude" value="<?php echo $this->formBean["latitude"]; ?>">
	<INPUT type="hidden" name="radius" value="<?php echo $this->formBean["radius"]; ?>">
	<INPUT type="hidden" name="sdate" value="<?php echo $this->formBean["sdate"]; ?>">
	<INPUT type="hidden" name="edate" value="<?php echo $this->formBean["edate"]; ?>">
	<INPUT type="hidden" name="stime" value="<?php echo $this->formBean["stime"]; ?>">
	<INPUT type="hidden" name="etime" value="<?php echo $this->formBean["etime"]; ?>">
	<INPUT type="hidden" name="sendmode" value="<?php echo $this->formBean["sendmode"]; ?>">
		<?php if(isset($this->formBean["send_userids"])){
             foreach($this->formBean["send_userids"] as $userid){
                 echo ("<input type='hidden' name='send_userids[]' value = '".$userid."'>");
             }
         }
       ?>
	   <?php if(isset($this->formBean["user_sendways"])){
             foreach($this->formBean["user_sendways"] as $sendways){
                 echo ("<input type='hidden' name='user_sendways[]' value = '".$sendways."'>");
             }
         }
       ?>
	   
	   	   	    </td>
        <td><input type="button" name="cancel" onclick='window.close()' value="キャンセル"></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
	</form>
      <p>&nbsp;</p>
    <p></p></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

</body>
</html>