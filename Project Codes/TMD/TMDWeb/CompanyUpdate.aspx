﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="CompanyUpdate.aspx.cs" Inherits="targeted_marketing_display.CompanyUpdate" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
       #ContentPlaceHolder1_btnBack, #ContentPlaceHolder1_updateBtn {
           width: 140px;
       }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Update Company</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" OnClick="btnBack_Click" causesValidation="false" />

                <asp:Button ID="updateBtn" class="btn btn-primary float-right" runat="server" Text="Update" OnClick="updateBtn_Click" />
            </div>
        </div>

        <div runat="server" class="alert alert-success" id="alertSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Success!</strong> Company information has been updated.
        </div>
               
        <div runat="server" class="alert alert-danger" id="alertWarning" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Warning!</strong> Update unsuccessful.
        </div>

        <br />

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Company Name: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="CoName" placeholder="Enter company name" runat="server" MaxLength="255"></asp:TextBox> &nbsp;
                    <asp:RequiredFieldValidator ID="rfvCoName" runat="server" ControlToValidate="CoName" Display="Dynamic" ErrorMessage="Please enter company name" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Industry: </label>
                    <label style="color: red">*</label>
                    <asp:DropDownList Class="form-control" ID="CoIndustry" runat="server"></asp:DropDownList>              
                    <asp:RequiredFieldValidator ID="rfvCoIndustry" runat="server" ControlToValidate="CoIndustry" Display="Dynamic" InitialValue="0" ErrorMessage="Please select company industry" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
