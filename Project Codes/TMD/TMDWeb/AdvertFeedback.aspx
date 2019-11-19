<%@ page title="" validateRequest="false" language="C#" masterpagefile="~/Template.Master" EnableEventValidation="true" AutoEventWireup="true" codefile="AdvertFeedback.aspx.cs" inherits="targeted_marketing_display.AdvertFeedback" Async="true" %>

<%@ register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .panel {
            width: 100% !important;
            height: 100% !important;
        }
        .chartFb {
            width: 100% !important;
            height: 50% !important;
        }
        .calendar {
            position: relative;
            left: 741px;
            top: -34px;
        }
        .pickdate {
        }
        .fontfont {
            position: center;
            left: 710px;
            top: -20px
        }
        #videoDog {
            object-fit: cover;
        }
        #vidDiv {
        }
        #btnGen {
            width: 140px;
        }
        .NoobPhone {
            width: 100px;
            height: 100px;
        }
        .NoobPhoneHeading {
            width: 120px;
        }
        @media only screen and (max-width: 530px) {
            .HideInMobile {
                display: none;
            }

            .NoobPhone {
                width: 50px;
                height: 80px;
            }

            .NoobPhoneHeading {
                width: 50px;
            }
        }
    </style>
    <script>  
        $(function () {
            $('.pickdate').datepicker(
                {
                    dateFormat: 'dd/mm/yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1950:2100'
                });
        })
        function showComModal() {
            $('#ComModal').modal('show');
        }
        function showAdvModal() {
            $('#AdvModal').modal('show');
        }
        function showBbModal() {
            $('#BbModal').modal('show');
        }
        function showVadDateModal() {
            $('#VadDateModal').modal('show');
        }
        function showVadModal() {
            $('#VadModal').modal('show');
        }
        function showVadModal2() {
            $('#VadModal2').modal('show');
        }
        function hideModalAdv() {
            $('#AdvModal').modal('hide');
        }
    </script>
    <script type="text/javascript">
        function RadioCheckAdvert(rb) {
            var gv = document.getElementById("<%=gvAdv.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "checkbox") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
        function RadioCheckBillboard(rb) {
            var gv = document.getElementById("<%=gvBb.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "checkbox") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
        function CustomValidator1_ClientValidate(source,args)
        {   
            if(document.getElementById("<%= rbNo.ClientID %>").checked || document.getElementById("<%= rbAge.ClientID %>").checked || document.getElementById("<%= rbGender.ClientID %>").checked || document.getElementById("<%= rbEmotion.ClientID %>").checked)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
        function checkAll(objRef) {
            var GridView = objRef.parentNode.parentNode.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                var row = inputList[i].parentNode.parentNode;
                if (inputList[i].type == "checkbox" && objRef != inputList[i]) {
                    if (objRef.checked) {
                        inputList[i].checked = true;
                    }
                    else {
                        inputList[i].checked = false;
                    }
                }
            }
        }
        function Check_Click(objRef) {
            var row = objRef.parentNode.parentNode;
            var GridView = row.parentNode;
            var inputList = GridView.getElementsByTagName("input");
            for (var i = 0; i < inputList.length; i++) {
                //var headerCheckBox = inputList[0];
                var checked = true;
                if (inputList[i].type == "checkbox") {
                    if (!inputList[i].checked) {
                        checked = false;
                        break;
                    }
                }
            }
            //headerCheckBox.checked = checked;
        }
    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="server" clientidmode="Static">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>     
        <div class="row">
            <div class="col-12">
                <h1 class="page-header">Advertisement Feedback</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:Button ID="btnGen" class="btn btn-primary float-right" runat="server" Text="Generate Chart" OnClick="btnGen_Click" />
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>Start Date: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox Class="form-control" ID="startDateTB" runat="server" TextMode="Date" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ControlToValidate="startDateTB" Display="Dynamic" ErrorMessage="Please select a start date" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <label>End Date: </label>
                    <label style="color: red">*</label>
                    <asp:TextBox class="form-control" ID="endDateTB" runat="server" TextMode="Date" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>&nbsp;
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="startDateTB" ControlToValidate="endDateTB" ErrorMessage="Invalid end date (Must end later than start date)" Operator="GreaterThan" Type="Date" ForeColor="Red" style="position: absolute"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ControlToValidate="endDateTB" Display="Dynamic" ErrorMessage="Please select an end date" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <p style="font-weight:bold">Company: 
                    <label style="color: red">*</label></p>
                    <asp:DropDownList ID="ddlCom" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCom_SelectedIndexChanged" AutoPostBack="True" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Targeted_Marketing_DisplayConnectionString %>" SelectCommand="SELECT [Name] FROM [Company] WHERE [Status] = 1 AND [Industry] NOT LIKE '0'"></asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="rfvCompany" runat="server" ControlToValidate="ddlCom" Display="Dynamic" InitialValue="<--Select A Company-->" ErrorMessage="Please select advertisement company" ForeColor="Red" ></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-12 col-md-6">
                <div class="form-group">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Targeted_Marketing_DisplayConnectionString %>" SelectCommand="SELECT [CompanyID], [Name] FROM [Company] where status=1"></asp:SqlDataSource>
                    <label>Advertisements: </label>
                    <label style="color: red">*</label>
                    <asp:UpdatePanel ID="updatepanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>
                        <asp:TextBox ID="advertTB" class="form-control" runat="server" placeholder="Search..." data-toggle="modal" data-target="#AdvModal" AutoCompleteType="Disabled" autocomplete="off" AutoPostBack="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAdvertisement" runat="server" ControlToValidate="advertTB" Display="Dynamic" ErrorMessage="Please select at least one advertisement" ForeColor="Red"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="addAdv" EventName="Click" />
                    </Triggers>
                    </asp:UpdatePanel>
                </div>

                <!-- Advertisement Modal -->
                <div id="AdvModal" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h2 class="modal-title">Advertisements</h2>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                        <div class="modal-body">
                            <div class="row">
                            <div class="col-12">
                                <div class="input-group custom-search-form" style="width: 50%">
                                    <asp:textbox id="txtAdv" class="form-control" runat="server" placeholder="Search..."></asp:textbox>
                                    <span class="input-group-btn">
                                        <asp:LinkButton runat="server" class="btn btn-default" ID="btnRun" style="height:34px;" Text="<i class='fa fa-search'></i>" OnClick="btnAdvSearch_OnClick" CausesValidation="false"/>                        
                                    </span>
                                </div>
                                <br />
                                <asp:UpdatePanel ID="updatepanel27" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" >
                                    <ContentTemplate>
                                        <div style="width: 100%;">
                                            <asp:GridView ID="gvAdv" runat="server" Visible="true" AutoGenerateColumns="False" CssClass="table table-bordered table-striped table-hover" 
                                                OnRowDataBound="gvAdv_RowDataBound" AllowPaging="false" ForeColor="Black" GridLines="Vertical" Height="100%" Width="100%" BackColor="White" BorderColor="#999999" 
                                                BorderStyle="Solid" BorderWidth="1px" CellPadding="3" OnPageIndexChanging="gvAdv_PageIndexChanging" OnSorting="gvAdv_Sorting">
                                            <AlternatingRowStyle BackColor="#CCCCCC" />
                                            <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Checkbox ID="RowSelectorADV" runat="server" onclick="Check_Click(this)"/>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center"/>
                                            </asp:TemplateField>
                                            <asp:TemplateField visible="false">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" visible="false"  ID="lb_AdvertID" Text='<%# Bind("AdvID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Advert" HeaderStyle-CssClass="NoobPhoneHeading">
                                                <ItemTemplate>
                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Item") %>'
                                                        Visible='<%# Eval("ItemType").ToString() =="image" %>' ClientIDMode="static" 
                                                        style="display:block;object-fit: cover;" ItemStyle-HorizontalAlign="Center" CssClass="NoobPhone"/>
                                                    <div id="vidDiv" runat="server">
                                                        <video ClientIDMode="static" id="videoDog" width="200" height="200" runat="server" controls visible='<%# Eval("ItemType").ToString()!="image" %>'>  
                                                            <source runat="server" src='<%#Eval("Item")%>' type="video/mp4" visible='<%# Eval("ItemType").ToString()!="image" %>' ItemStyle-HorizontalAlign="Center" class="NoobPhone"/>  
                                                        </video>  
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile">
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ItemType" HeaderText="Type" SortExpression="ItemType" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="HideInMobile" ItemStyle-CssClass="HideInMobile">
                                            </asp:BoundField>
                                            <asp:BoundField DataField="StartDate" HeaderText="Start Date" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px" DataFormatString="{0:D}">
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="EndDate" HeaderText="End Date" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px" DataFormatString="{0:D}">
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="#CCCCCC" />
                                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                                            <PagerStyle backcolor="#999999" forecolor="black" horizontalalign="left" />
                                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F1F1F1" HorizontalAlign="Center" />
                                            <SortedAscendingHeaderStyle BackColor="#808080" HorizontalAlign="Center" />
                                            <SortedDescendingCellStyle BackColor="#CAC9C9" HorizontalAlign="Center"/>
                                            <SortedDescendingHeaderStyle BackColor="#383838" HorizontalAlign="Center"/>
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="addAdv" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" class="btn btn-default" ID="addAdv" Style="height: 34px;" Text="Add" OnClick="addAdv_Click" causesValidation="false" />
                        </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="form-group">
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Targeted_Marketing_DisplayConnectionString %>" SelectCommand="SELECT [CompanyID], [Name] FROM [Company] where status=1"></asp:SqlDataSource>
                    <label>Billboards: </label>
                    <label style="color: red">*</label>
                    <asp:UpdatePanel ID="updatepanel2" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>
                        <asp:TextBox ID="billboardTB" class="form-control" runat="server" placeholder="Search..." data-toggle="modal" data-target="#BbModal" AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvBillboard" runat="server" ControlToValidate="billboardTB" Display="Dynamic" ErrorMessage="Please select at least one billboard" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br /><br />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="addBb" EventName="Click" />
                    </Triggers>
                    </asp:UpdatePanel>
                </div>
                <!-- Billboard Modal -->
                <div id="BbModal" class="modal" role="dialog">
                    <div class="modal-dialog modal-lg">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 class="modal-title">Billboards</h2>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                            <div class="col-12">
                                <div class="input-group custom-search-form" style="width: 50%">
                                    <asp:TextBox ID="txtBb" class="form-control" runat="server" placeholder="Search..." AutoCompleteType="Disabled" autocomplete="off"></asp:TextBox>
                                    <span class="input-group-btn">
                                        <%--<button class="btn btn-default" runat="server" type="button" onserverclick="btnBbSearch_OnClick">
                                            <i class="fa fa-search"></i>
                                        </button>--%>
                                        <asp:LinkButton runat="server" class="btn btn-default" ID="LinkButton1" style="height:34px;" Text="<i class='fa fa-search'></i>" OnClick="btnBbSearch_OnClick" CausesValidation="false"/>                        
                                    </span>
                                </div>
                                &nbsp
                                &nbsp 
                            <asp:GridView ID="gvBb" runat="server" Visible="true" Style="margin-top: 5px;" CssClass="table table-bordered table-striped table-hover"
                                OnRowDataBound="gvBb_RowDataBound" AllowPaging="true" PageSize="10" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3"
                                AutoGenerateColumns="False" Height="100%" Width="100%" OnPageIndexChanging="gvBb_PageIndexChanging" OnSorting="gvBb_Sorting">
                                    <AlternatingRowStyle BackColor="#CCCCCC" />
                            <Columns>
                                <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="RowSelectorBB" runat="server" onclick="Check_Click(this);" /></ItemTemplate>
                                <ItemStyle Width="3%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField visible="false">
                                    <ItemTemplate>
                                        <asp:Label runat="server" visible="false"  ID="lb_BillboardID" Text='<%# Bind("BillboardID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BillboardCode" HeaderText="Billboard Code" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px">
                                    <ItemStyle HorizontalAlign="Left" Width="7%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Address" HeaderText="Address" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200px">
                                    <ItemStyle HorizontalAlign="Center" Width="200px"></ItemStyle>
                                </asp:BoundField>
                            
                                </Columns>
                                    <FooterStyle BackColor="#CCCCCC" />
                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="left" />
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                            </asp:GridView>
                            </div>
                            </div>
                            </div>
                            <div class="modal-footer">
                            <%--<asp:UpdatePanel ID="updatepanel2" runat="server">
                                <ContentTemplate>--%>
                                <asp:Button runat="server" class="btn btn-default" ID="addBb" Style="height: 34px;" Text="Add" OnClick="addBb_Click" causesValidation="false" />
                            <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
 
        <div class="row">
            <div class="col-12 col-md-6" id="ChartSelectDiv" runat="server">
                <div class="form-group" >
                    <asp:Label runat="server" Text="Chart Type: " Font-Bold="true"></asp:Label><label style="color: red">*</label>
                    <br />
                    <asp:RadioButton ID="rbNo" runat="server" OnCheckedChanged="rbNo_CheckedChanged" AutoPostBack="true"/> 
                    <asp:Label ID="lblNo" runat="server" Text="No. Of Pax"></asp:Label>
                    <br />
                    <asp:RadioButton ID="rbAge" runat="server" OnCheckedChanged="rbAge_CheckedChanged" AutoPostBack="true"/> 
                    <asp:Label ID="lblAge" runat="server" Text="Age"></asp:Label>
                    <br />
                    <asp:RadioButton ID="rbGender" runat="server" OnCheckedChanged="rbGender_CheckedChanged" AutoPostBack="true"/>
                    <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label>
                    <br />
                    <asp:RadioButton ID="rbEmotion" runat="server" OnCheckedChanged="rbEmotion_CheckedChanged" AutoPostBack="true"/> 
                    <asp:Label ID="lblEmotion" runat="server" Text="Emotion"></asp:Label>
                    <br />
                    <asp:CustomValidator id="cvRadioButton" runat="server" Display="Dynamic" ErrorMessage="Please choose a chart type" ClientValidationFunction="CustomValidator1_ClientValidate" OnServerValidate="CustomValidator1_ServerValidate" ForeColor="Red" ></asp:CustomValidator>
                </div>
            </div>                
        </div>
        <br /><br />
        <div class="row">
            <div class="col-12">
                <div class="form-group">
                    <asp:Label ID="lblFbc" runat="server" Visible="false" Font-Size="X-Large" Font-Bold="true" CssClass="fontfont">Feedback Chart</asp:Label>
                </div>
            </div>
        </div>
            <div class="row">
                <div class="col-3">

                </div>
                <div class="col-6">
                    <div class="form-group">
                    <asp:Chart ID="chartFb" class="chartFb" runat="server" ClientIDMode="Static" Palette="Bright">
                        <series>
                            <asp:Series Name="Series1" Legend="Legend1">
                            </asp:Series>
                        </series>
                            <chartareas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </chartareas>
                    </asp:Chart>
                    </div>
                </div>
            </div>
            <br />
            <div id="NoDataDiv" runat="server" visible="false" align="center">
                <asp:Label id="NoDataText" Font-Bold="true" runat="server"></asp:Label>
                <br />
                <img src="~/webicons/NoChartData.png" runat="server" id="NoDataYet" />
            </div>

            <div id="VadDateModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Validation</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">

                        <div class="col-12">
                            <asp:Label runat ="server" Text="Please input start/end dates" Font-Size="Large"></asp:Label>
                        </div>
                        &nbsp;
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
                </div>
            </div>
        </div>
        <div id="VadModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Validation</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Label runat ="server" Text="Please select a chart type" Font-Size="Large"></asp:Label>
                        </div>
                        &nbsp;
                    </div>
                    <div class="modal-footer">
                    </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="VadModal2" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Validation</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <asp:Label runat ="server" Text="Please select either a company/advertisement/billboard" Font-Size="Large"></asp:Label>
                        </div>
                        &nbsp;
                    </div>
                    <div class="modal-footer">
                    </div>
                    </div>
                </div>
            </div>
        </div> 
    </form>
</asp:content>
