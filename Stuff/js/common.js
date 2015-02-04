//UTF-8,CR+LF

//--------------------------------------------------
//	window onload (*prototype.js)
Event.observe(window, 'load', function() {

	//--------------------------------------------------
	//	set preload image files
	//	html: <a href="" id="***" onmouseover="Var_img_over('***')"><img src="images/***.gif" id="***_img" /></a>
	img_out = new Array(
		'../images/pbox_close.gif'
	);
	img_over = new Array(
		'../images/pbox_close_over.gif'
	);
	Var_img_preload();
});
//--------------------------------------------------
//	image preload, mouseover & mouseout
var_img_out = new Array();
var_img_over = new Array();
function Var_img_preload()
{
	for(i=0;i<img_out.length;i++) {
		var var_img_dir_pos = img_out[i].lastIndexOf('/') ? img_out[i].lastIndexOf('/')+1 : 0;
		var var_img_name = img_out[i].substring(var_img_dir_pos, img_out[i].lastIndexOf('.'));
		var_img_out[var_img_name] = img_out[i];
		var_img_over[var_img_name] = new Image();
		var_img_over[var_img_name].src = img_over[i];
	}
}
function Var_img_over(a_id)
{
	if(img_obj = document.getElementById(a_id+'_img')) {
		img_obj.src = var_img_over[a_id].src;
		Event.observe(a_id, 'mouseout', function() { img_obj.src = var_img_out[a_id]; });
	}
}
//--------------------------------------------------
//	delete file
//		div id, table name, table id, ${"imgdir_".$dir}
function Delete_file(idName, tbl, tid, dir)
{
	if(!dir) dir = '';
	var query = 'tbl='+tbl+'&col='+idName+'&id='+tid+'&dir='+dir+'&cache='+(new Date()).getTime();
	if(confirm('delete ok?')) {
		document.getElementById(idName).innerHTML = '<div class="loading"><img src="../images/loading.gif" /> deleting...</div>';
		new Ajax.Updater(idName, 'edit_file.php', { method:'post', postBody:query });
	}
}
//--------------------------------------------------
//	get window size
function Get_pageSize()
{
	var w = window.innerWidth || self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth;
	var h = window.innerHeight || self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;	
	page_size = [w,h];
	return page_size;
}
//--------------------------------------------------
//	pop up open, close, set position
function Popup_open(t, idName, url, query)
{
	Popup_setPosition(t, idName);
	//document.getElementById(idName).innerHTML = '<p class="loading"><img src="../images/loading.gif" /> loading...</p>';
	new Ajax.Updater(idName, url, { method:'get', parameters:query });
}
function Popup_close(idName)
{
	var idName = (idName) ? idName : 'popup';
	document.getElementById(idName).innerHTML = '';
}
function Popup_setPosition(e_obj, popup_id)
{
	//var popup_width = Element.getDimensions(document.getElementById(popup_id)).width;
	//var e_position = Position.cumulativeOffset(e_obj);
	//var e_size = Element.getDimensions(e_obj);
	//document.getElementById(popup_id).style.left = (e_position[0] - ( - e_size.width) - popup_width)+'px';
	//document.getElementById(popup_id).style.top = e_position[1]+'px';
	var page_size = Get_pageSize();
	var popup_width = Element.getDimensions(document.getElementById(popup_id)).width;
	var e_position = Position.cumulativeOffset(e_obj);
	document.getElementById(popup_id).style.left = ((page_size[0]-popup_width)/2)+'px';
	document.getElementById(popup_id).style.top = (e_position[1]+10)+'px';
}

//--------------------------------------------------
//	確認ダイアログ
function Conf_yn(conf)
{
	return confirm(conf);
}

//--------------------------------------------------
//	'charge.php'
//	担当者一覧画面
//		企画回より担当者一覧を表示
function Select_charge_ymt()
{
	y = document.getElementById('charge_y').options[document.getElementById('charge_y').selectedIndex].value;
	m = document.getElementById('charge_m').options[document.getElementById('charge_m').selectedIndex].value;
	t = document.getElementById('charge_t').options[document.getElementById('charge_t').selectedIndex].value;
	var query = 'y='+y+'&m='+m+'&t='+t+'&cache='+(new Date()).getTime();
	new Ajax.Updater('charge_list', 'charge_list.php', { method:'post', postBody:query });
}

//--------------------------------------------------
//	'delivery/group_receipt.php', 'delivery/personal_receipt.php'
//	班入金画面
//	個人入金画面
//		合計金額を計算し表示（PHP: number_format()利用）
function D_receipt_total()
{
	var query = '';
	if(document.getElementById('cash')) query += 'cash='+document.getElementById('cash').value+'&';
	if(document.getElementById('gold_note')) query += 'gold_note='+document.getElementById('gold_note').value+'&';
	if(document.getElementById('cheque')) query += 'cheque='+document.getElementById('cheque').value+'&';
	if(document.getElementById('gift_card')) query += 'gift_card='+document.getElementById('gift_card').value+'&';
	query += '&cache='+(new Date()).getTime();
	new Ajax.Updater('total', 'group_receipt_total.php', { method:'post', postBody:query });
}

//--------------------------------------------------
//	'delivery/result_list.php'
//	実績一覧画面
//		各訂正画面をポップアップ表示
//		実績一覧で複数チェックをつけている場合一番上のから処理
function D_result_list_popup_correct(t, correctId, member_code, ymt, order_num)
{
	var result_count = document.getElementById('result_count').value;
	var i = 0;
	while(i<=result_count) {
		if(document.resultForm.elements['check['+i+']'].checked) {
			order_num = document.resultForm.elements['check['+i+']'].value;
			break;
		}
		i++;
	}
	var correctMenu = document.getElementById(correctId).options[document.getElementById(correctId).selectedIndex].value;
	var query = 'correctmenu='+correctMenu+'&member_code='+member_code+'&ymt='+ymt+'&order_num='+order_num+'&cache='+(new Date()).getTime();
	//Popup_open(t, 'popup', 'result_list_popup_correct.php', query);
	Popup_setPosition(t, 'popup');
	new Ajax.Updater('popup', 'result_list_popup_correct.php', { method:'post', postBody:query });
}
//		合計金額の計算 (price×num)
function D_result_list_popup_correct_total(price)
{
	//var price = document.getElementById('price').value;
	if(document.getElementById('reduction')) price = price - document.getElementById('reduction').value;
	var item_num = document.getElementById('item_num').value;
	var query = 'price='+price+'&item_num='+item_num+'&cache='+(new Date()).getTime();
	new Ajax.Updater('total_amount', 'result_list_popup_correct_total.php', { method:'post', postBody:query });
}
//		訂正処理
//		「はい」	：訂正処理を行い次のポップアップ画面へ
//		「いいえ」	：次のポップアップ画面へ
function D_result_list_popup_correct_e(correctMenu, member_code, order_num, item_code, ymt, price, conf)
{
	if(conf) {
		//i_correct追加
		var item_num = document.getElementById('item_num').value;
		if(document.getElementById('reduction')) price = document.getElementById('reduction').value;  //値引きがあるとき単価は値引き金額に
		var query = 'correctmenu='+correctMenu+'&member_code='+member_code+'&order_num='+order_num+'&item_code='+item_code+'&ymt='+ymt+'&price='+price+'&item_num='+item_num+'&cache='+(new Date()).getTime();
		new Ajax.Updater('correctE', 'result_list_popup_correct_e.php', { method:'post', postBody:query, onComplete:function() { 
			//訂正リスト更新
			new Ajax.Updater('correctList', 'result_list_correct_list.php', { method:'post', postBody:query, onComplete:function() { 
				D_result_list_popup_correct_next(correctMenu, member_code, ymt);
			} });
		} });
	}else {
		D_result_list_popup_correct_next(correctMenu, member_code, ymt);
	}
}
//		実績一覧で複数チェックをつけている場合次のポップアップ画面を表示
function D_result_list_popup_correct_next(correctMenu, member_code, ymt)
{
	var order_num = '';
	var result_count = document.getElementById('result_count').value;
	var i = 0;
	while(i<=result_count) {
		if(document.resultForm.elements['check['+i+']'].checked) {
			document.resultForm.elements['check['+i+']'].checked = false;
			break;
		}
		i++;
	}
	while(i<=result_count) {
		if(document.resultForm.elements['check['+i+']'].checked) {
			order_num = document.resultForm.elements['check['+i+']'].value;
			break;
		}
		i++;
	}
	if(order_num=='') {
		Popup_close();
	}else {
		var query = 'correctmenu='+correctMenu+'&member_code='+member_code+'&ymt='+ymt+'&order_num='+order_num+'&cache='+(new Date()).getTime();
		new Ajax.Updater('popup', 'result_list_popup_correct.php', { method:'post', postBody:query });
	}
}
//	年月回変更
function D_result_list_ymt_change(t, url)
{
	location.href = url+'&ymt='+t.options[t.selectedIndex].value;
}
//	新規登録の商品名、単価を表示
function D_result_list_new_add_item(t)
{
	Code_to_Name(t, 'itemname', 'j', 'itemName');
	type = 'itemprice';
	idName = 'itemPrice_display_none';
	jk = 'j';
	var query = 'type='+type+'&jk='+jk+'&code='+t.value+'&cache='+(new Date()).getTime();
	new Ajax.Updater(idName, 'code_to_name.php', { method:'post', postBody:query, onComplete:function() { 
		document.getElementById('price').value = (document.getElementById(idName).innerHTML * 1);
	} });
}

//--------------------------------------------------
//	'delivery/special_list.php'
//	特供商品一覧画面
//		登録フラグの変更
function D_special_list_select(idName, mode, order_num)
{
	var query = 'mode='+mode+'&order_num='+order_num+'&cache='+(new Date()).getTime();
	new Ajax.Updater(idName, 'special_list_flag.php', { method:'post', postBody:query });
}

//--------------------------------------------------
//	'delivery/regular.php', 'delivery/regular_popup_add.php', 'delivery/regular_popup_regist.php', 'delivery/regular_popup_del.php'
//	定期配達画面
//		新規登録ポップアップ画面
function D_regular_popup_add(t, member_code)
{
	var query = 'member_code='+member_code+'&cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'regular_popup_add.php', query);
}
//		登録ポップアップ画面（数量変更）
function D_regular_popup_regist(t, member_code, order_num)
{
	var query = 'member_code='+member_code+'&order_num='+order_num+'&cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'regular_popup_regist.php', query);
}
//		削除ポップアップ画面
function D_regular_popup_del(t, member_code, order_num)
{
	var query = 'member_code='+member_code+'&order_num='+order_num+'&cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'regular_popup_del.php', query);
}
//		submit <a href="#" onclick=""></a>
function D_regular_popup_submit(formName)
{
	document.forms[formName].submit();
}

//--------------------------------------------------
//	'delivery/installment.php'
//	三回分割画面
//		商品一覧ポップアップ画面表示
function D_installment_popup_item(t)
{
	var query = 'cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'installment_popup_item.php', query);
}
//		入力された商品コードより商品情報を取得し、単価、商品名、合計金額を表示
function D_installment_item_data()
{
	var item_code = document.getElementById('item_code').value;
	query = 'code='+item_code+'&type=itemprice&cache='+(new Date()).getTime();
	new Ajax.Updater('price_div', 'code_to_name.php', { method:'post', postBody:query, onComplete:function() {
		document.getElementById('price').value = document.getElementById('price_div').innerHTML;
	} });
	query = 'code='+item_code+'&type=itemname&cache='+(new Date()).getTime();
	new Ajax.Updater('item_name', 'code_to_name.php', { method:'post', postBody:query });
	
	//document.getElementById('item_price').value = item_price;
	//document.getElementById('item_name').innerHTML = item_name;
	D_installment_item_amount();
}
//		商品一覧ポップアップ画面より商品情報を取得し、単価、商品名、合計金額を表示
//		-> ポップアップ画面を閉じる
function D_installment_item_data2(item_code, item_price, item_name)
{
	document.getElementById('item_code').value = item_code;
	document.getElementById('item_price').value = item_price;
	document.getElementById('item_name').innerHTML = item_name;
	D_installment_item_amount();
	Popup_close();
}
//		合計金額を計算し表示
function D_installment_item_amount()
{
	var total_amount = document.getElementById('item_price').value * document.getElementById('item_num').value;
	document.getElementById('total_amount').value = total_amount;
}

//--------------------------------------------------
//	各コードより名称を取得し表示
//		(type=='01') 		office code -> office name
//		(type=='03') 		area code 	-> area name
//		(type=='10') 		charge code -> charge name
//		(type=='group')		group code 	-> group name
//		(type=='itemname') 	item code 	-> item name
//		(type=='itemprice') item code 	-> item price
function Code_to_Name(t, type, jk, idName)
{
	var query = 'type='+type+'&jk='+jk+'&code='+t.value+'&cache='+(new Date()).getTime();
	new Ajax.Updater(idName, 'code_to_name.php', { method:'post', postBody:query });
}

//--------------------------------------------------
//	
function Convert_kana(t, opt, idName, len)
{
	var query = 'str='+t.value+'&opt='+opt+'&len='+len+'&cache='+(new Date()).getTime();
	new Ajax.Updater(idName, 'convert_kana.php', { method:'post', postBody:query, onComplete:function() {
		t.value = document.getElementById(idName).innerHTML;
	} });
}

//--------------------------------------------------
//	'member/group.php'
//	班マスタ画面
//		処理種別変更（参照、変更、追加）
function M_group_edit()
{
	var group = document.getElementById('groupCode').value;
	var type = document.getElementById('typeSelect').options[document.getElementById('typeSelect').selectedIndex].value;
	//変更のとき班コード入力欄をreadonlyに
	document.getElementById('groupCode').readOnly = (type==1) ? true : false;
	
	var query = 'group='+group+'&type='+type+'&cache='+(new Date()).getTime();
	new Ajax.Updater('groupInfo', 'group_edit.php', { method:'post', postBody:query });
}
//		組合員情報を取得し表示
function M_group_edit_member(t, idName)
{
	var query = 'code='+t.value+'&cache='+(new Date()).getTime();
	new Ajax.Updater(idName, 'group_edit_member.php', { method:'post', postBody:query });
}
//		郵便番号より住所を取得し表示
function M_group_edit_address(t)
{
	var url = 'group_member_edit_address.php';
	var query = 'zipcode='+t.value+'&cache='+(new Date()).getTime();
	new Ajax.Updater('deliveryAddress', url, { method:'post', postBody:query });
}

//--------------------------------------------------
//	'member/group_member.php'
//	組合員マスタ画面
//		処理種別変更（参照、変更、追加）
function M_group_member_edit()
{
	var member = document.getElementById('memberCode').value;
	var type = document.getElementById('typeSelect').options[document.getElementById('typeSelect').selectedIndex].value;
	//変更のとき組合員コード入力欄をreadonlyに
	document.getElementById('memberCode').readOnly = (type==1) ? true : false;
	
	var query = 'member='+member+'&type='+type+'&cache='+(new Date()).getTime();
	new Ajax.Updater('memberInfo', 'group_member_edit.php', { method:'post', postBody:query });
}
//		郵便番号より住所、住所コードを取得し表示
function M_group_member_edit_address(t)
{
	var url = 'group_member_edit_address.php';
	var query = 'zipcode='+t.value+'&cache='+(new Date()).getTime();
	new Ajax.Updater('address', url, { method:'post', postBody:query });
	
	var query = 'addresscode=1&'+query;
	new Ajax.Updater('addressCode', url, { method:'post', postBody:query });
}

//--------------------------------------------------
//	'system/user_add.php', 'system/user_edit.php'
//	ユーザー登録画面
//	ユーザー編集画面
//		端末一覧ポップアップ画面表示
function S_user_mobile(t, page)
{
	var query = 'page='+page+'&cache='+(new Date()).getTime();
	if(document.getElementById('popup_search')) query = 'search='+document.getElementById('popup_search').value+'&'+query;
	//Popup_open(t, 'popup', 'user_popup_mobile.php', query);
	var page_size = Get_pageSize();
	var popup_width = Element.getDimensions(document.getElementById('popup')).width;
	document.getElementById('popup').style.left = ((page_size[0]-popup_width)/2)+'px';
	document.getElementById('popup').style.top = '390px';
	new Ajax.Updater('popup', 'user_popup_mobile.php', { method:'get', parameters:query });
}
//		端末一覧ポップアップ画面より選択した端末IDを入力欄に挿入
function S_user_mobile_insert(mobileid)
{
	document.getElementById('mobile_id').value = mobileid;
	Popup_close('popup');
}

//--------------------------------------------------
//	'admin/denomination.php'
//	金種登録画面
//		入金情報ポップアップ表示
function A_denomination_popup_receipt(t)
{
	var query = 'cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'denomination_popup_receipt.php', query);
}
//		入金情報削除
function A_denomination_receipt_del(idName, receiptID, amount, demandID, last_flag, conf)
{
	if(confirm(conf)) {
		var query = 'receipt_id='+receiptID+'&amount='+amount+'&demand_id='+demandID+'&cache='+(new Date()).getTime();
		new Ajax.Updater(idName, 'denomination_popup_receipt.php', { method:'post', postBody:query, onComplete:function() {
			if(last_flag) location.href = 'denomination.php';
		} });
		return true;
	}else {
		return false;
	}
}
//		他入出金ポップアップ表示
function A_denomination_popup_other(t, rp_flag)
{
	var query = 'rp_flag='+rp_flag+'&cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'denomination_popup_other.php', query);
}
//		他入出金情報削除
function A_denomination_other_del(idName, otherID, rp_flag, last_flag, conf)
{
	if(confirm(conf)) {
		var query = 'other_id='+otherID+'&rp_flag='+rp_flag+'&cache='+(new Date()).getTime();
		new Ajax.Updater(idName, 'denomination_popup_other.php', { method:'post', postBody:query, onComplete:function() {
			if(last_flag) location.href = 'denomination.php';
		} });
		return true;
	}else {
		return false;
	}
}
//		訂正情報ポップアップ表示
function A_denomination_popup_correct(t, rp_flag)
{
	var query = 'rp_flag='+rp_flag+'&cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'denomination_popup_correct.php', query);
}
//		加入組合員ポップアップ表示
function A_denomination_popup_investment(t)
{
	var query = 'cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'denomination_popup_investment.php', query);
}
//		ポップアップを閉じたあと、金種画面へリダイレクト
function A_denomination_popup_close()
{
	Popup_close();
	location.href = 'denomination.php';
}
//	現金有高、過不足の計算
function A_denomination_calc()
{
	//　数字以外が入力されたら0を表示する
	if(document.denominationForm.denomination1_num.value.match(/[^0-9]/g)){document.denominationForm.denomination1_num.value = '0';
	}else if(document.denominationForm.denomination2_num.value.match(/[^0-9]/g)){document.denominationForm.denomination2_num.value = '0';
	}else if(document.denominationForm.denomination3_num.value.match(/[^0-9]/g)){document.denominationForm.denomination3_num.value = '0';
	}else if(document.denominationForm.denomination4_num.value.match(/[^0-9]/g)){document.denominationForm.denomination4_num.value = '0';
	}else if(document.denominationForm.denomination5_num.value.match(/[^0-9]/g)){document.denominationForm.denomination5_num.value = '0';
	}else if(document.denominationForm.denomination6_num.value.match(/[^0-9]/g)){document.denominationForm.denomination6_num.value = '0';
	}else if(document.denominationForm.denomination7_num.value.match(/[^0-9]/g)){document.denominationForm.denomination7_num.value = '0';
	}else if(document.denominationForm.denomination8_num.value.match(/[^0-9]/g)){document.denominationForm.denomination8_num.value = '0';
	}else if(document.denominationForm.denomination10_num.value.match(/[^0-9]/g)){
		document.denominationForm.denomination10_num.value = '';
	}else if(document.denominationForm.denomination10_amount.value.match(/[^0-9]/g)){
		document.denominationForm.denomination10_amount.value = '';
	}else if(document.denominationForm.denomination11_num.value.match(/[^0-9]/g)){
		document.denominationForm.denomination11_num.value = '';
	}else if(document.denominationForm.denomination11_amount.value.match(/[^0-9]/g)){
		document.denominationForm.denomination11_amount.value = '';
	}else if(document.denominationForm.denomination12_num.value.match(/[^0-9]/g)){
		document.denominationForm.denomination12_num.value = '';
	}else if(document.denominationForm.denomination12_amount.value.match(/[^0-9]/g)){
		document.denominationForm.denomination12_amount.value = '';
	}else if(document.denominationForm.denomination13_num.value.match(/[^0-9]/g)){
		document.denominationForm.denomination13_num.value = '';
	}else if(document.denominationForm.denomination13_amount.value.match(/[^0-9]/g)){
		document.denominationForm.denomination13_amount.value = '';
	}

	//　金種入力欄の値を削除されたら0を表示する
	if(!document.denominationForm.denomination1_num.value){document.denominationForm.denomination1_num.value = '0';
	}else if(!document.denominationForm.denomination2_num.value){document.denominationForm.denomination2_num.value = '0';
	}else if(!document.denominationForm.denomination3_num.value){document.denominationForm.denomination3_num.value = '0';
	}else if(!document.denominationForm.denomination4_num.value){document.denominationForm.denomination4_num.value = '0';
	}else if(!document.denominationForm.denomination5_num.value){document.denominationForm.denomination5_num.value = '0';
	}else if(!document.denominationForm.denomination6_num.value){document.denominationForm.denomination6_num.value = '0';
	}else if(!document.denominationForm.denomination7_num.value){document.denominationForm.denomination7_num.value = '0';
	}else if(!document.denominationForm.denomination8_num.value){document.denominationForm.denomination8_num.value = '0';
	}else if(!document.denominationForm.denomination9_num.value){document.denominationForm.denomination9_num.value = '0';
	}

	var cash_total = A_denomination_cash_total();
	
	if(cash_total =='0'){document.denominationForm.balance.value = '0';
	}else{document.denominationForm.balance.value = cash_total;}
	
	document.denominationForm.not_equal.value = cash_total - document.getElementById('total_amount').value ;
}
//		金種計算
function A_denomination_cash_total()
{
	var cash_total = document.denominationForm.denomination1_num.value * 10000;
	cash_total += document.denominationForm.denomination2_num.value * 5000;
	cash_total += document.denominationForm.denomination3_num.value * 1000;
	cash_total += document.denominationForm.denomination4_num.value * 500;
	cash_total += document.denominationForm.denomination5_num.value * 100;
	cash_total += document.denominationForm.denomination6_num.value * 50;
	cash_total += document.denominationForm.denomination7_num.value * 10;
	cash_total += document.denominationForm.denomination8_num.value * 5;
	cash_total += document.denominationForm.denomination9_num.value * 1;
	cash_total += document.denominationForm.denomination10_num.value * document.denominationForm.denomination10_amount.value;
	cash_total += document.denominationForm.denomination11_num.value * document.denominationForm.denomination11_amount.value;
	cash_total += document.denominationForm.denomination12_num.value * document.denominationForm.denomination12_amount.value;
	cash_total += document.denominationForm.denomination13_num.value * document.denominationForm.denomination13_amount.value;
	cash_total += document.denominationForm.denomination14_num.value * document.denominationForm.denomination14_amount.value;
	return cash_total;
}
//		【登録】ボタン押下時、過不足あれば確認ダイアログ表示
function A_denomination_check_not_equal(conf)
{
	var cash_total = A_denomination_cash_total();
	var not_equal = document.getElementById('total_amount').value - cash_total;
	return (not_equal==0) ? true : Conf_yn(conf);
}

//--------------------------------------------------
//	'admin/member_add.php'
//	組合員登録画面
//		組合員コードポップアップ画面表示
function A_member_add_member_code(t)
{
	var query = 'cache='+(new Date()).getTime();
	Popup_open(t, 'popup', 'member_add_popup_member_code.php', query);
}
//		端末一覧ポップアップ画面より選択した端末IDを入力欄に挿入
function A_member_add_member_code_insert(member_code)
{
	document.getElementById('memberCode').value = member_code;
	Popup_close('popup');
}

//--------------------------------------------------
//	'admin/accept.php'
//	承認画面
//		一覧表示
function A_accept_list()
{
	var y = document.acceptForm.accept_date_y.value;
	var m = document.acceptForm.accept_date_m.value;
	var d = document.acceptForm.accept_date_d.value;
	var ampm = (document.acceptForm.ampm[0].checked) ? 1 : 2;

	var query = 'accept_date_y='+y+'&accept_date_m='+m+'&accept_date_d='+d+'&ampm='+ampm+'&cache='+(new Date()).getTime();
	new Ajax.Updater('acceptList', 'accept_list.php', { method:'post', postBody:query });
}

//--------------------------------------------------
//	'admin/status.php'
//	ステータス一覧画面
//		一覧表示
function A_status_list()
{
	var y = document.statusForm.accept_date_y.value;
	var m = document.statusForm.accept_date_m.value;
	var d = document.statusForm.accept_date_d.value;
	var ampm = (document.statusForm.ampm[0].checked) ? 1 : 2;
	
	var query = 'accept_date_y='+y+'&accept_date_m='+m+'&accept_date_d='+d+'&ampm='+ampm+'&cache='+(new Date()).getTime();
	new Ajax.Updater('statusList', 'status_list.php', { method:'post', postBody:query });
}

//--------------------------------------------------
//	'admin/management.php'
//	管理メニュー画面
//		一覧表示
function A_management_list()
{
	var y = document.managementForm.accept_date_y.value;
	var m = document.managementForm.accept_date_m.value;
	var d = document.managementForm.accept_date_d.value;
	var ampm = (document.managementForm.ampm[0].checked) ? 1 : 2;
	
	var query = 'accept_date_y='+y+'&accept_date_m='+m+'&accept_date_d='+d+'&ampm='+ampm+'&cache='+(new Date()).getTime();
	new Ajax.Updater('managementList', 'management_list.php', { method:'post', postBody:query });
}
function A_management_loading(idName, msg)
{
	document.getElementById(idName).innerHTML = '<img src="../images/loading.gif" /> '+msg;
}


 function chg_page(idx){
                var bbb = document.getElementById("paramform");
                bbb.action = idx;
                document.form1.submit();
            }

function title_form_sumit(){
	            //var bbb = document.getElementById("titleform");
				document.titleform.submit();
                //bbb.submit();
            }

