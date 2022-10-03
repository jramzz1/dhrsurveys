<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Thanks.aspx.cs" Inherits="DHRSurveys.Thanks.Thanks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DHRSurvey</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <link href="~/stylesheets/homepage.css" media="screen" rel="stylesheet" type="text/css"/>
</head>
<body class="page bg">
    <header class="masthead text-white text-center" style="padding-top: 20%;">
        <div class="container d-flex align-items-center flex-column" style="padding-bottom: 5%;">
            <img class="masthead-avatar mb-3" src="https://i.imgur.com/zttpaZw.png"/>
            <h1 class="masthead-heading text-uppercase mb-0">Thank You</h1>
            <h6 class="info"> We appreciate your time in taking this brief survey, have a wonderful day!</h6>
            <h8><a href="https://dhrhealth.com" style="color: white; ">DhrHealth Homepage</a></h8>
        </div>
        <a href="https://github.com/yezzermz/dhrsurveys"><img src="https://i.imgur.com/vNkjJV8.png" style="width:42px;height:42px;" /></a>
        <form  id="db_Run" runat="server">
            <asp:LinkButton ID="db_Click" runat="server" OnClick="db_Click_Click">Database</asp:LinkButton>
        </form>
    </header>
</body>
</html>
