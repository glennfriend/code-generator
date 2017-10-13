{literal}


    //------------------------------------------------------------------------------------------------------------------------
    //  blog tamplate tool
    //------------------------------------------------------------------------------------------------------------------------

name="items[100][name]" id="items_100" value="{$items[100].name}"

{$locale->tr("menu")}  -  選單
{$url->blogLink()}"  -  {$blog->getBlog()}  -  首頁  -  {$locale->tr("main")}
{$url->templatePage("archives")}  -  彙整頁面  -  {$locale->tr("archives")}
{$url->albumLink()}"  -  資料夾  -  {$locale->tr("albums")}
{$url->getTemplateFile("imgs/default.gif")}  -  樣版路徑

{foreach name=mylinkscategories from=$mylinkscategories item=panel_linkcategory}
    {if $smarty.foreach.mylinkscategories.first}
        <li><a title="{$locale->tr("links")}" href="{$url->templatePage("links")}">{$locale->tr("links")}</a></li>
    {/if}
{/foreach}


{$locale->tr("about_myself")}  -  關於我  -  自我介紹
{assign var=AboutMyself value=$blogOwner->getAboutMyself()}
{if $blogOwner->hasPicture() && $AboutMyself}

    {assign var=picture value=$blogOwner->getPicture()}
    <img id="UserPicture" src="{$picture->getPreviewLink()}" alt="{$blogOwner->getUsername()}" />
    <p>{$AboutMyself}</p>
    <a href="mailto:{$blogOwner->getEmail()}">{$blogOwner->getEmail()}</a>

{/if}

{$locale->tr("search")}  -  搜尋
<form id="search_form" method="post" action="{$url->getIndexUrl()}">
    <input type="hidden" name="op" value="Search" />
    <input type="hidden" name="blogId" value="{$blog->getId()}" />
    <input type="text" id="searchTerms" name="searchTerms" value="" />
    <input type="submit" name="Search" value="{$locale->tr("search_s")}" />
</form>


在 resource 的頁面顯示 五張 小圖
<style type="text/css" >
    .miniAlbum      {ldelim} width:80px;height:80px;margin:3px;border:#bbbbbb 5px solid; {rdelim}
    .miniEmptyAlbum {ldelim} width:80px;height:80px;margin:3px;border:#bbbbbb 5px solid;background-color:#bbbbbb; {rdelim}
    .miniPoint      {ldelim} border:0px; margin-bottom:40px; {rdelim}
</style>
<div id="albumNav" style="text-align:center;vertical-align:middle;width:100%;">
    {if $prevresource}
        <a href="{$url->resourceLink($prevresource)}#album"><img src="{$url->getBaseUrl()}/imgs/go-previous.png" class="miniPoint" /></a>
    {/if}

    {if $prevprevresource}
        <a title="{$prevprevresource->getDescription()}" href="{$url->resourceLink($prevprevresource)}#album">
        {if $prevprevresource->isImage()} 
            <img src="{$url->resourcePreviewLink($prevprevresource)}" alt="{$prevprevresource->getDescription()}" class="miniAlbum" />
        {else}
            <img src="{$url->getBaseUrl()}/imgs/file.gif" class="miniAlbum" />
        {/if}
        </a>
    {else}<img src="{$url->getBaseUrl()}/imgs/transparent.1x1.gif" class="miniAlbum" />{/if}

    {if $prevresource}
        <a title="{$prevresource->getDescription()}" href="{$url->resourceLink($prevresource)}#album">
        {if $prevresource->isImage()} 
            <img src="{$url->resourcePreviewLink($prevresource)}" border="0" alt="{$prevresource->getDescription()}" class="miniAlbum" />
        {else}
            <img src="{$url->getBaseUrl()}/imgs/file.gif" class="miniAlbum" />
        {/if}
        </a>
    {else}<img src="{$url->getBaseUrl()}/imgs/transparent.1x1.gif" class="miniAlbum" />{/if}

    <a title="Folder" href="#">
      {if $resource->isImage()} 
        <img src="{$url->resourceMediumSizePreviewLink($resource)}" border="0" alt="Folder" class="miniAlbum" />
      {else}
        <img src="{$url->getBaseUrl()}/imgs/file.gif" class="miniAlbum" />
      {/if}
    </a>

    {if $nextresource}
        <a title="{$nextresource->getDescription()}" href="{$url->resourceLink($nextresource)}#album">
        {if $nextresource->isImage()} 
            <img src="{$url->resourcePreviewLink($nextresource)}" border="0" alt="{$nextresource->getDescription()}" class="miniAlbum" />
        {else}
            <img src="{$url->getBaseUrl()}/imgs/file.gif" class="miniAlbum" />
        {/if}
        </a>
    {else}<img src="{$url->getBaseUrl()}/imgs/transparent.1x1.gif" class="miniAlbum" />{/if}

    {if $nextnextresource}
        <a title="{$nextnextresource->getDescription()}" href="{$url->resourceLink($nextnextresource)}#album">
        {if $nextnextresource->isImage()} 
            <img src="{$url->resourcePreviewLink($nextnextresource)}" border="0" alt="{$nextnextresource->getDescription()}" class="miniAlbum" />
        {else}
            <img src="{$url->getBaseUrl()}/imgs/file.gif" class="miniAlbum" />
        {/if}
        </a>
    {else}<img src="{$url->getBaseUrl()}/imgs/transparent.1x1.gif" class="miniAlbum" />{/if}

    {if $nextresource}
        <a href="{$url->resourceLink($nextresource)}#album"><img src="{$url->getBaseUrl()}/imgs/go-next.png" class="miniPoint" /></a>
    {/if}

</div>

網站連結分類列表
    {foreach from=$mylinkscategories item=linkcategory}
        分類名稱 : {$linkcategory->getId()} / {$linkcategory->getName()}
        <br />
        {foreach from=$linkcategory->getLinks() item=link}
            <a href="{$link->getUrl()}" title="{$link->getDescription()}">{$link->getName()}</a>
            {if $link->getRssFeed() != ""}
                <a href="{$link->getRssFeed()}"><img src="{$url->getUrl("/imgs/rss_logo_small.gif")}" alt="RSS" /></a>
            {/if}
            <br />
        {/foreach}
    {/foreach}

計算發表文章自今已過多久 - 天時分秒
　　　　　　　　　　　　 - 天時分
    {assign var=postCreateTimesObject value=$post->getTimestampWithoutOffset()} 
    {assign var=postCreateTimes       value=$postCreateTimesObject->getUnixDate()} 
    {assign var=timesInterval         value=`$smarty.now-$postCreateTimes`}
    {* 注意, 以下 天數 的部份最後是用除出來的, 所以最後以 天數 為最大單位 *}
    
    {if $timesInterval/60/60/24>1}     {$timesInterval/60/60/24%9999} 天 {/if}
    {if $timesInterval/60/60%24>0}     {$timesInterval/60/60%24} 時      {/if}
    {if $timesInterval/60%60>0}        {$timesInterval/60%60} 分         {/if}
    {if $timesInterval%60>0}           {$timesInterval%60} 秒            {/if}前
    
    {if $timesInterval/60/60/24>1}     {$timesInterval/60/60/24%9999} 天 {/if}
    {if $timesInterval/60/60%24>0}     {$timesInterval/60/60%24} 時      {/if}
    {$timesInterval/60%60} 分前

取得登入者的 blog
    {assign var=authBlogs value=$authuser->getBlogs()}
    {if $authBlogs && $authBlogs[0]}
        {assign var=request value=$authBlogs[0]->getBlogRequestGenerator()}
        <a class="topbarRightText"  href="{$request->blogLink()}">我的網誌 is {$authBlogs[0]->getBlog()}</a>
    {/if}

網誌分類
     {assign var=blogCategory value=$blog->getBlogCategory()}
     <a class="topbarLeftText" href="{$rg->getBaseUrl()}/summary.php?op=BlogList&blogCategoryId={$blogCategory->getId()}" >{$blogCategory->getName()}</a>




    //------------------------------------------------------------------------------------------------------------------------
    //  summary tamplate tool
    //------------------------------------------------------------------------------------------------------------------------

歡迎訊息
    {$locale->tr("summary_welcome_paragraph")}

最新發表的文章 - {$locale->tr("summary_latest_posts")}
RSS - 
    <a href="{$url->getRssUrl()}?summary=1">
        <img src="{$url->getUrl("/imgs/rss_logo_mini.gif")}" alt="RSS" />
    </a>

文章圖片 (文章內有圖片就使用文章圖片)
      {assign var="hasPreview" value=0}
      {assign var=postResources value=$post->getArticleResources()}
      {if $postResources}
          {* 取 article 第一張圖的 resource *}
          {foreach from=$postResources item=postResource}
              {if $postResource->hasPreview()}
                  {if $hasPreview!=1}
                    小圖:<img src="{$url->resourcePreviewLink($postResource)}"  width="60" height="60" onError="this.width=60;this.height=60;this.src='{$url->getUrl('/templates/summary/nouser.gif')}'" />
                    原圖:<img src="{$url->resourceDownloadLink($postResource)}" width="60" height="60" onError="this.width=60;this.height=60;this.src='{$url->getUrl('/templates/summary/nouser.gif')}'" />
                  {/if}
                  {assign var="hasPreview" value=1}
              {/if}
          {/foreach}
      {/if}
      {if $hasPreview!=1}
          {if $postOwner->hasPicture()}
              {assign var=picture value=$postOwner->getPicture()}
              縮圖:<img src="{$picture->getPreviewLink()}"       alt="{$post->getTopic()}" width="60" height="60" onError="this.width=60;this.height=60;this.src='{$url->getUrl('/templates/summary/nouser.gif')}'" />
              中圖:<img src="{$picture->getMediumPreviewLink()}" alt="{$post->getTopic()}" />
          {else}
              <img src="templates/summary/nouser.gif" width="60" height="60" alt="{$postOwner->getUsername()|strip_tags}" />
          {/if}
      {/if}

文章圖片 (不管文章內有沒有圖片)
    {if $postOwner->hasPicture()}
        {assign var=picture value=$postOwner->getPicture()}
        <img src="{$picture->getPreviewLink()}"  width="60" height="60" class="postgrav" />
    {else}
        <img src="templates/summary/nouser.gif" width="60" height="60" alt="{$postOwner->getUsername()|strip_tags}" />	
    {/if}  


文章標題 - <a href="{$request->postPermalink($post)}">{$post->getTopic()|strip_tags|utf8_truncate:60}</a>

發表於 - {$locale->tr("posted_in")}
分類 - {$locale->tr("category")} 
部落格名稱 - <a href="{$request->blogLink()}">{$blog->getBlog()}</a>

全域分類
    {if $artGlobalCategory}
        <a href="?op=PostList&amp;globalArticleCategoryId={$artGlobalCategory->getId()}">{$artGlobalCategory->getName()}</a>
    {/if}

全域文章分類               
{foreach from=$globalArticleCategories item=globalArticleCategory}
<li>
    <a href="{$url->getBaseUrl()}/summary.php?op=PostList&amp;globalArticleCategoryId={$globalArticleCategory->getId()}">{$globalArticleCategory->getName()}</a>
</li>
{/foreach}

全域網誌分類
{foreach from=$blogCategories item=blogCategory}
<li>
    <a href="{$url->getBaseUrl()}/summary.php?op=BlogList&amp;blogCategoryId={$blogCategory->getId()}">{$blogCategory->getName()}</a>
</li>
{/foreach}

文章內文 - {$post->getText()|strip_tags|utf8_truncate:140:"..."}
發文帳號 - {$postOwner->getUsername()}
發文日期 - {$locale->formatDate($postDate,"%e %B %Y")} |
迴響 與 迴響數量 - <a href="{$request->postPermalink($post)}#comments">{if $post->getTotalComments() eq 0}{$locale->tr("comment on this")}{else}{$post->getTotalComments()} {$locale->tr("comments")|capitalize}{/if}</a>

搜尋 - {$locale->tr("search_s")}
站內搜尋 - {$locale->tr("search")}
搜尋方式 - {$locale->tr("search_type")}
文章 - {$locale->tr("posts")}
網誌 - {$locale->tr("blogs")}
檔案 - {$locale->tr("resources")}
    <form id="searchForm" method="post" action="{$smarty.server.PHP_SELF}">
        <fieldset>
            <label for="searchTerms">{$locale->tr("search")}:
                <input type="text" tabindex="1" name="searchTerms" id="searchTerms" value="" size="14" />
            </label>
            <label for="searchType">{$locale->tr("search_type")}:
                <select name="searchType" id="searchType">
                    <option value="1">{$locale->tr("posts")}</option>
                    <option value="2">{$locale->tr("blogs")}</option>
                    <option value="3">{$locale->tr("resources")}</option>
                </select>
            </label>        
            <input type="hidden" name="op" value="summarySearch" />            
            <input type="submit" class="button" name="summarySearch" value="{$locale->tr("search")}" />
        </fieldset>
    </form>

登入 - {$locale->tr("login")}
<form id="loginForm" method="post" action="admin.php">
    <fieldset class="inputField">
        {nocache}
            {if $authuser}
                {assign var=userName value=$authuser->getUsername()}
                {$locale->pr("summary_welcome_msg", $userName)}<br/>
                <a href="admin.php?op=blogSelect">{$locale->tr("summary_go_to_admin")}</a>
            {else}
                <label for="userName">{$locale->tr("username")}:
                    <input type="text" name="userName" id="userName" value="" size="8" maxlength="32" />
                </label>
                <label for="userPassword">{$locale->tr("password")}: 
                    <input type="password" name="userPassword" id="userPassword" size="8" maxlength="32" />
                </label>
                <input type="submit" name="Login" value="{$locale->tr("login")}" class="button" />
                <input type="hidden" name="op" value="Login"  />
                <br/>
                <a href="?op=resetPasswordForm">{$locale->tr("password_forgotten")}</a>
            {/if}
        {/nocache}
    </fieldset>
</form>


最活躍網誌 - {$locale->tr("summary_most_active_blogs")}
最活躍網誌RSS - 
<a href="{$url->getRssUrl()}?summary=1&amp;type=mostactiveblogs">
    <img src="{$url->getUrl("/imgs/rss_logo_mini.gif")}" alt="RSS" />
</a>
最活躍網誌資料
{assign var=activeBlogs value=$summaryStats->getMostActiveBlogs()}
{if $activeBlogs}
  <ul>
    {foreach from=$activeBlogs item=blog}
        {assign var="url" value=$blog->getBlogRequestGenerator()}
        <li><a href="{$url->blogLink()}">{$blog->getBlog()|strip_tags|utf8_truncate:60}</a></li>
    {/foreach}
  </ul>
{/if}

最新建立的網誌 - {$locale->tr("summary_newest_blogs")}
最新建立的網誌 RSS
<a href="{$url->getRssUrl()}?summary=1&amp;type=newestblogs">
    <img src="{$url->getUrl("/imgs/rss_logo_mini.gif")}" alt="RSS" />
</a>
最新建立的網誌資料
{assign var=recentBlogs value=$summaryStats->getRecentBlogs()}
{if $recentBlogs}
  <ul>
    {foreach from=$recentBlogs item=blog}
        {assign var="url" value=$blog->getBlogRequestGenerator()}
        <li><a href="{$url->blogLink()}">{$blog->getBlog()|strip_tags|utf8_truncate:60}</a></li>
    {/foreach}
  </ul>
{/if}

最多人閱讀文章 - {$locale->tr("summary_most_read_articles")}
最多人閱讀文章 RSS
<a href="{$url->getRssUrl()}?summary=1&amp;type=mostread">
    <img src="{$url->getUrl("/imgs/rss_logo_mini.gif")}" alt="RSS" />
</a>
最多人閱讀文章資料
{assign var=readestBlogs value=$summaryStats->getMostReadArticles()}
{if $readestBlogs}
  <ul>
    {foreach name=readest from=$readestBlogs item=post}
        {assign var="blog" value=$post->getBlogInfo()}
        {assign var="url" value=$blog->getBlogRequestGenerator()}     
        <li><a href="{$url->postPermalink($post)}">{$post->getTopic()|strip_tags|utf8_truncate:60}</a> ({$post->getNumReads()}) </li>
    {/foreach}
  </ul>
{/if}

最多迴響文章 - {$locale->tr("summary_most_commented_articles")}
最多迴響文章 RSS
<a href="{$url->getRssUrl()}?summary=1&amp;type=mostcommented">
    <img src="{$url->getUrl("/imgs/rss_logo_mini.gif")}" alt="RSS" />
</a>
最多迴響文章資料
{assign var=commentedPosts value=$summaryStats->getMostCommentedArticles()}
{if $commentedPosts} 
  <ul>
    {foreach name=commented from=$commentedPosts item=post}
        {assign var="blog" value=$post->getBlogInfo()}
        {assign var="url" value=$blog->getBlogRequestGenerator()}	
        <li><a href="{$url->postPermalink($post)}">{$post->getTopic()|strip_tags|utf8_truncate:60}</a> ({$post->getTotalComments()}) </li>
    {/foreach}
  </ul>
{/if}

熱門文章
{assign var=readestBlogs value=$summaryStats->getMostReadArticles()}
{if $readestBlogs}
    {foreach name=readest from=$readestBlogs item=post}
        {assign var="postOwner" value=$post->getUserInfo()}
        {assign var="myBlog" value=$post->getBlogInfo()}
        {assign var="request" value=$myBlog->getBlogRequestGenerator()}
        {if $smarty.foreach.readest.index == 0}
            read = {$post->getNumReads()} <br />
            topic = <a href="{$request->postPermalink($post)}">{$post->getTopic()|strip_tags|utf8_truncate:15}</a><br />
            photo =
            {assign var="hasPreview" value=0}
            {assign var=postResources value=$post->getArticleResources()}
            {if $postResources}
                {foreach from=$postResources item=postResource}
                    {if $postResource->hasPreview()}
                        {if $hasPreview!=1}<img src="{$request->resourcePreviewLink($postResource)}" width="60" height="60" onError="this.width=60;this.height=60;this.src='{$url->getUrl('/imgs/file-no-find.png')}'" />{/if}
                        {assign var="hasPreview" value=1}
                    {/if}
                {/foreach}
            {/if}
            {if $hasPreview!=1}
                {if $postOwner->hasPicture()}
                    {assign var=picture value=$postOwner->getPicture()}
                    <img src="{$picture->getPreviewLink()}" width="60" height="60" onError="this.width=60;this.height=60;this.src='{$url->getUrl('/imgs/file-no-find.png')}'" />
                {else}
                    <img src="imgs/no-user-picture.png" width="60" height="60" alt="{$postOwner->getFullName()|strip_tags}" align="left" style="border:5px solid #F5EAD4;" />
                {/if}
            {/if}
            text = {$post->getText()|strip_tags|utf8_truncate:64:"..."}
        {/if}
    {/foreach}
{/if}

最新照片
{assign var=numResources value=12}
{assign var=recentResources value=$summaryStats->getRecentResources($numResources)}
{foreach name=resources from=$recentResources item=resource}
    {assign var="blogInfo" value=$resource->getBlogInfo()}
    {assign var="url" value=$blogInfo->getBlogRequestGenerator()}
    resourceMediumSizePreviewLink = <img src="{$url->resourceMediumSizePreviewLink($resource)}" />
    resourceSmallSizePreviewLink =  <img src="{$url->resourceSmallSizePreviewLink($resource)}" />
    resourcePreviewLink =           <img src="{$url->resourcePreviewLink($resource)}" />
    resourceSquareSizePreviewLink = <img src="{$url->resourceSquareSizePreviewLink($resource)}" />
    <br />
{/foreach}

熱門網誌 + 每個網誌的最新文章
{foreach name=blog from=$activeBlogs item=post}
    {assign var="url" value=$blog->getBlogRequestGenerator()}
    {assign var="postOwner" value=$blog->getOwnerInfo()}
    {assign var="post" value=$blog->getRecentArticles()}
    <a href="{$url->blogLink($blog)}">
    {if $postOwner->hasPicture()}
        {assign var=picture value=$postOwner->getPicture()}
        <img src="{$picture->getPreviewLink()}" style="width:60px;height:60px;border:0px;" onError="this.width=60;this.height=60;this.src='{$url->getUrl("/imgs/no-user-picture.jpg")}'" />
    {else}
        <img src="{$url->getUrl("/imgs/no-user-picture.jpg")}" style="width:60px;height:60px;border:0px;" alt="{$postOwner->getFullName()|strip_tags}" />
    {/if}
    </a>
    <br />{$postOwner->getFullName()}
    <br /><a href="{$url->blogLink($blog)}">{$post[0]->getTopic()|strip_tags|utf8_truncate:15:""}</a>
    <br />{$post[0]->getText()|strip_tags|utf8_truncate:15:""}
{/foreach}



{/literal}
