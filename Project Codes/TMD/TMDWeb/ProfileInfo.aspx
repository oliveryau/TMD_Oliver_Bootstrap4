<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="ProfileInfo.aspx.cs" Inherits="targeted_marketing_display.ProfileInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #ContentPlaceHolder1_buttonEdit1, #ContentPlaceHolder1_buttonEdit2 {
            width: 140px;
        }
        
        #ContentPlaceHolder1_lbAdminEmail, #ContentPlaceHolder1_lbEmail {
            word-wrap: break-word;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <div runat="server" id="UserView" visible="false">
            <div class="row">
                <div class="col-12">
                    <h1 class="page-header">My Profile</h1>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <asp:Button ID="buttonEdit1" class="btn btn-primary float-right" runat="server" Text="Edit" onclick="btnEdit_Click"/>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Name: </label>
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
                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>User Type: </label>
                        <asp:Label runat="server" ID="lbUserType"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Contact Number: </label>
                        <asp:Label runat="server" ID="lbContact"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Status: </label>
                        <asp:Label runat="server" ID="lbStatus"></asp:Label>&nbsp;
                    </div>
                </div>
            </div>
        </div>

        <div runat="server" id="AdminView" visible="false">
            <div class="row">
                <div class="col-12">
                    <h1 class="page-header">My Profile</h1>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <asp:Button ID="buttonEdit2" class="btn btn-primary float-right" runat="server" Text="Edit" onclick="btnEdit_Click"/>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Name: </label>
                        <asp:Label runat="server" ID="lbAdminName"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>E-mail: </label>
                        <asp:Label runat="server" ID="lbAdminEmail"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Status: </label>
                        <asp:Label runat="server" ID="lbAdminStatus"></asp:Label>&nbsp;
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>User Type: </label>
                        <asp:Label runat="server" ID="lbAdminType"></asp:Label>&nbsp;
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="form-group">
                        <label>Contact Number: </label>
                        <asp:Label runat="server" ID="lbAdminContact"></asp:Label>&nbsp;
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>