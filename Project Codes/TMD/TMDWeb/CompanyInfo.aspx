<%@ Page Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="CompanyInfo.aspx.cs" Inherits="targeted_marketing_display.CompanyInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        #divImage
        {
            display: none;
            z-index: 1000;
            position: fixed;
            top: 0;
            left: 0;
            background-color: White;
            height: 550px;
            width: 600px;
            padding: 3px;
            border: solid 1px black;
        }
        #videoDog{
            object-fit: cover;
        }
        #vidDiv{

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

        #ContentPlaceHolder1_btnBack {
            width: 140px;
        }

        @media only screen and (max-width: 820px) {
            .HideInMobile {
                display: none;
            }
        }
    </style>

    <form runat="server">        
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Company Advertisements <asp:label runat="server" id="company_name_label"></asp:label></h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnBack" class="btn btn-primary float-left" runat="server" Text="Back" onclick="btnBack_User"/>
            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-12">
                <asp:label runat="server" id="labelIndustry" Font-Bold="true" text="Industry: " /><asp:literal runat="server" id="industrytext"></asp:literal>
                <br />
                <asp:label runat="server" id="rowCountLabel"  Font-Bold="true" text="Total: " /><asp:literal runat="server" id="counttext"></asp:literal>
                <asp:label runat="server" id="ErrorHandler" visible="false"></asp:label>
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
                    <div style="float: left;">
                        <p class="input-group">
                            <asp:TextBox ID="txtSearch" class="form-control" runat="server" placeholder="Search..." ClientIDMode="static"></asp:TextBox>
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

        <asp:GridView ID="GridView1" SortedAscendingHeaderStyle-CssClass="ascending" SortedDescendingHeaderStyle-CssClass="descending" runat="server" CssClass="table table-striped table-bordered table-hover"   CellPadding ="3" ForeColor="Black" 
            GridLines="Vertical" Height="100%" Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnPreRender="GridView1_PreRender" AllowPaging="True"
            AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
            BorderStyle="Solid" BorderWidth="1px" PageSize="3" AllowSorting="True"  OnSorting="GridView1_Sorting" CurrentSortDirection="ASC" CurrentSortField="StartDate" OnRowCreated="GridView1_RowCreated"  >
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:TemplateField HeaderText="Advertisement">
                    <ItemTemplate>                                
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Item") %>' OnClientClick="return LoadDiv(this.src);" Visible='<%# Eval("ItemType").ToString() =="image" %>'
                            style="display:block; object-fit: cover;" />
                        <div id="vidDiv" runat="server">
                        <video ClientIDMode="static" id="videoDog" width="200" height="200" runat="server" controls visible='<%# Eval("ItemType").ToString()!="image" %>'>  
                            <source runat="server" src='<%#Eval("Item")%>' type="video/mp4" visible='<%# Eval("ItemType").ToString()!="image" %>' />  
                        </video>  
                        </div>
                    </ItemTemplate>
                    <controlstyle width="200px" height="200px"  />
                    <ItemStyle Width="200px" height="200px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Company" visible="false" HeaderText="Company Name" SortExpression="Company"></asp:BoundField>            
                <asp:BoundField DataField="adname" HeaderText="Name" SortExpression="adname"></asp:BoundField>
                <asp:BoundField DataField="ItemType" HeaderText="Type" SortExpression="ItemType" ItemStyle-CssClass="HideInMobile" HeaderStyle-CssClass="HideInMobile"></asp:BoundField>
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" SortExpression="StartDate" DataFormatString="{0:D}" ItemStyle-CssClass="HideInMobile" HeaderStyle-CssClass="HideInMobile"></asp:BoundField>
                <asp:BoundField DataField="EndDate" HeaderText="End Date" SortExpression="EndDate" DataFormatString="{0:D}" ItemStyle-CssClass="HideInMobile" HeaderStyle-CssClass="HideInMobile"></asp:BoundField>
            </Columns>
            <EditRowStyle HorizontalAlign="Center" CssClass="GridViewEditRow" />
            <EmptyDataRowStyle HorizontalAlign="Center" />
            <FooterStyle BackColor="#CCCCCC" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#999999" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
            <PagerStyle BackColor="#999999"  ForeColor="Black" HorizontalAlign="left"  />
            <RowStyle Height="20px" Width="30px" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" HorizontalAlign="Center" />
            <SortedAscendingHeaderStyle BackColor="#808080" HorizontalAlign="Center" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" HorizontalAlign="Center" />
            <SortedDescendingHeaderStyle BackColor="#383838" HorizontalAlign="Center" />
        </asp:GridView>
        <!-- <asp:Label ID="LabelPaging" style="color:darkslateblue" runat="server" Text="Label" Font-Bold="true"></asp:Label> -->
    </form>
</asp:Content>
