﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data;
using System.Data.SqlClient;
using targeted_marketing_display;
using System.Text;



namespace targeted_marketing_display
{
    public partial class BillboardList : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            // Deny normal user access
            if (Session["userType"].ToString() == Reference.USR_MEM)
            {
                /* string script = "alert('You do not have access to the page.');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true); */

                ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect", "alert('You do not have access to this page'); window.location='" +
                Request.ApplicationPath + "ProfileInfo.aspx';", true);
            }

            //ADM Or admin
            if (Session["userID"]==null||Session["userType"]==null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                if (Session["userType"].ToString() == Reference.USR_ADM)
                {
                    adminDiv.Visible = true;
                    //userDiv.Visible = false;
                }
                else
                {
                    adminDiv.Visible = false;
                    //userDiv.Visible = true;
                }
                if (Convert.ToInt32(Session["BBUpdate"]) == 2)
                {
                    updateSuccess.Visible = true;
                    Session.Remove("BBUpdate");

                }
                if (Convert.ToInt32(Session["BBCreate"]) == 2)
                {
                    createSuccess.Visible = true;
                    Session.Remove("BBCreate");
                }
                //SqlConnection conn = null;
                //SqlDataReader reader = null;

                //// instantiate and open connection
                //conn = new
       
                //conn.Open();


                //GridView1.DataSource = dt;
                GridView1.DataBind();

                //GridView2.DataSource = dt;
                //GridView2.DataBind();
                //foreach (GridViewRow row in GridView1.Rows)
                //{
                //    for (int i = 1; i <= GridView1.Rows.Count; i++)
                //    {

                //        string BillboardID = GridView1.Rows[i].Cells[0].Text.ToString();
                //        SqlCommand cmd = new SqlCommand(
                //        "select count(*) from AdvertisementLocation where BillboardID=@ID ", conn);
                //        SqlParameter param = new SqlParameter();
                //        param.ParameterName = "@ID";
                //        param.Value = BillboardID;


                //}

                //}
            }

        }

        protected void btnNew_Billboard(object sender, EventArgs e)
        {
            Response.Redirect("BillboardCreate.aspx");
        }

            protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
            alertSuccess.Visible = false;
            updateSuccess.Visible = false;
            createSuccess.Visible = false;
            DeleteFailure.Visible = false;
        }
        protected void infoBtn_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "BillboardInfo")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                // Retrieve the row that contains the link button from the Rows collection.
                GridViewRow row = GridView1.Rows[index];
                LinkButton lbButton1 = sender as LinkButton;
                GridViewRow gvRow1 = (GridViewRow)lbButton1.NamingContainer;

                //Need to Retrieve userID to display info of user
                Label lb_BillboardID = (Label)gvRow1.FindControl("lb_BillboardID");

                Session["BillboardID"] = lb_BillboardID.Text;

                Response.Redirect("BillboardInfo.aspx");
            }
        }

        protected void editBtn_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "BillboardUpdate")
            {
                int index = Convert.ToInt32(e.CommandArgument);


                // Retrieve the row that contains the link button from the Rows collection.
                GridViewRow row = GridView1.Rows[index];
                LinkButton lbButton1 = sender as LinkButton;
                GridViewRow gvRow1 = (GridViewRow)lbButton1.NamingContainer;

                Label lb_BillboardID = (Label)gvRow1.FindControl("lb_BillboardID");
                Session["BillboardID"] = lb_BillboardID.Text;

                Response.Redirect("BillboardUpdate.aspx");
            }
        }

        protected void btnDelete_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "DeleteBBMessage")
            {
                SqlConnection conn = null;
                SqlDataReader reader = null;



                // instantiate and open connection
                conn = new
                    SqlConnection(Reference.Constr);
                conn.Open();
             

                int index = Convert.ToInt32(e.CommandArgument);


                // Retrieve the row that contains the button 
                // from the Rows collection.
                GridViewRow row = GridView1.Rows[index];
                LinkButton btnButton1 = sender as LinkButton;
                GridViewRow gvRow1 = (GridViewRow)btnButton1.NamingContainer;
                Billboard bObj = new Billboard();
             
                Billboard_Management bDao = new Billboard_Management();



                Label lb_msgId = (Label)gvRow1.FindControl("lb_BillboardID");

                bObj = bDao.getBillboardByID(lb_msgId.Text);
                string  BBCode= bObj.BillboardCode;
                SqlCommand cmdcount = new SqlCommand("Select count(*) as total from BillboardLocation as b inner join AdvertisementLocation al on b.BillboardID=al.BillboardID inner join Advertisement a2 on" +
                    " al.AdvID=a2.AdvID where al.BillboardID=@ID and a2.status=1", conn);
                SqlParameter paramCount = new SqlParameter();
                paramCount.ParameterName = "@ID";
                paramCount.Value = bObj.BillboardID.ToString();
                cmdcount.Parameters.Add(paramCount);
                SqlDataAdapter sdacount = new SqlDataAdapter();
                DataTable dt = new DataTable();
                cmdcount.Connection = conn;
                sdacount.SelectCommand = cmdcount;
                sdacount.Fill(dt);
                for(int i = 0;i< dt.Rows.Count; i++)
                {
                    int count = Convert.ToInt32(dt.Rows[i]["total"]);
                    if (count == 0)
                    {
                        Boolean insCnt = bDao.deleteBillboard(lb_msgId.Text);

                        //VIC: never inform if the delete is successful or not?
                        alertSuccess.Visible = true;
                        DeleteFailure.Visible = false;
                        createSuccess.Visible = false;
                        updateSuccess.Visible = false;
                        msgSuccess.Text = " Billboard #" + BBCode + " has been deleted successfully!";

                    }
                    else
                    {
                        DeleteFailure.Visible = true;
                        alertSuccess.Visible = false;
                        createSuccess.Visible = false;
                        updateSuccess.Visible = false;
                        LabelError.Text = "There are " + count + " Advertisement(s) in Billboard " + BBCode + ".Please delete existing advertisement(s) first before proceeding to delete the Billboard.";
                    }
                }






                
                Database db = new Database();

                SqlCommand cmd = new SqlCommand("Select * from [BillboardLocation] WHERE Status = 1");             
                DataSet ds = db.getDataSet(cmd);

                //gvUser.DataSource = ds;
                GridView1.DataBind();

            }
        }











        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            Label1.Text = "Displaying Page " + (GridView1.PageIndex + 1).ToString() + " of " + GridView1.PageCount.ToString();
        }
    }
}