

<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="content-style-type" content="text/css">
        <title>
            管理メニュー
        </title>
        <link rel="stylesheet" href="../../Stuff/css/style.css" type="text/css">
        <script defer type="text/javascript" src="../../Stuff/js/pngfix.js">
        </script>
        <style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
.style2 {font-size: 24px}
-->
        </style>
</head>
    
    <body>
        <?php include ( '../../View/site.tpl'); ?>
		<form name = "form1" action="" method="post" onSubmit="return form_check()">
            <table width="99%" border="0">
                <tr>
                  <td>&nbsp;</td>
                  <td colspan="2"><div align="center" class="style1 style2" >【パラメータ設定】</div>   </td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                    <td width="3%">&nbsp;                    </td>
                  <td colspan="2">                 </td>
                    <td width="3%">&nbsp;                    </td>
                </tr>
                <tr>
                    <td height="235">&nbsp;                    </td>
                  <td colspan="2" align="center"><table width="100%" border="1">
                    <tr>
                      <td width="50%" height="85" valign="top"><table width="99%" border="1">
                        <tr class="sty-td1">
                          <td colspan="2"><div align="center"><strong>マイボックス設定</strong></div></td>
                        </tr>
                        <tr>
                          <td width="40%"><div align="right">マイボックスサービス番号 </div></td>
                          <td width="60%">
                            <input name="mybox_no" type="text" size="12" maxlength="12" 
							value="<?php if (isset($this->formBean['mybox_no']) ) echo $this->formBean['mybox_no']; ?>">                          </td>
                        </tr>
                        <tr>
                          <td><div align="right">Basic認証ID</div></td>
                          <td><input name="basic_auth_id" type="text" size="15" maxlength="15" 
						  value="<?php if (isset($this->formBean['basic_auth_id']) ) echo $this->formBean['basic_auth_id']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">Basic認証パスワード</div></td>
                          <td><input name="basic_auth_pswd" type="text" size="11" maxlength="11" value="<?php if (isset($this->formBean['basic_auth_pswd']) ) echo $this->formBean['basic_auth_pswd']; ?>" ></td>
                        </tr>
                        <tr>
                          <td><div align="right">SSL証明書ファイル</div></td>
                          <td><input name="local_cert" type="text" size="40" maxlength="1000" value="<?php if (isset($this->formBean['local_cert']) ) echo $this->formBean['local_cert']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">SSLエンコード パスフレーズ</div></td>
                          <td><input name="passphrase" type="text" size="5" maxlength="5" value="<?php if (isset($this->formBean['passphrase']) ) echo $this->formBean['passphrase']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">SSL証明書ファイルパス </div></td>
                          <td><input name="capath" type="text" size="40" maxlength="1000" value="<?php if (isset($this->formBean['capath']) ) echo $this->formBean['capath']; ?>"></td>
                        </tr>
                      </table></td>
                      <td width="50%" valign="top"><table width="100%" border="1">
                        <tr class="sty-td1">
                          <td colspan="2"><div align="center"><strong>ドコモ携帯送信設定</strong></div></td>
                        </tr>
                        <tr>
                          <td width="43%"><div align="right">ｉコンシェル認証ID</div></td>
                          <td width="57%"><input name="iconcier_login_id" type="text" size="6" maxlength="6" value="<?php if (isset($this->formBean['iconcier_login_id']) ) echo $this->formBean['iconcier_login_id']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">ｉコンシェル認証パスワード</div></td>
                          <td><input name="iconcier_login_password" type="text" size="20" maxlength="20" value="<?php if (isset($this->formBean['iconcier_login_password']) ) echo $this->formBean['iconcier_login_password']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">ｉコンシェルポップアップメッセージ</div></td>
                          <td><input name="popup_msg" type="text" size="40" maxlength="40" value="<?php if (isset($this->formBean['popup_msg']) ) echo $this->formBean['popup_msg']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">メッセージＲ送信パスワード</div></td>
                          <td><input name="msg_r_password" type="text" size="40" maxlength="40" value="<?php if (isset($this->formBean['msg_r_password']) ) echo $this->formBean['msg_r_password']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">メッセージＲ送信元アドレス</div></td>
                          <td><input name="msg_r_email_from" type="text" size="40" maxlength="40" value="<?php if (isset($this->formBean['msg_r_email_from']) ) echo $this->formBean['msg_r_email_from']; ?>"></td>
                        </tr>
                        
                      </table></td>
                    </tr>
                    <tr>
                      <td valign="top"><table width="99%" border="1">
                        <tr class="sty-td1">
                          <td colspan="2"><div align="center"><strong>メール送信設定</strong></div></td>
                        </tr>
                        <tr>
                          <td width="40%"><div align="right">メール送信元メールアドレス</div></td>
                          <td width="60%"><input name="email_from" type="text" size="40" maxlength="40" value="<?php if (isset($this->formBean['email_from']) ) echo $this->formBean['email_from']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">ｓｍｔｐホスト </div></td>
                          <td><input name="smtp_host" type="text" size="15" maxlength="15" value="<?php if (isset($this->formBean['smtp_host']) ) echo $this->formBean['smtp_host']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">ｓｍｔｐポート番号 </div></td>
                          <td><input name="smtp_port" type="text" size="3" maxlength="3" value="<?php if (isset($this->formBean['smtp_port']) ) echo $this->formBean['smtp_port']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">メール差し出し人名</div></td>
                          <td><input name="email_send_name" type="text" size="40" maxlength="40" value="<?php if (isset($this->formBean['email_send_name']) ) echo $this->formBean['email_send_name']; ?>"></td>
                        </tr>
                      </table></td>
                      <td valign="top"><table width="100%" border="1">
                        <tr class="sty-td1">
                          <td colspan="2"><div align="center"><strong>他の設定</strong></div></td>
                        </tr>
                        <tr>
                          <td width="43%"><div align="right">ページに付きデータ数</div></td>
                          <td width="57%"><input name="LINE_PER_PAGE" type="text" size="3" maxlength="3" value="<?php if (isset($this->formBean['LINE_PER_PAGE']) ) echo $this->formBean['LINE_PER_PAGE']; ?>"></td>
                        </tr>
                        <tr>
                          <td><div align="right">googleマップサイト</div></td>
                          <td><input name="map_url" type="text" size="40" maxlength="1000" value="<?php if (isset($this->formBean['map_url']) ) echo $this->formBean['map_url']; ?>"></td>
                        </tr>
                      </table></td>
                    </tr>
                    
                  </table>                  </td>
                    <td>&nbsp;                    </td>
                </tr>
                <tr>
                  <td height="15">&nbsp;</td>
                  <td width="47%"><div align="right">
                    <label>
                    <input type="submit" name="btn_update" value="          変更          " >
                    </label>
                  </div></td>
                  <td width="47%"><div align="left">
                    <input type="button" name="btn_cancel" value="       キャンセル       " 
		onClick="parent.location = '<?php if (isset($this->formBean['go_back']) ) echo $this->formBean['go_back']; ?>'">
                  </div></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="15">&nbsp;                    </td>
                    <td colspan="2"><a href="<?php echo $this->formBean["go_menu"]; ?>">＜＜管理メニューに戻る</a>                 </td>
                    <td>&nbsp;                    </td>
                </tr>
            </table>
	</form>
    </body>
<script type="text/javascript">
function form_check()
{
	if (document.form1.mybox_no.value == ""){
        alert("マイボックスサービス番号を入力してください。");
		document.form1.mybox_no.focus()
        return(false);
    }
	if (document.form1.basic_auth_id.value == ""){
        alert("Basic認証IDを入力してください。");
		document.form1.basic_auth_id.focus()
        return(false);
    }
	if (document.form1.basic_auth_pswd.value == ""){
        alert("Basic認証パスワードを入力してください。");
		document.form1.basic_auth_pswd.focus()
        return(false);
    }
	if (document.form1.local_cert.value == ""){
        alert("SSL証明書ファイルを入力してください。");
		document.form1.local_cert.focus()
        return(false);
    }
	if (document.form1.passphrase.value == ""){
        alert("SSLエンコード パスフレーズを入力してください。");
		document.form1.passphrase.focus()
        return(false);
    }
	if (document.form1.capath.value == ""){
        alert("SSL証明書ファイルパスを入力してください。");
		document.form1.capath.focus()
        return(false);
    }
	if (document.form1.iconcier_login_id.value == ""){
        alert("ｉコンシェル認証IDを入力してください。");
		document.form1.iconcier_login_id.focus()
        return(false);
    }
	if (document.form1.iconcier_login_password.value == ""){
        alert("ｉコンシェル認証パスワードを入力してください。");
		document.form1.iconcier_login_password.focus()
        return(false);
    }
	if (document.form1.popup_msg.value == ""){
        alert("ｉコンシェルポップアップメッセージを入力してください。");
		document.form1.popup_msg.focus()
        return(false);
    }
	if (document.form1.msg_r_password.value == ""){
        alert("メッセージＲ送信パスワードを入力してください。");
		document.form1.msg_r_password.focus()
        return(false);
    }
	if (document.form1.msg_r_email_from.value == ""){
        alert("メッセージＲ送信元アドレスを入力してください。");
		document.form1.msg_r_email_from.focus()
        return(false);
    }
	if (document.form1.email_from.value == ""){
        alert("メール送信元メールアドレスを入力してください。");
		document.form1.email_from.focus()
        return(false);
    }
	if (document.form1.smtp_host.value == ""){
        alert("ｓｍｔｐホストを入力してください。");
		document.form1.smtp_host.focus()
        return(false);
    }
	if (document.form1.smtp_port.value == ""){
        alert("ｓｍｔｐポート番号を入力してください。");
		document.form1.smtp_port.focus()
        return(false);
    }
	if (document.form1.email_send_name.value == ""){
        alert("メール差し出し人名を入力してください。");
		document.form1.email_send_name.focus()
        return(false);
    }
	if (document.form1.LINE_PER_PAGE.value == ""){
        alert("ページに付きデータ数を入力してください。");
		document.form1.LINE_PER_PAGE.focus()
        return(false);
    }
	if (document.form1.map_url.value == ""){
        alert("googleマップサイトを入力してください。");
		document.form1.map_url.focus()
        return(false);
    }
	return(true);
}
</script>

</html>