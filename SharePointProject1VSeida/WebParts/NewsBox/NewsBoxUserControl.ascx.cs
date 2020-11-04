using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Utilities;

namespace SharePointProject1VSeida.WebParts.NewsBox
{
    public partial class NewsBoxUserControl : UserControl
    {
        public class NewListItem
        {
            public string Title { get; private set; }

            public string Description { get; private set; }

            public string PublishingDate { get; private set; }

            public string PersonAsigne { get; private set; }

            public bool IsVisible { get; private set; }

            public NewListItem(
                string title,
                string description,
                string publishingDate,
                string personAsigne,
                bool isVisible)
            {
                this.Title = title;
                this.Description = description;
                this.PublishingDate = publishingDate;
                this.PersonAsigne = personAsigne;
                this.IsVisible = isVisible;
            }

        }

        protected void Add_Item_In_Repeater(string fieldName, bool action)
        {
            using (SPSite site = new SPSite(SPContext.Current.Site.Url))
            {
                SPWeb web = site.OpenWeb();
                SPList list = web.Lists["News"];
                SPQuery query = new SPQuery();

                query.Query = string.Format( @" 
                    <Where> 
                          <Eq>
                               <FieldRef Name ='Visible'/> 
                                   <Value Type ='Boolean'>
                                                   1 
                                    </Value>
                          </Eq>
                    </Where >
                    <OrderBy>
                        <FieldRef Name='{0}' Ascending='{1}'/>
                    </OrderBy>", fieldName, action);

                SPListItemCollection items = list.GetItems(query);

                RptArt.DataSource = items.GetDataTable();
                RptArt.DataBind();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;

            Add_Item_In_Repeater("ID", true);
        }

        protected void Btn_Click(object sender, EventArgs e)
        {

            NewListItem newListItem = new NewListItem(
                Title_TextBox.Text,
                Description_TextBox.Text,
                PublishingDate_TextBox.Text,
                PersonAsign_TextBox.Text,
                CheckBoxVisible.Checked);

            SPWeb web = SPContext.Current.Web;

            SPList list = web.GetList(SPUrlUtility.CombineUrl(web.ServerRelativeUrl, "/Lists/News"));

            SPListItem listItem = list.Items.Add();

            listItem["Title"] = newListItem.Title;
            listItem["DescriptionNews"] = newListItem.Description;           
            listItem["PublishingDate"] = newListItem.PublishingDate;           
            listItem["PersonAssigned"] = newListItem.PersonAsigne;
            listItem["Visible"] = newListItem.IsVisible;

            listItem.Update();
            Add_Item_In_Repeater("ID", true);
        }

        protected void SrtByDate_Click(object sender, EventArgs e)
        {
            Add_Item_In_Repeater("PublishingDate", true);
        }

        protected void SrtByAuthor_Click(object sender, EventArgs e)
        {
            Add_Item_In_Repeater("PersonAssigned", true);
        }

        protected void SrtByDateDesc_Click(object sender, EventArgs e)
        {
            Add_Item_In_Repeater("PublishingDate", false);
        }

        protected void SrtByAuthorDesc_Click(object sender, EventArgs e)
        {
            Add_Item_In_Repeater("PersonAssigned", false);
        }
    }
}

//System.NullReferenceException: Object reference not set to an instance of an object.    at Microsoft.SharePoint.Portal.WebControls.FeedWebPartBase.WriteInitialDataToPage(HtmlTextWriter writer, String fullMicrofeedDivCustomAttributes)     at Microsoft.SharePoint.Portal.WebControls.SiteFeedWebPart.RenderWebPart(HtmlTextWriter writer)     at Microsoft.SharePoint.WebPartPages.WebPart.Render(HtmlTextWriter writer)     at System.Web.UI.Control.RenderControlInternal(HtmlTextWriter writer, ControlAdapter adapter)     at Microsoft.SharePoint.WebPartPages.SPChrome.RenderPartContents(HtmlTextWriter output, WebPart part)
