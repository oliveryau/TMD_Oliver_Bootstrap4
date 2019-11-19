<%@ Page Language="C#"  MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="AdvertInfo.aspx.cs" Inherits="targeted_marketing_display.AdvertInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #imgLogo {
            float: left;
        }
        #videoThumbnail {
            float:left;
        }
        .GridViewEditRow input[type=text] {
            width: 90px;
        }
        /* size textboxes */
        .GridViewEditRow select {
            width: 90px;
        }
        /* size drop down lists */
        .hiddencol {
            display: none;
        }
        #videoThumbnail {
            object-fit: cover;
        }
        #vidDiv{
       
        }
        #divText{
            overflow:auto;
        }
        div.a {
            border: 1px solid black;
        }

        #imgLogo{
            object-fit: cover;
        }

        @media only screen and (max-width: 768px) {
            #mainInfo {
                padding-top: 20px;
            }
        }

        #ContentPlaceHolder1_btnBack {
            width: 140px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
    <script>
     
    </script>
          <!--button-->
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Advertisement Information
                     <asp:label id="AdNameLabel" runat="server"></asp:label>
                </h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnBack" class="btn btn-primary nextBtn pull-left" runat="server" Text="Back" onclick="btnBack_Advert" causesValidation="false"/>
            </div>
        </div>
        <br />

        <div class="row">
            <div class="col-12">
                
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-12 col-md-6">
                <asp:image id="imgLogo" runat="server" imageurl="" style="width:100%; height:100%" ClientIDMode="Static"></asp:image>

                <div id="vidDiv" runat="server">
                    <video clientidmode="static" id="videoThumbnail" style="width:100%; height:100%" runat="server" visible="true" controls class="img-fluid" alt="">
                        <source id="vidSource" runat="server" src="" type="video/mp4">
                    </video>
                </div>
            </div>
            <br />
            <div class="col-12 col-md-6">
                <div id="mainInfo" style="border: 1px solid black">
                    <p> 
                        <asp:label id="CompanyNameLabel" runat="server" font-bold="true" class="card-title pl-2" text="Company:" />
                        <asp:literal runat="server" id="CompanyNameLiteral"></asp:literal>
                
                        <br />

                        <asp:label id="AdName2" runat="server" font-bold="true" text="Advertisement Name:" class="card-title pl-2" />
                        <asp:literal runat="server" id="AdNameLiteral"></asp:literal>
                   
                        <br />

                        <asp:label id="ItemTypeLabel" runat="server" font-bold="true" text="File Type:" class="card-title pl-2" />
                        <asp:literal runat="server" id="ItemTypeLiteral"></asp:literal>
                    
                        <br />

                        <asp:label id="StartDateLabel" runat="server" text="Start Date:" font-bold="true" class="card-title pl-2" />
                        <asp:literal runat="server" id="StartDateLiteral"></asp:literal>
                  
                        <br />
        
                        <asp:label id="EndDateLabel" runat="server" text="End Date:" font-bold="true" class="card-title pl-2" />
                        <asp:literal runat="server" id="EndDateLiteral"></asp:literal>
                       
                        <br />

                        <asp:label id="AudienceLabel" runat="server" text="Targeted Audience(s):" font-bold="true" class="pl-2" />
                        <ul runat="server" id="AudienceList"></ul>
                      
                        <br /> 

                        <asp:label id="CategoryLabel" runat="server" text="Advertisement Category(s):" font-bold="true" class="card-title pl-2" />
                        <ul runat="server" id="CategoryList"></ul>
                 
                        <br />
         
                        <asp:label id="LocationLabel" runat="server" text="Connected Billboard(s):" font-bold="true" class="card-title pl-2" />
                        <ul runat="server" id="BBCodeList"></ul>
                    </p>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <h6 id="footer" class="float-right">Targeted Marketing Display &#169;</h6>
            </div>
        </div>
    </form>
</asp:Content>
