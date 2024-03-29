﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="CompanyList.aspx.cs" Inherits="targeted_marketing_display.CompanyList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style16 {
            text-align: right;
        }

        #ContentPlaceHolder1_btnNewCompany {
            width: 140px;
        }

        @media only screen and (max-width: 968px) {
            .HideInMobile {
                display: none;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server">
        <script>
            function deleteFunction() {
                if (!confirm('Confirm Deletion of Company?')) {
                    return false;
                }
                else {
                    return true;
                }
            }
        </script>

        <div id="adminDiv">
            <div class="row">
                <div class="col-12">
                    <h1 class="page-header">Companies</h1>
                </div>
            </div>

            <div class="row">
                <div class="col-12" >      
                    <asp:Button ID="btnNewCompany" class="btn btn-primary float-right" runat="server" Text="New Company" OnClick="btnNew_Company" />
                </div>               
            </div>

            <br />

            <div class="row">
                <div class="col-12">
                    <div class="input-group custom-search-form">
                        <div style="float: left">
                            <p class="input-group">
                            <asp:TextBox ID="tbSearch" class="form-control" runat="server" placeholder="Search..." AutoComplete="off"></asp:TextBox>
                            <%--<input type="submit" id="btSubmit" runat="server" />--%>
                            <span class="input-group-btn" >
                                <asp:LinkButton runat="server" class="btn btn-default" ID="btnRun" Text="<i class='fa fa-search'></i>"/>
                            </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div runat="server" class="alert alert-danger" id="DeleteError" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
                <asp:Label runat="server" ID="DeleteLabel"></asp:Label>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <div runat="server" class="alert alert-success" id="createSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
                <strong>Successfully created company!</strong> 
                <asp:Label runat="server" ID="createLabel"></asp:Label>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <div runat="server" class="alert alert-success" id="updateSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
                <strong>Success!</strong> 
                <asp:Label runat="server" ID="updateLabel">Successfully updated company.</asp:Label>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
             
            <div runat="server" class="alert alert-success" id="alertSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
                <strong>Success!</strong> 
                <asp:Label runat="server" ID="msgSuccess"></asp:Label>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="table-responsive">                       
                        <%--<table class="table table-striped table-bordered table-hover" style="width: 100%">--%>
                        <asp:GridView ID="GridView3" CssClass="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False" Height="100%" Width="100%"
                            BackColor="White" BorderColor="#999999" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource1" AllowPaging="True" OnPreRender="GridView3_PreRender" 
                            OnSelectedIndexChanged="GridView3_SelectedIndexChanged" ForeColor="Black" GridLines="Vertical" OnPageIndexChanging="GridView3_PageIndexChanging">
                            <AlternatingRowStyle BackColor="#CCCCCC" />

                            <Columns>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Visible="false" ID="lb_CompanyID" Text='<%# Bind("CompanyID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="ID" DataField="CompanyID" Visible="false">
                                    <ItemStyle Width="100px" Wrap="False" HorizontalAlign="Left"/>
                                </asp:BoundField>

                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                    <ControlStyle Height="50%" />
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="50%" Wrap="True" VerticalAlign="Middle" HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="CodeDesc" HeaderText="Industry" SortExpression="CodeValue" ItemStyle-CssClass="HideInMobile" HeaderStyle-CssClass="HideInMobile">
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="25%" Wrap="False" VerticalAlign="Middle" HorizontalAlign="Center" />
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="View">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="adsBtn" OnCommand="adsBtn_Command" runat="server" CommandName="AdvertInfo" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                                        <i class="fas fa-eye"></i>
                                        </asp:LinkButton>
                                        <% %>
                                    </ItemTemplate>
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemStyle Width="5px" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                                        </asp:TemplateField>

                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                    <asp:LinkButton ID="editBtn" OnCommand="editBtn_Command" runat="server" CommandName="editcompanyInfo" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                                    <i class="fa fa-edit"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemStyle Width="5px" HorizontalAlign="Center" Wrap="False" VerticalAlign="Middle" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                    <asp:LinkButton ID="delBtn" OnCommand="btnDelete_Command"  OnClientClick="return deleteFunction();"  runat="server" CommandName="DeleteMessage" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                                        <i class="fa fa-trash"></i>
                                    </asp:LinkButton>
                                    </ItemTemplate>
                                    <ControlStyle Height="50%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemStyle Width="5px" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                                    </asp:TemplateField>

                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="#999999" Font-Bold="True" ForeColor="Black" HorizontalAlign="Center" Wrap="False" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="left" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                        </asp:GridView>
                        <!-- <asp:Label ID="Label1" style="color:darkslateblue" runat="server" Text="Label" Font-Bold="true"></asp:Label> -->
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Targeted_Marketing_DisplayConnectionString %>" SelectCommand="select [Company].CompanyID,[CodeReferece].CodeValue,[Company].Name,[CodeReferece].CodeDesc from [Company] 
                            inner join [CodeReferece] on [Company].Industry=[CodeReferece].CodeValue
                            where [Company].Status=1 and [CodeReferece].CodeType='Industry'" FilterExpression="Name LIKE '%{0}%' OR CodeDesc LIKE '%{0}%'">
                            <FilterParameters>
                                <asp:ControlParameter ControlID="tbSearch" Name="Name" PropertyName="Text" />
                                <asp:ControlParameter ControlID="tbSearch" Name="CodeValue" PropertyName="Text" />                                            
                            </FilterParameters>        
                        </asp:SqlDataSource>
                        <%-- </table> --%>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
