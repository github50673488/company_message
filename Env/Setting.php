<?php
  //------------DB-----------------    
// define("DB_SERVER","localhost");
// define("DB_USER","root");
// define("DB_PSW","");//本番
// define("DB_NAME","info_company");
  
 define("DB_SERVER","localhost");
 define("DB_USER","root");
 define("DB_PSW","thesarasa0330");//local
 define("DB_NAME","company_message");
 
  define("CTL_KEY","ctl");
  define("ACT_KEY","action"); 
  define("URL_LIST","urllist");
  define("MAX_PAGE","maxpage");
  define("NOW_PAGE","nowpage");
  define("TOP_PAGE","toppage");
  define("PREV_PAGE","prevpage");
  define("NEXT_PAGE","nextpage");
  define("LAST_PAGE","lastpage");
  
  //マイボックス設定
     define("host","so.docomo-apms.ne.jp");//マイボックスリクエストホスト
  define("pid_f","22800501");///マイボックユーザ一括登録/削除 ページID
  define("pid_p","22810501");///マイボックユーザ個別登録ページID
  define("rid_add_f","228005001");///マイボックユーザ一括登録リクエストID
  define("rid_del_f","228005002");///マイボックユーザ一括削除リクエストID
  define("rid_add_p","228105001");///マイボックユーザ個別登録リクエストID
  define("rid_del_p","228105002");///マイボックユーザ個別削除リクエストID
  
  define("host_iconcier","is.i-concier.docomo.ne.jp");//ｉコンシェル送信ホスト
  define("msg_r_email_to","send@msg.docomo-apms.ne.jp");//メッセージＲ送信先メールアドレス
  
  
  //添付ファイル設定
  define("HTML_PATH","http://dcm2.dmpw.jp/info/App/Controller/move/info/");//ｈｔｍｌファイルのフォルダ（インターネット）
  define("toruka_down_url","http://dcm2.dmpw.jp/info/Upload/Toruka/");//トルカファイルのフォルダ（インターネット）
  define("schedule_down_url","http://dcm2.dmpw.jp/info/Upload/Schedule/");//ｈｔｍｌファイルのフォルダ（インターネット）
  define("info_path","./move/info/");//ｈｔｍｌファイルのフォルダ(ファイルシステム)
  define("toruka_path","../../Upload/Toruka/");//トルカファイルのフォルダ(ファイルシステム)
  define("schedule_path","../../Upload/Schedule/");//ｈｔｍｌファイルのフォルダ(ファイルシステム)
  
  
  
  //以下＝＝＝＝＝＝＝＝＝＞DBへ移動(設定画面で変更できるように)　liu 2010/04/27
  
  //マイボックス設定
  //define("mybox_no","02000062004");//マイボックスサービス番号 
  //define("basic_auth_id","CP001048");//Basic認証ID
  //define("basic_auth_pswd","SfHwob8BAq8m");//Basic認証パスワード
  //define("local_cert","/var/www/html/coop/opt/cert/demo.pem");//SSL証明書ファイル  
  //define("passphrase","5644");//SSL　エンコード パスフレーズ
  //define("capath","/var/www/html/coop/opt/cert/servercert/");//SSL証明書ファイルパス 
  

  //ドコモ携帯送信設定
  //define("iconcier_login_id","000062");//ｉコンシェル認証ID 
  //define("iconcier_login_password","sanokatsuyuki");//ｉコンシェル認証パスワード 
  //define("popup_msg","社内システムからのお知らせ");//ｉコンシェル送信ポップアップメッセージ 
  //define("msg_r_password","X1KMwTb0fzMpouDf");//メッセージＲ送信パスワード
  //define("msg_r_email_from","demo@maildcm2.dmpw.jp");//メッセージＲ送信元メールアドレス 
  
  //メール送信設定
  //define("email_from","demo@maildcm2.dmpw.jp");//メール送信元メールアドレス
  //define("smtp_host","127.0.0.1");//ｓｍｔｐホスト
  //define("smtp_port","25");//ｓｍｔｐポート番号
  //define("email_send_name","ＮＴＴ　ＤＯＣＯＭＯ");//メール差し出し人名
  
  //他の設定
  //define("LINE_PER_PAGE",10);//ページに付きデータ数 
  //define("map_url","http://members.jcom.home.ne.jp/wa-ga-ya/map/map.htm");//追加googleマップサイト 
  
?>