<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="UserCreate.aspx.cs" Inherits="targeted_marketing_display.UserCreate" EnableViewState="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        @media only screen and (max-width: 767px) {
            #ContentPlaceHolder1_btnBack, #ContentPlaceHolder1_btnCreate {
                width: 140px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">New User</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" onclick="btnBack_User" causesValidation="false"/>

                <asp:Button ID="btnCreate" class="btn btn-primary float-right" runat="server" Text="Create" OnClick="btnCreate_User" />
            </div>
        </div>

            <div runat="server" class="alert alert-success" id="alertSuccess" visible="False">
                <strong>Success!</strong> 
                <asp:Label runat="server" ID="msgSuccess"></asp:Label>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        
            <div runat="server" class="alert alert-danger" id="alertWarning" visible="False">
                <strong>Warning!</strong>
                <asp:Label ID="msgWarning" runat="server"></asp:Label>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

        <br />

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>User Type: </label>
                    <label style="color: red">*</label>
                    <asp:DropDownList Class="form-control" ID="ddlUserType" runat="server" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="ddlUserType" Display="Dynamic" InitialValue="0" ErrorMessage="Please select user type" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Name: </label>
                    <label style="color: red">*</label>
                    &nbsp;
                    <asp:TextBox class="form-control" ID="tbName" placeholder="Enter name" runat="server"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbName" Display="Dynamic" ErrorMessage="Please enter name" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="tbName" Display="Dynamic" ErrorMessage="Please enter a valid name" ValidationExpression="^[a-zA-Z\s]+$" ForeColor="Red"></asp:RegularExpressionValidator>                                            
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>E-mail: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbEmail" placeholder="Enter email" runat="server"></asp:TextBox>
                    &nbsp;
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbEmail" Display="Dynamic" ErrorMessage="Please enter email" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="tbEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Contact Number: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbConNo" placeholder="Enter contact no." runat="server"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvConNo" runat="server" ControlToValidate="tbConNo" Display="Dynamic" ErrorMessage="Please enter contact number" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revConNo" runat="server" ControlToValidate="tbConNo" Display="Dynamic" ErrorMessage="Please enter a valid contact number (8-digits starting with the number 8/9)" ValidationExpression="^[89]\d{7}$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div runat="server" class="col-12 col-md-6" id="nUser" visible="false">
                    <div class="form-group">
                        <label>Company: </label>
                        <label style="color: red">*</label>
                        <asp:DropDownList Class="form-control" ID="ddlCompany" runat="server" >
                        </asp:DropDownList>&nbsp;
                        <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCompany" Display="Dynamic" InitialValue="0" ErrorMessage="Please select company" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
            </div>
        </div>
    </form>
</asp:Content>
