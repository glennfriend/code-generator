{literal}
    //------------------------------------------------------------------------------------------------------------------------
    //  blog tamplate tool
    //------------------------------------------------------------------------------------------------------------------------

min-height { /* 設定最窄高度 */
    min-height:80px; 
    height:auto !important; 
    height:80px; 
    overflow:visible;
}

.words{ /* 過長斷行 (FF無法精確使用) */
    word-break:break-all;   /* IE 過長的英文不換行, 直接接在字後面 */
    word-wrap:break-word;
    table-layout:fixed;     /* IE 截斷不顯示 , FF 跨過table直接顯示 */
}

.papers { /* 設定對齊的文章格式 */
    text-align:justify;      /* 針對英文設定 */
    text-justify:distribute; /* 針對中文設定 */
}

.pre{ /* 帶卷動框的pre格式 */
    white-space: pre-wrap;       /* css-3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
    /* overflow:scroll; */
    width:750px;
    border:1px solid #999;
    padding:5px;
    font-size:16px;
    /* line-height: 22px;   */   /* 文字上下間格 */
    /* letter-spacing: 1px; */   /* 文字左右間格 */
}






{/literal}