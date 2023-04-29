<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="RegistrationForm.aspx.cs" Inherits="Infosys.RegistrationForm" %>
<%@Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td style="padding: 20px; border-style: solid; border-color: black">
                <center>
                    <table>
                        <asp:ScriptManager ID="scm" runat="server"></asp:ScriptManager>
                        <tr>
                            <td>Name:</td>
                            <td>
                                <asp:TextBox ID="txtname" runat="server" placeholder="Enter Full Name"></asp:TextBox></td>
                        </tr>

                        <tr>
                            <td>Gender:</td>
                            <td>
                                <asp:RadioButtonList ID="rblgender" runat="server" RepeatColumns="3"></asp:RadioButtonList></td>
                        </tr>

                         <tr>
                            <td>Date Of Birth:</td>
                            <td>
                                <%--I'm using ajax calender!!--%>
                                <asp:TextBox ID="txtdob" runat="server"></asp:TextBox>
                                <ajax:CalendarExtender ID="caldob" runat="server" PopupButtonID="txtdob" PopupPosition="TopRight" TargetControlID="txtdob" />
                            </td>
                        </tr>

                        <tr>
                            <td>Email:</td>
                            <td>
                                <asp:TextBox ID="txtemail" runat="server"></asp:TextBox></td>
                        </tr>

                         <tr>
                            <td>Skills:</td>
                            <td>
                                <asp:CheckBoxList ID="cblskills" runat="server" RepeatColumns="6">
                                    <asp:ListItem Text="C#" Value="1"></asp:ListItem>
                                    <asp:ListItem Text=".Net" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Java" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Spring" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="HTML" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="CSS" Value="6"></asp:ListItem>
                                </asp:CheckBoxList></td>
                        </tr>
                        

                        <tr>
                            <td>Country:</td>
                            <td>
                                <asp:DropDownList ID="ddlcountry" runat="server" OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList></td>
                        </tr>

                        <tr>
                            <td>State:</td>
                            <td>
                                <asp:DropDownList ID="ddlstate" runat="server"></asp:DropDownList></td>
                        </tr>

                        <tr>
                            <td>Salary:</td>
                            <td>
                                <asp:TextBox ID="txtsalary" runat="server" placeholder="Enter Per Month Salary"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" /></td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <asp:GridView ID="gvregistration" runat="server" OnRowCommand="gvregistration_RowCommand" AutoGenerateColumns="false">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="User ID">
                                            <ItemTemplate>
                                                <%#Eval("user_id") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <%#Eval("user_name") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Gender">
                                            <ItemTemplate>
                                                <%#Eval("gender_name") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                         <asp:TemplateField HeaderText="Date Of Birth">
                                            <ItemTemplate>
                                                <%#Eval("user_dob") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Email">
                                            <ItemTemplate>
                                                <%#Eval("user_email") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Skills">
                                            <ItemTemplate>
                                                <%#Eval("user_skills") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Country">
                                            <ItemTemplate>
                                                <%#Eval("country_name") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="State">
                                            <ItemTemplate>
                                                <%#Eval("state_name") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Salary">
                                            <ItemTemplate>
                                                <%#Eval("user_salary") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btndelete" BackColor="Red" runat="server" Text="Delete" CommandName="Del" CommandArgument=' <%#Eval("user_id") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnedit" BackColor="YellowGreen" runat="server" Text="Edit" CommandName="Edi" CommandArgument=' <%#Eval("user_id") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </center>
            </td>
        </tr>
    </table>
</asp:Content>
