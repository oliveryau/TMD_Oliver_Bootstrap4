<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="FAQ.aspx.cs" Inherits="targeted_marketing_display.FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #ContentPlaceHolder1_buttonMoreQuestions {
            width: 140px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form runat="server">
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Frequently Asked Questions</h1>
            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-12">
                <asp:LinkButton ID="buttonMoreQuestions" class="btn btn-primary float-right" runat="server" Text="More Enquiries" href="mailto:tmdboss2019@gmail.com?Subject=More%20Enquiries%20about%20Targeted%20Marketing%20Display"/>
            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-12 col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong>Q:</strong> How do I create my own advertisement?
                       
                    </div>
                    <div class="panel-body">
                        <p>Head over to our Advertisements Page and click on the "New Advertisement" button!</p>
                    </div>
                       
                </div>
            </div>

            <div class="col-12 col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong>Q:</strong> When will I get the analysis for my advertisement back?
                       
                    </div>
                    <div class="panel-body">
                        <p> You'll receive it when we have enough feedbacks from your targeted audience!</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                            <strong>Q:</strong> How do I know where billboards are placed? 
                       
                    </div>
                    <div class="panel-body">
                        <p>Information on the locations are available on the Billboards page.</p>
                    </div>
                    
                </div>
            </div>
        </div>
        <!--/pagewrapper-->
    </form>
</asp:Content>
