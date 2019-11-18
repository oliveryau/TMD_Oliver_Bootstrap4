<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="UserUpdate.aspx.cs" Inherits="targeted_marketing_display.UserUpdate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #ContentPlaceHolder1_btnBack, #ContentPlaceHolder1_btnUpdate {
            width: 140px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Update User</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" OnClick="btnBack_Click" causesValidation="false"/>

                <asp:Button ID="btnUpdate" class="btn btn-primary float-right" runat="server" Text="Update" OnClick="btnUpdate_Click"/>
            </div>
        </div>

        <br />

        <div runat="server" class="alert alert-success" id="alertSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Success!</strong> 
            <asp:Label runat="server" ID="msgSuccess"></asp:Label>
            <button type="button" class="close" onclick="window.location.href='UserList.aspx';">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Name: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbName" placeholder="Enter name" runat="server"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbName" Display="Dynamic" ErrorMessage="Please enter name" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="tbName" Display="Dynamic" ErrorMessage="Please enter a valid name" ValidationExpression="^[a-zA-Z\s]+$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Contact Number: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="tbContact" placeholder="Enter contact no." runat="server"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="rfvConNo" runat="server" ControlToValidate="tbContact" Display="Dynamic" ErrorMessage="Please enter contact number" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revConNo" runat="server" ControlToValidate="tbContact" Display="Dynamic" ErrorMessage="Please enter a valid contact number (8-digits starting with the number 8/9)" ValidationExpression="^[89]\d{7}$" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
    </form>
</asp:Content>