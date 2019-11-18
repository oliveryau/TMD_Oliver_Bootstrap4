<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeFile="UserList.aspx.cs" Inherits="targeted_marketing_display.UserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .auto-style2 {
        height: 42px;
        width: 150px;
    }

    .auto-style3 {
        width: 100px;
    }

    .auto-style4 {
        height: 42px;
        width: 65px;
    }

    .auto-style6 {
        height: 42px;
        width: 65px;
        text-align: center;
    }

    .auto-style10 {
        height: 30px;
        width: 5px;
        text-align: center;
    }

    .pgr {
        background-color: black;
    }

    #ContentPlaceHolder1_btnNewUser {
        width: 140px;
    }

    @media only screen and (max-width: 850px) {
        .HideInMobile {
            display: none;
        }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server" id="deleteUser">
        <script>
            function deleteFunction() {

                if (!confirm('Confirm Deletion of User?')) {

                    return false;
                }

                else {
                    return true;
                }
            }
        </script>

        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Users</h1>
            </div>
        </div>        

        <div class="row">
            <div class="col-lg-12">
                <asp:Button ID="btnNewUser" class="btn btn-primary nextBtn pull-right" runat="server" Text="New User" OnClick="btnNew_User" />
            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-12">
                <div class="input-group custom-search-form">
                    <div style="float: left">
                        <p class="input-group">
                        <asp:TextBox ID="tbSearch" class="form-control" runat="server" placeholder="Search..."></asp:TextBox>
                        <%--<input type="submit" id="btSubmit" runat="server" />--%>
                        <span class="input-group-btn" >
                            <asp:LinkButton runat="server" class="btn btn-default" ID="btnRun" Text="<i class='fa fa-search'></i>"/>
                        </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div runat="server" class="alert alert-danger" id="deleteFailure" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Error!</strong> 
            <asp:Label runat="server" ID="labelDelete"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div runat="server" class="alert alert-success" id="createSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Successfully created new account! Password will be sent to your email.</strong> 
            <asp:Label runat="server" ID="LabelCreate"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div runat="server" class="alert alert-success" id="updateSuccess" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Successfully updated user!</strong> 
            <asp:Label runat="server" ID="LabelUpdate"></asp:Label>
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

        <!-- tbh idk what is this -->
        <div runat="server" class="alert alert-success" id="Div1" visible="False" style="width: 100%; margin: 0px 0px 20px 0px">
            <strong>Success!</strong> 
            <asp:Label runat="server" ID="Label1"></asp:Label>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <!-- tbh idk what is this -->

        <asp:GridView ID="gvUser" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" Height="100%" Width="100%" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource1"
            AllowPaging="True"  ForeColor="Black" GridLines="Vertical" OnPageIndexChanging="gvUser_PageIndexChanging" >
                               
            <AlternatingRowStyle BackColor="#CCCCCC" />
                               
            <Columns>
                    <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:Label runat="server" Visible="false" ID="lb_UserID" Text='<%# Bind("UserID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField HeaderText="ID" DataField="UserID" Visible="false">
                    <ItemStyle Width="100px" Wrap="False" HorizontalAlign="Left"/>
                </asp:BoundField>

                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ></asp:BoundField>
                <asp:BoundField DataField="CodeDesc" HeaderText="User Type" SortExpression="CodeDesc"></asp:BoundField>
                <asp:BoundField DataField="Expr1" HeaderText="Company" SortExpression="Expr1" ItemStyle-CssClass="HideInMobile" HeaderStyle-CssClass="HideInMobile"></asp:BoundField>
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-CssClass="HideInMobile" HeaderStyle-CssClass="HideInMobile"></asp:BoundField>

                <asp:templatefield headertext="View">
                    <itemtemplate>
                        <asp:LinkButton ID="viewBtn" OnCommand="infoBtn_Command" runat="server" CommandName="userInfo" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                        <i class="fas fa-eye"></i>
                        </asp:LinkButton>      
                    </itemtemplate>
                    <ControlStyle Height="50%" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Width="5%" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                </asp:templatefield>

                <asp:templatefield headertext="Update">
                    <itemtemplate>     
                        <asp:LinkButton ID="editBtn" OnCommand="editBtn_Command" runat="server" CommandName="editInfo" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                        <i class="fa fa-edit"></i>
                        </asp:LinkButton>   
                    </itemtemplate>
                    <ControlStyle Height="50%" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Width="5%" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                </asp:templatefield>

                <asp:templatefield headertext="Delete">             
                    <itemtemplate>              
                        <asp:LinkButton ID="DeleteBtn" OnCommand="btnDelete_Command"   OnClientClick="return deleteFunction();" runat="server" CommandName="DeleteMessage" CommandArgument='<%#((GridViewRow) Container).RowIndex %>'>
                            <i class="fa fa-trash"></i>
                        </asp:LinkButton>                                                                             
                    </itemtemplate>
                    <ControlStyle Height="50%" />
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    <ItemStyle Width="5%" HorizontalAlign="Center" Wrap="True" VerticalAlign="Middle" />
                </asp:templatefield>                                    
            </Columns>

            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="#999999" Font-Bold="True" ForeColor="Black" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>

        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <div class="alert alert-success" runat="server" id="panel_success" visible="false">
                        <asp:Label ID="lbl_success" runat="server"></asp:Label>
                    </div>
                <div class="alert alert-danger" runat="server" id="panel_error" visible="false">
                    <asp:Label ID="lbl_error" runat="server"></asp:Label>
                </div>
                        <!-- SQL Table -->
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Targeted_Marketing_DisplayConnectionString %>" 
                        SelectCommand=" SELECT U.Name, CR.CodeDesc, C.Name AS Expr1, U.Email, U.UserID
                                        FROM [User] U
                                        JOIN [Company] C ON U.CompanyID = C.CompanyID
                                        JOIN [CodeReferece] CR ON CR.Status = U.Status
                                        WHERE U.Status = 1
                                            AND CR.CodeValue = U.Type
                                            AND CR.CodeType LIKE 'UserType' "
                        FilterExpression="Name LIKE '%{0}%' OR Expr1 LIKE '%{0}%' OR Email LIKE '%{0}%' OR CodeDesc LIKE '%{0}%' ">
                        <FilterParameters>
                            <asp:ControlParameter ControlID="tbSearch" Name="Name" PropertyName="Text" />
                            <asp:ControlParameter ControlID="tbSearch" Name="Expr1" PropertyName="Text" />
                            <asp:ControlParameter ControlID="tbSearch" Name="Email" PropertyName="Text" />
                            <asp:ControlParameter ControlID="tbSearch" Name="CodeDesc" PropertyName="Text" />
                        </FilterParameters>        
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </form>
</asp:Content>