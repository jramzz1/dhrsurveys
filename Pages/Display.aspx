<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Display.aspx.cs" Inherits="DHRSurveys.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />
    <!-- JavaScript Bundle with Popper -->
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <link href="~/stylesheets/homepage.css" media="screen" rel="stylesheet" type="text/css"/>
</head>
<body style="font-family: Montserrat">
    <form id="form1" runat="server">
        <div style="background: linear-gradient(180deg, rgba(0,164,153,1) 0%, rgba(0,164,153,0) 100%); height:900px; padding-top:10em;">
            <div style="text-align:left; min-width: 900px; max-width: 1550px; margin: auto;">
                <h2 style="padding-left:1.2em;">Survey Response Data</h2>
                <table style="border-collapse:separate; padding-left:1em; padding-right:1em; padding-bottom:2em; width:97%; margin: auto;">
                    <tr>
                        <th style="padding-top:2em;">Survey Questions</th>
                    </tr>
                    <tr><td style="padding-bottom:1em;">(Bad: 1 Good: 2 Excellent: 3)</td></tr>
                    <tr>
                        <td><label>Question 1: Admitting Staff Courtesy</label></td>
                        <td><label>Question 2: Room Cleanliness</label></td>
                        <td><label>Question 3: Noise Level</label></td>
                        <td><label>Question 4: Food Quality</label></td>
                        <td><label>Question 5: Nurse Courtesy</label></td>
                    </tr>
                </table>
                <asp:GridView ID="SurveyTBL" class="centered-table" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" GridLines="None" 
                ShowFooter="true" ShowHeaderWhenEmpty="true" OnRowCommand="SurveyTBL_RowCommand" OnRowEditing="SurveyTBL_RowEditing" 
                OnRowCancelingEdit="SurveyTBL_RowCancelingEdit" OnRowUpdating="SurveyTBL_RowUpdating" OnRowDeleting="SurveyTBL_RowDeleting" CellPadding="5" HorizontalAlign="Center" 
                AllowPaging="true" PageSize="10" OnPageIndexChanging="SurveyTBL_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="ID" >
                        <ItemTemplate><asp:Label Text='<%# Eval("ID") %>' runat="server" /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Submit Date">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("survey_datetime") %>' runat="server" />
                        </ItemTemplate>
                        <FooterTemplate><asp:Label ID="manualInstructions" runat="server" Text="Manual survey input:" style="text-align: right;"/></FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="First Name">
                        <ItemTemplate><asp:Label Text='<%# Eval("pat_first") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate><asp:TextBox ID="txtFirstName" Text='<%# Eval("pat_first") %>' runat="server" onchange ="saveValidate(this);"/></EditItemTemplate>
                        <FooterTemplate><asp:TextBox ID="txtFirstNameFooter" runat="server" placeholder="First Name"/></FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name">
                        <ItemTemplate><asp:Label Text='<%# Eval("pat_last") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate><asp:TextBox ID="txtLastName" Text='<%# Eval("pat_last") %>' runat="server" /></EditItemTemplate>
                        <FooterTemplate><asp:TextBox ID="txtLastNameFooter" runat="server" placeholder="Last Name"/></FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone Number">
                        <ItemTemplate><asp:Label Text='<%# Eval("pat_phone") %>' runat="server"  TextChanged="PhoneChanged"/></ItemTemplate>
                        <EditItemTemplate><asp:TextBox ID="txtPhone" Text='<%# Eval("pat_phone") %>' runat="server" /></EditItemTemplate>
                        <FooterTemplate><asp:TextBox ID="txtPhoneFooter" runat="server" placeholder="Phone Number"/></FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Question1">
                        <ItemTemplate><asp:Label Text='<%# Eval("Q1_Response") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="txtQ1" runat="server" selectedvalue='<%# Eval("Q1_Response") %>'>
                                <asp:ListItem runat="server">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="txtQ1Footer" runat="server">
                                <asp:ListItem runat="server" Selected="True">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Question2">
                        <ItemTemplate><asp:Label Text='<%# Eval("Q2_Response") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="txtQ2" runat="server" selectedvalue='<%# Eval("Q2_Response") %>'>
                                <asp:ListItem runat="server">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="txtQ2Footer" runat="server">
                                <asp:ListItem runat="server" Selected="True">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Question3">
                        <ItemTemplate><asp:Label Text='<%# Eval("Q3_Response") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="txtQ3" runat="server" selectedvalue='<%# Eval("Q3_Response") %>'>
                                <asp:ListItem runat="server">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="txtQ3Footer" runat="server">
                                <asp:ListItem runat="server" Selected="True">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Question4">
                        <ItemTemplate><asp:Label Text='<%# Eval("Q4_Response") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="txtQ4" runat="server" selectedvalue='<%# Eval("Q4_Response") %>'>
                                <asp:ListItem runat="server">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="txtQ4Footer" runat="server">
                                <asp:ListItem runat="server" Selected="True">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Question5">
                        <ItemTemplate><asp:Label Text='<%# Eval("Q5_Response") %>' runat="server" /></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="txtQ5" runat="server" selectedvalue='<%# Eval("Q5_Response") %>'>
                                <asp:ListItem runat="server">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="txtQ5Footer" runat="server">
                                <asp:ListItem runat="server" Selected="True">1</asp:ListItem>
                                <asp:ListItem runat="server">2</asp:ListItem>
                                <asp:ListItem runat="server">3</asp:ListItem>
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="EditBTN" class="btn-sm btn-primary" runat="server" Text="Edit" CommandName="Edit" ToolTip="Edit"/>
                            <asp:Button ID="DeleteBTN" class="btn-sm btn-danger" runat="server" Text="Delete" CommandName="Delete" ToolTip="Delete"/> 
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="SaveBTN" class="btn-sm btn-success" runat="server" Text="Save" CommandName="Update" ToolTip="Update"/>
                            <asp:Button ID="CancelBTN" class="btn-sm btn-dark" runat="server" Text="Cancel" CommandName="Cancel" ToolTip="Cancel"/> 
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:Button ID="AddBTN" class="btn-sm btn-info" runat="server" Text="Add" CommandName="Add" ToolTip="Add"/> 
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
                </asp:GridView>
            </div>
            
            <div ID="MessageShow" runat="server" class="alert alert-success" role="alert" Visible="false" style="width:50%;  margin: auto; margin-bottom: 3em;"/>
        </div>        
        <asp:Label runat="server" ID="saveFirst" hidden="hidden"></asp:Label>
        <asp:Label runat="server" ID="saveLast" hidden="hidden"></asp:Label>
        <asp:Label runat="server" ID="saveResponse" hidden="hidden"></asp:Label>
    </form>
    <script src="../js/tblvalidate.js"></script>
</body>
</html>
