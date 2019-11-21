<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="AdvertList.aspx.cs" Inherits="targeted_marketing_display.AdvertList" EnableEventValidation="false" %>
<%--NOTE:I put event validation=false because i manipulate the side menu with javascript and if i dont include it,it will show error.It compromises security though--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
    </style>
    <style type="text/css">
        #Image1 {
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        #Image1:hover {
            opacity: 0.7;
        }
        body {
            margin: 0;
            padding: 0;
            height: 100%;
        }

        .modal {
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            background-color: black;
            z-index: 100;
            opacity: 0.8;
            filter: alpha(opacity=60);
            -moz-opacity: 0.8;
            min-height: 100%;
        }

        #divImage {
            display: none;
            z-index: 1000;
            position: fixed;
            top: 0;
            left: 0;
            background-color: White;
            height: 600px;
            width: 600px;
            padding: 0px;
            border: solid 1px black;
            margin-top:150px;
        }

        #videoDog {
             object-fit: cover;
             width: 100px;
             height: 100px;
        }
        #vidDiv {

        }
        .ascending a{
            background:url(webicons/Ascendingicon.png) right no-repeat;
            display:block;
            padding:0 25px 0 5px;
        }
        .descending a{
            background:url(webicons/Descendingicon.png) right no-repeat;
            display:block;
            padding:0 25px 0 5px;
        }
        #imageCloser {
            position: absolute;
            top: 0px;
            right: 0px;
            color: darkslateblue;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
            opacity:1;
        }
        #imageCloser:hover, #imageCloser:focus {
            color: #bbb;
            text-decoration: none;
            cursor: pointer;
        }

        #ContentPlaceHolder1_btnNewAdv {
            width: 140px;
            padding-left: 8px;
        }

        @media only screen and (max-width: 1100px) {
            .HideInMobile {
                display: none;
            }

            .FileSize {
                max-height: 80px;
                max-width: 80px;
            }
            .HeaderSize {
                max-width: 80px;
            }
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<form runat="server">
<script>
    function deleteFunction() {

        if (!confirm('Confirm Deletion of Advertisement')) {

            return false;
        }

        else {
            return true;
        }
    }
</script>
<script type="text/javascript">
    function LoadDiv(url) {
    var img = new Image();
    var bcgDiv = document.getElementById("divBackground");
    var imgDiv = document.getElementById("divImage");
    var imgFull = document.getElementById("imgFull");
    var imgLoader = document.getElementById("imgLoader");
    imgLoader.style.display = "block";
    img.onload = function () {
        imgFull.src = img.src;
        imgFull.style.display = "block";
        imgLoader.style.display = "none";
   };
    img.src = url;
    var width = document.body.clientWidth;
    if (document.body.clientHeight > document.body.scrollHeight) {
        bcgDiv.style.height = document.body.clientHeight + "px";
    }
    else {
        bcgDiv.style.height = document.body.scrollHeight + "px";
    }
    imgDiv.style.left = (width - 650) / 2 + "px";
    imgDiv.style.top = "20px";
    bcgDiv.style.width = "100%";
 
    bcgDiv.style.display = "block";
    imgDiv.style.display = "block";
        //if not admin
        if ('<%=adminint %>'==0) {
            <%--document.getElementById('<%=Master.FindControl("stupidDiv").ClientID %>').style.opacity = "0.3";

            document.getElementById('<%=Master.FindControl("stupidDiv").ClientID %>').style.pointerEvents = "None";--%>
            document.getElementById('<%=Master.FindControl("stupidNav").ClientID %>').style.pointerEvents = "None";
        }
        //if admin
        else {
            <%--document.getElementById('<%=Master.FindControl("cancerDiv").ClientID %>').style.opacity = "0.3";
      
            document.getElementById('<%=Master.FindControl("cancerDiv").ClientID %>').style.pointerEvents="None";--%>
            document.getElementById('<%=Master.FindControl("cancerNav").ClientID %>').style.pointerEvents = "None";
        }
    return false;
    }

    function HideDiv() {
        var bcgDiv = document.getElementById("divBackground");
        var imgDiv = document.getElementById("divImage");
        var imgFull = document.getElementById("imgFull");

        if (bcgDiv != null) {
            bcgDiv.style.display = "none";
            imgDiv.style.display = "none";
            imgFull.style.display = "none";
        }
        //if not admin
        if ('<%=adminint %>' == 0) {
            <%--document.getElementById('<%=Master.FindControl("stupidDiv").ClientID %>').style.opacity = "1";
            document.getElementById('<%=Master.FindControl("stupidDiv").ClientID %>').style.pointerEvents = "auto";--%>
            document.getElementById('<%=Master.FindControl("stupidNav").ClientID %>').style.pointerEvents = "auto";
        }
        //if admin
          else {
            <%--document.getElementById('<%=Master.FindControl("cancerDiv").ClientID %>').style.opacity = "1";
            document.getElementById('<%=Master.FindControl("cancerDiv").ClientID %>').style.pointerEvents = "auto";--%>
            document.getElementById('<%=Master.FindControl("cancerNav").ClientID %>').style.pointerEvents = "auto";
        }   
    }
</script>
    <asp:ScriptManager id="script1" runat="server"></asp:ScriptManager>
     
    <div class="row">
        <div class="col-12">
            <h1 class="page-header">Advertisements</h1>
        </div>
    </div>        
       
    <div class="row">
        <div class="col-12">
            <asp:Button ID="btnNewAdv" class="btn btn-primary float-right" runat="server" Text="New Advertisement" OnClick="btnNew_Advert" />
        </div>
    </div>

    <br />

    <div id="demo" class="collapse">
        <div class="row">
            <div class="col-12 col-sm-3">
                <div class="form-group">
                    <label>Start Date:</label>
                    <asp:TextBox Class="form-control" ID="startDateTB" runat="server" TextMode="Date" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                </div>
            </div>

            <div class="col-12 col-sm-3">
                <div class="form-group">
                    <label>End Date: </label>
                    <asp:TextBox class="form-control" ID="endDateTB" runat="server" TextMode="Date" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>&nbsp;
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="startDateTB" ControlToValidate="endDateTB" ErrorMessage="Invalid end date" Operator="GreaterThan" Type="Date" ForeColor="Red"></asp:CompareValidator>
                </div>
            </div>
        </div>
    </div>
                         
    <div class="row">
        <div class="col-12">
            <div class="input-group custom-search-form">
                <div style="float: left">
                    <p class="input-group">
                    <asp:TextBox ID="txtSearch" class="form-control" runat="server" placeholder="Search..." AutoComplete="off"></asp:TextBox>
                    <%--<input type="submit" id="btSubmit" runat="server" />--%>
                    <span class="input-group-btn" >
                        <asp:LinkButton runat="server" class="btn btn-default" ID="btnRun" Text="<i class='fa fa-search'></i>" OnClick="btnRun_Click"/>                        
                    </span>                 
                    </p>
                </div>
            </div>
        </div>
    </div>
         
    <div class="row">
        <div class="col-12">
            <asp:Label runat="server" id="ExtraDetailsLabel" Font-Bold="true" data-toggle="collapse" data-target="#demo" style="cursor: pointer;"><u>Advanced Search</u></asp:Label>
        </div>
    </div>

    <br />

        <div id="divBackground" class="modal">
        </div>
        <div id="divImage" style="padding:0px">
            <span class="close" id="imageCloser" onclick="HideDiv()">&times;</span>
            <img id="imgLoader" alt="" src="images/loader.gif" />
            <img id="imgFull" alt="" src="" style="display: none; height:100%; width:100%; object-fit: cover;" />
        </div>

        <div runat="server" class="alert alert-success" id="alertSuccessCreate" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Successfully created advertisement!</strong> 
            <asp:Label runat="server" ID="Label2"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div runat="server" class="alert alert-success" id="alertSuccessUpdate" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Successfully updated advertisement!</strong> 
            <asp:Label runat="server" ID="msgSuccess"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div runat="server" class="alert alert-success" id="alertSuccessDelete" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Success!</strong> 
            <asp:Label runat="server" ID="Label3"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div id="all" runat="server">
            <div class="row">
                <div class="col-12">
                    <div class="table-responsive">
                        <%--<table class="table table-striped table-bordered table-hover" style="width: 100%">--%>
                        <asp:UpdatePanel id="diulei" runat="server">
                        <ContentTemplate>
                        <asp:GridView ID="GridView1" ClientIdMode="Static" SortedAscendingHeaderStyle-CssClass="ascending" SortedDescendingHeaderStyle-CssClass="descending" CssClass="table table-striped table-bordered table-hover" 
                            runat="server" AutoGenerateColumns="False" Width="100%" 
                            BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="3" AllowPaging="True" HorizontalAlign="Center" DataKeyNames="AdvID" 
                            OnPreRender="GridView1_PreRender" ForeColor="Black" GridLines="Vertical" OnRowDataBound="GridView1_RowDataBound"  cellspacing="5" PageSize="5"
                            AllowSorting="True" EnableSortingAndPagingCallbacks="true" CurrentSortField="StartDate" CurrentSortDirection="ASC"  OnSorting="GridView1_Sorting" OnRowCreated="GridView1_RowCreated" 
                            OnPageIndexChanging="GridView1_PageIndexChanging">
                            <AlternatingRowStyle HorizontalAlign="Center" BackColor="#CCCCCC" />
                            <Columns>
                                <asp:TemplateField visible="false">
                                    <ItemTemplate>
                                        <asp:Label runat="server" visible="false"  ID="lb_AdvertID" Text='<%# Bind("AdvID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                    <asp:TemplateField visible="false">
                                    <ItemTemplate>
                                        <asp:Label runat="server" visible="false"  ID="AdvertItem" Text='<%# Bind("Item") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Advertisement" HeaderStyle-CssClass="HeaderSize" ItemStyle-CssClass="FileSize" ControlStyle-CssClass="FileSize">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Item") %>' OnClientClick="return LoadDiv(this.src);" 
                                        Visible='<%# Eval("ItemType").ToString() =="image" %>' ClientIDMode="static" style="display:block; object-fit: cover;" CssClass="FileSize"/>
                                    <div id="vidDiv" runat="server">
                                    <video ClientIDMode="static" id="videoDog" runat="server" controls visible='<%# Eval("ItemType").ToString()!="image" %>' style="display:block; object-fit: cover;" class="FileSize">  
                                        <source runat="server" src='<%#Eval("Item")%>' type="video/mp4" visible='<%# Eval("ItemType").ToString()!="image" %>' />  
                                    </video>  
                                        </div>
                                              
                                    </ItemTemplate>
                                    <controlstyle width="100px" height="100px"  />
                                    <ItemStyle Width="120px" height="120px" />
                                </asp:TemplateField>

                                <asp:BoundField DataField="CompanyName" HeaderText="Company" SortExpression="CompanyName" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile"></asp:BoundField>
                                <asp:BoundField DataField="AdvertName" HeaderText="Name" SortExpression="AdvertName" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile"></asp:BoundField>
                                <asp:BoundField DataField="ItemType" HeaderText="Type" SortExpression="ItemType" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile"></asp:BoundField>
                                <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" DataFormatString="{0:D}" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile"></asp:BoundField>
                                <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" DataFormatString="{0:D}" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile"></asp:BoundField>
                                    
                                <asp:templatefield headertext="View">
                                    <itemtemplate>
                                        <asp:LinkButton ID="viewBtn" OnCommand="infoBtn_Command" runat="server" CommandName="AdInfo" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                                            <i class="fas fa-eye"></i>
                                        </asp:LinkButton>
                                    </itemtemplate>
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemStyle width="5px" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                                </asp:templatefield>

                                <asp:templatefield headertext="Update">
                                    <itemtemplate>
                                        <asp:LinkButton ID="editBtn" OnCommand="editBtn_Command" runat="server" CommandName="AdvertUpdate" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                                            <i class="fa fa-edit"></i>
                                        </asp:LinkButton>
                                    </itemtemplate>
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemStyle width="5px" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                                </asp:templatefield>
                                    
                                <asp:templatefield headertext="Delete">
                                    <itemtemplate>
                                        <asp:LinkButton ID="DeleteBtn"  OnClientClick="return deleteFunction();"  OnCommand="btnDelete_Command" runat="server" CommandName="DeleteAdMessage" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                                            <i class="fa fa-trash"></i>
                                        </asp:LinkButton>
                                    </itemtemplate>
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemStyle width="5px" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                                </asp:templatefield>
                            </Columns>
                            <EditRowStyle HorizontalAlign="Center" CssClass="GridViewEditRow" />
                            <EmptyDataRowStyle HorizontalAlign="Center" />
                            <FooterStyle BackColor="#CCCCCC" HorizontalAlign="Center" />
                            <HeaderStyle BackColor="#999999" Font-Bold="True" ForeColor="Black" HorizontalAlign="Center" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="left"  />
                            <RowStyle Height="20px" Width="30px" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" HorizontalAlign="Center" />
                            <SortedAscendingHeaderStyle BackColor="#808080" HorizontalAlign="Center" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" HorizontalAlign="Center" />
                            <SortedDescendingHeaderStyle BackColor="#383838" HorizontalAlign="Center" />
                        </asp:GridView>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        <!-- <asp:Label ID="Label1" style="color:darkslateblue" Font-Bold="true" runat="server" Text="Label"></asp:Label> -->
                        <br />
                        <br />
                    </div>
                    <!-- /.table-responsive -->
                </div>
            </div>
        </div>          
    </form>
</asp:Content>
