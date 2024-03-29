﻿using System;
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


using System.Net;
using System.Xml.Linq;


namespace targeted_marketing_display
{
    public partial class BillboardCreate : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                Database db = new Database();
                //SqlCommand cmd = new SqlCommand("select CodeValue,CodeDesc from CodeReferece where CodeType=Industry ");
                //DataTable dt = db.getDataTable(cmd);
                //CoIndustry.DataSource = dt;
                //CoIndustry.DataValueField = "CodeValue";
                //CoIndustry.DataTextField = "CodeDesc";
                //CoIndustry.DataBind();
                //CoIndustry.Items.Insert(0, new ListItem("---Select An Industry---", "0"));
                SqlCommand cmd = new SqlCommand("select CodeValue,CodeDesc from CodeReferece where CodeType='Country' ");
                DataTable dt = db.getDataTable(cmd);
                BBCountry.DataSource = dt;
                BBCountry.DataValueField = "CodeValue";
                BBCountry.DataTextField = "CodeDesc";
                BBCountry.DataBind();
                BBCountry.Items.Insert(0, new ListItem("---Select A Country---", "0"));
            }
           
        }

        protected void btnBack_Billboard(object sender, EventArgs e)
        {
            Response.Redirect("BillboardList.aspx");
        }

            protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            SqlConnection conn = null;
            SqlDataReader reader = null;



            // instantiate and open connection
            conn = new
                SqlConnection(Reference.Constr);
            conn.Open();
            String BillboardCode = BBLocationCode.Text.ToString();
            String AddressLn1 = BBAddLn1.Text.ToString();
            String AddressLn2 = BBAddLn2.Text.ToString();
            String City = BBCity.Text.ToString();
            String Country = (BBCountry.SelectedItem.Value.ToString());
            String PostalCode = BBPostalCode.Text.ToString();
            DateTime CreatedOn = DateTime.Now;
            int Status = 1;
            string latitude = BBLatitude.Text.ToString();
            int CreatedBy = 1;
            string Longtitude = BBLongtitude.Text.ToString();

            Billboard_Management bbMgmt = new Billboard_Management();
            //che ee was here
            // Boolean record = bbMgmt.BBcheck(BillboardCode);
          



            SqlCommand sCmd = new SqlCommand("SELECT Count(*) FROM BillboardLocation WHERE BillboardCode=@BCode and status=1", conn);
            SqlParameter param = new SqlParameter();
            param.ParameterName = "@BCode";
            param.Value = BillboardCode;
            sCmd.Parameters.Add(param);
            Int32 totalcount = Convert.ToInt32(sCmd.ExecuteScalar());
            

            //if (BBLocationCode.Text == "" || BBAddLn1.Text == "" || BBCity.Text == "" || BBCountry.SelectedValue == "" ||
            //    BBPostalCode.Text == "" || BBLatitude.Text == "" || BBLongtitude.Text == "")
            //{
            //    alertWarning.Visible = true;
            //    alertSuccess.Visible = false;
            //    alertDanger.Visible = false;
            //    warningLocation.Text = "Please enter All Required Fields";

            //}

            //else
            //{
                if (totalcount == 0)
                {

                    Boolean result = bbMgmt.BBinsert(BillboardCode, AddressLn1, AddressLn2, City, Country, PostalCode, CreatedOn, Status, latitude, Longtitude, CreatedBy);
                    if (result == true)
                    {

                        //alertWarning.Visible = false;
                        //alertSuccess.Visible = true;
                        //BBLocationCode.Text = String.Empty;
                        //BBAddLn1.Text = String.Empty;
                        //BBAddLn2.Text = String.Empty;
                        //BBCountry.SelectedValue = "";
                        //BBCity.Text = String.Empty;
                        //BBPostalCode.Text = String.Empty;

                        Session["BBCreate"] = 2;
                        Response.Redirect("BillboardList.aspx");
                    }
                }

                else
                {
                   
                    alertWarning.Visible = false;
                    alertSuccess.Visible = false;
                    alertDanger.Visible = true;
                    dangerLocation.Text = "Billboard Code already exist";
                }

            //}
        }
    }
}


               

                                    
                            

