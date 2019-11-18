using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using targeted_marketing_display;


namespace targeted_marketing_display
{
    public partial class UserInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Deny normal user access
            if (Session["userType"].ToString() == Reference.USR_MEM)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect", "alert('You do not have access to this page'); window.location='" +
                Request.ApplicationPath + "ProfileInfo.aspx';", true);
            }
            else
            {
                User userObj = new User();
                UserManagement uDao = new UserManagement();


                userObj = uDao.getUserByID(Session["selectedID"].ToString());

                lbName.Text = userObj.Name;
                lbEmail.Text = userObj.Email;
                lbContact.Text = userObj.ContactNumber;
                lbUserType.Text = uDao.getUserType(userObj.Type);
                lbCompany.Text = userObj.CompanyName;
                lbStatus.Text = uDao.getUserStatus(userObj.Status);
            }

        }

        protected void btnBack_User(object sender, EventArgs e)
        {
            Response.Redirect("UserList.aspx");
        }

    }
}