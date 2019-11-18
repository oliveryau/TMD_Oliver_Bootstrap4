<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="ProfileUpdate.aspx.cs" Inherits="targeted_marketing_display.ProfileUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #ContentPlaceHolder1_btnBack, #ContentPlaceHolder1_btnBackPswd, #ContentPlaceHolder1_btnUpdate, #ContentPlaceHolder1_btnPswd {
            width: 140px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Update Profile</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12"> 
                <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" onclick="btnBack_Click" causesValidation="false"/>
                <asp:Button ID="btnBackPswd" class="btn btn-primary float-left" runat="server" Text="Back" onclick="btnBack_Click2" causesValidation="false"/>
            <%--</div>--%>

            <%--<div class="col-6">--%>
                <asp:Button ID="btnUpdate" class="btn btn-primary float-right" runat="server" Text="Update" onclick="btnUpdate_Click"/>
            </div>
        </div> 

        <br />

        <!-- for some reason no need row -->
        <div runat="server" class="col-12 alert alert-danger" id="alertDanger" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Error!</strong> Current password is incorrect
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div runat="server" class="col-12 alert alert-danger" id="alertDangerPassword" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Error!</strong> New password does not match
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div runat="server" class="col-12 alert alert-success" id="alertSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Success!</strong> Profile has been updated
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <!-- for some reason no need row -->

        <div class="row">
            <div class="col-12 col-md-6" runat="server" id="unrelatedshit1">
                <div class="form-group">
                    <label>Name: </label>
                    <label style="color: red">*</label>
                <asp:TextBox class="form-control" ID="tbName" placeholder="Enter Name" runat="server"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbName" Display="Dynamic" ErrorMessage="Please enter name" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="tbName" Display="Dynamic" ErrorMessage="Please enter a valid name" ValidationExpression="^[a-zA-Z\s]+$" ForeColor="Red"></asp:RegularExpressionValidator>                        
                </div>
            </div>

            <div class="col-12 col-md-6" runat="server" id="unrelatedshit2">
                <div class="form-group">
                    <label>Contact Number: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbContact" placeholder="Enter Contact No." runat="server"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvConNo" runat="server" ControlToValidate="tbContact" Display="Dynamic" ErrorMessage="Please enter contact number" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revConNo" runat="server" ControlToValidate="tbContact" Display="Dynamic" ErrorMessage="Please enter a valid contact number (8 digit starting with the number 8/9)" ValidationExpression="^[89]\d{7}$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnPswd" class="btn btn-primary float-right" runat="server" Text="Change Password" onclick="btnPswd_Click" causesValidation="false"/>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6" runat="server" id="divCurrentPassword" visible="false">
                <div class="form-group">
                    <label>Current Password: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="CurrentPassword" placeholder="Enter Password" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvCurrPswd" runat="server" ControlToValidate="CurrentPassword" Display="Dynamic" ErrorMessage="Please enter current password" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCurrPswd" runat="server" ControlToValidate="CurrentPassword" Display="Dynamic" ErrorMessage="Please enter a valid password" ValidationExpression="^.{8,12}$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6" runat="server" id="divPswd" visible="false">
                <div class="form-group">
                    <label>New Password: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbPswd" placeholder="Enter Password" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvPswd" runat="server" ControlToValidate="tbPswd" Display="Dynamic" ErrorMessage="Please enter new password" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPswd" runat="server" ControlToValidate="tbPswd" Display="Dynamic" ErrorMessage="Please enter a password with length of between 8-12 characters" ValidationExpression="^.{8,12}$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="col-12 col-md-6" runat="server" id="divCPswd" Visible="false">
                <div class="form-group">
                    <label>Confirm New Password: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbCPswd" placeholder="Confirm Password" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvCpswd" runat="server" ControlToValidate="tbCPswd" Display="Dynamic" ErrorMessage="Please confirm new password" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
