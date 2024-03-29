﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="UserInfo.aspx.cs" Inherits="targeted_marketing_display.UserInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #ContentPlaceHolder1_btnBack {
            width: 140px;
        }

        #ContentPlaceHolder1_lbEmail {
            word-wrap: break-word;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
            <div class="row">
                <div class="col-12">
                    <h1 class="page-header">User Information </h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-12">
                    <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" onclick="btnBack_User" causesValidation="false"/>
                </div>
            </div>

            <br />

            <div class="row">
                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Name: </label>
                        <!-- &nbsp; -->
                        <asp:Label runat="server" ID="lbName"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>E-mail: </label>
                        <asp:Label runat="server" ID="lbEmail"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Company: </label>
                        <asp:Label runat="server" ID="lbCompany"></asp:Label>&nbsp;
                    </div>
                </div>
            </div>


            <div class="row">
                <div class=" col-12 col-md-4">
                    <div class="form-group">
                        <label>User Type: </label>
                        <asp:Label runat="server" ID="lbUserType"></asp:Label>&nbsp;

                    </div>
                </div>

                <div class=" col-12 col-md-4">
                    <div class="form-group">
                        <label>Contact Number: </label>
                        <asp:Label runat="server" ID="lbContact"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class=" col-12 col-md-4">
                    <div class="form-group">
                        <label>Status: </label>
                        <asp:Label runat="server" ID="lbStatus"></asp:Label>&nbsp;
                    </div>
                </div>
            </div>
    </form>
</asp:Content>
