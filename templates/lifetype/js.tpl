
    //------------------------------------------------------------------------------------------------------------------------
    //  use javascript :  
    //      system -> {ldelim}js src="js/ui/pages/{$mName1}.js"{rdelim}
    //      plugin -> {ldelim}js src="plugins/{$oName1}/js/ui/pages/{$mName1}.js"{rdelim}
    //------------------------------------------------------------------------------------------------------------------------


Lifetype.UI.Pages.{$mName3} = function() {ldelim}{rdelim}

//新增時呼叫某程式 form.id => op=form.id
Lifetype.UI.Pages.{$mName3}.addSubmitHook = function( form ) {ldelim}
    Lifetype.Forms.AjaxFormProcessor( form.id, '?output=json', {ldelim}
        resetAfterSuccess:true, 
        formSuccessCallback: function() {ldelim}{rdelim}, 
        formErrorCallback: function() {ldelim}{rdelim}
    {rdelim});
{rdelim}

/*
//新增之後如果要影響原表單內容物, 以下範例以 select 元件為例
Lifetype.UI.Pages.{$mName3}.addSubmitHook = function( form ) {ldelim}
    el = Lifetype.Dom.$( 'newName' );
    selected = el.options[el.selectedIndex] ;
    Lifetype.Forms.AjaxFormProcessor( form.id, '?output=json', {ldelim}
        resetAfterSuccess:true, 
        formSuccessCallback: function() {ldelim}
            el.removeChild( selected );
        {rdelim}, 
        formErrorCallback: function() {ldelim}{rdelim}
    {rdelim});
{rdelim}
*/

//更新之後保持原資料，所以不做 reset 動作
Lifetype.UI.Pages.{$mName3}.updateSubmitHook = function( form ) {ldelim}
    Lifetype.Forms.AjaxFormProcessor( form.id, '?output=json', {ldelim}
        resetAfterSuccess:false, 
        formSuccessCallback: function() {ldelim}{rdelim}, 
        formErrorCallback: function() {ldelim}{rdelim}
    {rdelim});
{rdelim}

/*
//送出資料成功後 ( 註冊在 formProcessorSuccessEvent.subscribe ) 要更新 from 的事
Lifetype.UI.Pages.{$mName3}.updateForm = function( type, args )
{ldelim}
    var o = args[0];
    var response = Lifetype.JSon.decode( o.responseText );
    var result = response.result;
    var field = Lifetype.Dom.$( '表單欄位name名稱' );
    if( field ) {ldelim}
        if ( result.資料庫欄位名稱 == 1 ) {ldelim}
            field.parentNode.removeChild( field );
        {rdelim} else if ( result.資料庫欄位名稱 == 2 ) {ldelim}
            Lifetype.UI.OverlayManager.getActive().hide();
        {rdelim}
    {rdelim}
{rdelim}
*/

//首次載入時要做的事
YAHOO.util.Event.addListener( window, "load", function() {ldelim}
    var t = new Lifetype.Effects.Table( "list" );  //table tr行 樣式的 cycle
    if(t) {ldelim}
        t.stripe();
        t.highlightRows();
    {rdelim}

    //如果使用 Lifetype.Forms.performRequest(this) , 可以讓原呼叫頁 reaload, 例如刪除的時候使用, 會讓頁面 reload 以保持完整性 
    Lifetype.Forms.Events.performRequestSuccessEvent.subscribe( Lifetype.UI.AjaxPager.reload );
    //重整最原頁的list區塊
    Lifetype.Forms.Events.formProcessorSuccessEvent.subscribe(  Lifetype.UI.AjaxPager.reload );
    
    //
    //Lifetype.Forms.Events.formProcessorSuccessEvent.subscribe(  Lifetype.UI.Pages.{$mName3}.reload ); 
    //Lifetype.Forms.Events.formProcessorSuccessEvent.subscribe(  Lifetype.UI.Pages.{$mName3}.updateForm );

    //無 pager 的使用方法
    Lifetype.Forms.Events.performRequestSuccessEvent.subscribe( function() {ldelim} Lifetype.UI.DataTable.reload('?op=edit{$mName3}') {rdelim} );
    Lifetype.Forms.Events.formProcessorSuccessEvent.subscribe( function( type, args ) {ldelim}
        Lifetype.UI.DataTable.reload('?op=edit{$mName3}') {rdelim}
        /*
            var o = args[0];
            var response = Lifetype.JSon.decode( o.responseText );
            document.getElementById("showId").innerHTML       = response.result.user.id;
            document.getElementById("showUsername").innerHTML = response.result.user.username;
        */
    {rdelim});

{rdelim});


//顯示載入中
//Lifetype.Effects.Form.showPanel();

//隱藏載入中
//Lifetype.Effects.Form.hidePanel();

