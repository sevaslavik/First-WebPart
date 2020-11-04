<%@ Assembly Name="SharePointProject1VSeida, Version=1.0.0.0, Culture=neutral, PublicKeyToken=1775c281c07d380f" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsBoxUserControl.ascx.cs" Inherits="SharePointProject1VSeida.WebParts.NewsBox.NewsBoxUserControl" %>
<SharePoint:CssRegistration runat="server" Name="/_layouts/15/SharePointProject1VSeida/Style.css"></SharePoint:CssRegistration>



<asp:UpdatePanel ID="Update" runat="server" UpdateMode="Conditional">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="Btn" EventName="Click" />
    </Triggers>
    <ContentTemplate>
        <div class="grid">
            Add Title<asp:TextBox runat="server" ID="Title_TextBox"></asp:TextBox>
            Add description<asp:TextBox runat="server" ID="Description_TextBox"></asp:TextBox>
            Date:<asp:TextBox TextMode="DateTimeLocal" runat="server" ID="PublishingDate_TextBox"></asp:TextBox>
            User:<asp:TextBox runat="server" ID="PersonAsign_TextBox"></asp:TextBox>
            Is they visible
            <asp:CheckBox runat="server"
        ID="CheckBoxVisible" />
            <asp:Button ID="Btn" runat="server" Text="Add" OnClick="Btn_Click" />
        </div>
        <div class="grid">
            <ul style="list-style: none;">
                <li>
                    <asp:Button ID="SrtByDateAsc" runat="server" Text="Sort by Date Ascending" OnClick="SrtByDate_Click" />
                    <asp:Button ID="SrtByDateDesc" runat="server" Text="Sort by Date Descending" OnClick="SrtByDateDesc_Click" />
                </li>
                <li>
                    <asp:Button ID="SrtByAuthorAsc" runat="server" Text="Sort by Author Ascending" OnClick="SrtByAuthor_Click" />
                    <asp:Button ID="SrtByAuthorDesc" runat="server" Text="Sort by Author Descending" OnClick="SrtByAuthorDesc_Click" />
                </li>
            </ul>
        </div>
        <asp:Repeater ID="RptArt" runat="server">

            <HeaderTemplate>
                <div class="grid">
                    <h1>News:</h1>
                </div>
            </HeaderTemplate>

            <ItemTemplate>
                <div class="grid">
                    <ul class="news" style="
                        list-style: none;
                        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
                        font-size: 1em;
                        color: cadetblue;
                     ">
                        <li class="news__item"><strong>Title:</strong><%#DataBinder.Eval(Container.DataItem,"Title") %></li>
                        <li class="news__item"><strong>Description:</strong><%#DataBinder.Eval(Container.DataItem,"DescriptionNews") %></li>
                        <li class="news__item"><strong>Publishing Date:</strong><%#DataBinder.Eval(Container.DataItem,"PublishingDate") %></li>
                        <li class="news__item"><strong>Author:</strong><%#DataBinder.Eval(Container.DataItem,"PersonAssigned") %></li>
                    </ul>
                </div>
            </ItemTemplate>

        </asp:Repeater>
    </ContentTemplate>
</asp:UpdatePanel>
