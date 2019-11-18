<%@ Page Language="C#" AutoEventWireup="true" codeFile="login.aspx.cs" Inherits="targeted_marketing_display.login" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <title>Targeted Marketing Display</title>
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style>
        body {
            background-attachment:fixed;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            background-size:100%;
            background-size: cover;
            font-family: sans-serif;  
        }

        .login-box {
            width: 300px;
            height: 500px;
            top: 50%;
            left: 50%;
            position: absolute;
            transform: translate(-50%,-50%);
            background-color: #BFB7B6;
            padding: 30px;
            border-radius:20px;
        }

        .login-box h1 {
            float:left;
            font-size:25px;
            text-align: center;
            border-bottom:3px solid #DCF763;
            padding:12px 0;
            margin-top:5px;
            color: #435058;
        }

        .login-box h2 {
            color: #435058;
            font-size:20px;
            text-align: center;
            padding:12px 0;
            margin-top:0px;
            margin-bottom:20px;
        }

        .textbox {
            width:100%;
            overflow:hidden;
            font-size:20px;
            padding:8px 0;
            margin:8px 0;
            border-bottom:3px solid #DCF763;
        }

        .textbox i {
            width:26px;
            float:left;
            text-align:center;
        }

        .textbox input {
            background:white;
            font-size:18px;
            width:100%;
            float:left;
        }

        .btn {
            width:100%;
            background:#DCF763;
            border:2px solid #DCF763;
            color:black;
            padding:5px;
            font-size:18px;
            cursor:pointer;
            margin:12px 0;
            border-radius:5px;
        }

        .rfv {
            padding-left: 15px;
            font-size:17px;
        }

        .modal-backdrop {
            background-color: rgba(169,169,169,0.6);
        }
        </style> 
     
    <!-- <script type="text/JavaScript">
        alert('hello world');
    </script> -->
</head>
    <body style="background-image: url('Images/billboard.gif');">
    <form id="form2" runat="server">
    <div class="login-box">
        <h1>Targeted Marketing Display</h1>
        <div class="textbox">
            <i class="fa fa-user" aria-hidden="true"></i>
            <h2>Login Page</h2>
            <asp:TextBox class="form-control" ID="unTB" placeholder="Enter email" runat="server"></asp:TextBox><br />
            <asp:RequiredFieldValidator ID="loginIdEmail" runat="server" ControlToValidate="unTB" ValidationGroup="loginInfo" CssClass="rfv" Display="Dynamic" ErrorMessage="Please enter your email" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="unTB" ValidationGroup="loginInfo" CssClass="rfv" Display="Dynamic" ErrorMessage="Please enter a valid email" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ForeColor="Red"></asp:RegularExpressionValidator>            
        </div>
        <div class="textbox"> 
            <i class="fa fa-lock" aria-hidden="true"></i>
            <asp:TextBox class="form-control" ID="pwTB" placeholder="Enter password" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="loginPw" runat="server" ControlToValidate="pwTB" ValidationGroup="loginInfo" CssClass="rfv" Display="Dynamic" ErrorMessage="Please enter your password" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        

        <asp:Button ID="loginBtn" class="btn btn-primary nextBtn" runat="server" Text="Login" OnClick="login_onclick" ValidationGroup="loginInfo" style="text-align:center; color: #435058;background-color: #dcf763;border-color: #dcf763;" />
    
        <br />

        <p><span style="color: #435058;">Forgot your password? </span><a data-toggle="modal" data-target="#forgotModal" style="cursor:pointer; color:#4c4cff;">Click here</a></p>
    </div>

    <div class="etc-login">
        <div class="modal" id="forgotModal" role="dialog">
            <div class="modal-dialog" role="form">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #BFB7B6;">
                        <h4 class="modal-title" style="color: #435058;">Forgot your password?</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body" style="background-color: #BFB7B6;">
                        <asp:TextBox class="form-control" ID="fpEmail" placeholder="Enter email" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="forgotPwId" runat="server" ControlToValidate="fpEmail" ValidationGroup="fpInfo" CssClass="rfv" Display="Dynamic" ErrorMessage="Please enter your email" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revFpEmail" runat="server" ControlToValidate="fpEmail" ValidationGroup="fpInfo" CssClass="rfv" Display="Dynamic" ErrorMessage="Please enter a valid email" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ForeColor="Red"></asp:RegularExpressionValidator>
                    </div>
                    <div class="modal-footer" style="background-color: #BFB7B6;">
                        <asp:Button ID="fpBtn" class="btn btn-primary col-3 ml-auto" runat="server" Text="Submit" OnClick="fp_onclick" ValidationGroup="fpInfo" style="color: #435058;"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>        
    </body>
</html>
