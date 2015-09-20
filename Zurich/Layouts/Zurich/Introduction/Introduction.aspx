<%@ Assembly Name="Zurich, Version=1.0.0.0, Culture=neutral, PublicKeyToken=797937017bf20c2c" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Introduction.aspx.cs" Inherits="Zurich.Layouts.Zurich.Introduction.Introduction"%>
<head id="Head1" runat="server">

<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/js/Scripts/css/stylesprinkle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/Zurichstyle.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/style.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAMenu.css" />
<link rel="stylesheet" type="text/css" href="/_layouts/Zurich/styles/FNAStyles/utility.css" />

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-1.4.1.min.js"></script>
 
<link rel="stylesheet" href="/_layouts/Zurich/styles/js/Scripts/themes/default/default.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/js/Scripts/themes/pascal/pascal.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/js/Scripts/themes/orman/orman.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/_layouts/Zurich/styles/js/Scripts/css/nivo-slider.css" type="text/css" media="screen" />

<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/_layouts/Zurich/styles/js/Scripts/jquery.nivo.slider.pack.js"></script>
<script type="text/javascript">
    
    $(window).load(function () {
        $('#slider').nivoSlider();
    });

</script>

</head>

<body>
  <form id="form1" runat="server">

<div id="chassis_outer_container">
<div class="chassis_page_container">
<div class="chassis_application_pane">
<div id="chassis_application_content" class="chassis_application_body">

<div id="wrapper">
    <div class="slider-wrapper theme-default">
        <div class="ribbon"></div>
        <div id="slider" class="nivoSlider">
            <img src="/_layouts/Zurich/images/Content/1st_Page.jpg" alt="" />
            <img src="/_layouts/Zurich/images/Content/2nd_Page.jpg" alt="" data-transition="slideInLeft" />
            <img src="/_layouts/Zurich/images/Content/3rd_Page.jpg" alt="" data-transition="slideInLeft" />
        </div>
    </div>
    <table width="100%">
        <tr>
            <td width="100%" align = "right">                   
                <input type="button" id="btnBackToCasePortal" class="chassis_application_button_xxxlarge" value="Back To Case Portal" onclick="javascript:window.close();" />
            </td>
        </tr>
    </table>
</div> 
</div>
</div>
</div>
</div>
 </form>
</body>