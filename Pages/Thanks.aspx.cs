using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DHRSurveys.Thanks
{
    public partial class Thanks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void db_Click_Click(object sender, EventArgs e)
        {
            Response.Redirect("Display.aspx");
        }
    }
}