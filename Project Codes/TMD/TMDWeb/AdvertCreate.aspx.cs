﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using targeted_marketing_display;
using System.IO;
namespace targeted_marketing_display
{
    public partial class AdvertCreate : System.Web.UI.Page
    {
        public int companyID { get; set; }

        string dbConnStr = ConfigurationManager.ConnectionStrings["Targeted_Marketing_DisplayConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if ((string)Session["userType"] == Reference.USR_ADM)
            {
                divCompany.Visible = true;
                DropDownListCompany.Visible = true;
              //  int companyID = Convert.ToInt32(DropDownListCompany.SelectedItem.Value);
            }
            else{
                // User userObj = new User();
                //  UserManagement uDao = new UserManagement();
                divCompany.Visible = false;
                DropDownListCompany.Visible = false;
               // userObj = uDao.getUserByID(Session["userID"].ToString());
               // int companyID = userObj.CompanyID;
            }
            //BillboardSearch.Attributes.Add("onClick", "return false;");
            if (!Page.IsPostBack)
            {
                Database db = new Database();
                string mainconn = ConfigurationManager.ConnectionStrings["Targeted_Marketing_DisplayConnectionString"].ConnectionString;
                SqlConnection sqlconn = new SqlConnection(Reference.Constr);
                string sqlquery = "SELECT * FROM [CodeReferece] WHERE ([CodeType] = @CodeType)";
                SqlCommand cmd = new SqlCommand(sqlquery, sqlconn);
                cmd.Parameters.AddWithValue("@CodeType", "Category");
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
               
                CheckBoxList1.DataSource = dt;
                CheckBoxList1.DataBind();
                SqlCommand cmdCompany = new SqlCommand("Select * from Company where status=1");
                DataTable dtCompany = db.getDataTable(cmdCompany);
                DropDownListCompany.DataSource = dtCompany;
                DropDownListCompany.DataValueField = "CompanyID";
                DropDownListCompany.DataTextField = "Name";
                DropDownListCompany.DataBind();
                DropDownListCompany.Items.Insert(0, new ListItem("---Select A Company---", "0"));

            }

            CompareValidator1.ValueToCompare = DateTime.Now.ToShortDateString();
            CompareValidator2.ValueToCompare = DateTime.Now.ToShortDateString();


            if (FileUpload1.HasFile)
            {
                Literal1.Text = Convert.ToString(FileUpload1.PostedFile.FileName);
                if (Literal1.Text.EndsWith(".png") || Literal1.Text.EndsWith(".jpg") || Literal1.Text.EndsWith(".jpeg") || Literal1.Text.EndsWith(".gif") || Literal1.Text.EndsWith(".PNG") || Literal1.Text.EndsWith(".JPG") || Literal1.Text.EndsWith(".JPEG") || Literal1.Text.EndsWith(".GIF"))
                {
                    Literal2.Text = "image";
                }
                else
                {
                    Literal2.Text = "video";
                }
            }
        }

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            
        }

        public int GetMaxIDAdvertisement()
        {
            int intID = 0;
            SqlConnection co = new SqlConnection(Reference.Constr);
            SqlCommand cm = new SqlCommand("Select Max(AdvID) from Advertisement", co);
            co.Open();
            SqlDataReader dr = cm.ExecuteReader();
            if (dr.Read())
            {
                intID = int.Parse(dr[0].ToString());
            }
            return intID ;
        }
      
        protected void ButtonConfirm_Click(object sender, EventArgs e)
        {

            //initialise imagelink and getvalue
            string imagelink = "";
            string getvalue = "";

            for (int i = 0; i < CheckBoxList2.Items.Count; i++)
            {
                if (CheckBoxList2.Items[i].Selected)
                {

                    getvalue += CheckBoxList2.Items[i].Text + ",";
                    getvalue = getvalue.TrimEnd();
                }
            }

            //if uploaded file then save
            if (FileUpload1.HasFile)
            {
                string fileExt = System.IO.Path.GetExtension(FileUpload1.FileName);
                FileUpload1.SaveAs(Server.MapPath("~/Images/") + FileUpload1.FileName);

            }

            //if any field missing give warning!
            //unused codes
            if (Literal1.Text == "" || startDateTB.Text == ""
                   || endDateTB.Text == "" || adCategoryTB.Text == "" || billboardDisplayTB.Text == "" || getvalue == "")
            {
                //alertWarning.Visible = true;

                //warningLocation.Text = "Please ensure you have filled in all required fields";
            }
            //if never agree to terms and conditions,display warning
            //unused codes
            else if (CheckBox1.Checked == false)
            {
                //alertWarning.Visible = true;

                //warningLocation.Text = "Please agree with T&C";
            }

            else
            {
                //alertWarning.Visible = false;

                DateTime aDate = DateTime.Now;
                imagelink = "Images/" + Literal1.Text;

                DateTime sdate = DateTime.Parse(startDateTB.Text);
                DateTime edate = DateTime.Parse(endDateTB.Text);

               
                   
                    int companyID = Convert.ToInt32(DropDownListCompany.SelectedItem.Value);
                    int AdvertisementID = GetMaxIDAdvertisement();
                    string mainconn = ConfigurationManager.ConnectionStrings["Targeted_Marketing_DisplayConnectionString"].ConnectionString;
                    SqlConnection sqlconn = new SqlConnection(Reference.Constr);
                    String adv = "Insert into [Advertisement](Name,Item,ItemType,Duration,CompanyID,StartDate,EndDate,Status,CreatedBy,CreatedOn)" +
                    " Values(@Name,@Item,@ItemType,@Duration,@CompanyID,@StartDate,@EndDate,@Status,@CreatedBy,@CreatedOn)";
                    SqlCommand sqlcomm = new SqlCommand(adv);
                    sqlcomm.Connection = sqlconn;
                    sqlconn.Open();
                if ((string)Session["userType"] == Reference.USR_ADM)
                {


                    sqlcomm.Parameters.AddWithValue("@CreatedOn", DateTime.Now);
                    sqlcomm.Parameters.AddWithValue("@Name", adNameTB.Text);
                    sqlcomm.Parameters.AddWithValue("@Item", imagelink);
                    sqlcomm.Parameters.AddWithValue("@ItemType", Literal2.Text);
                    sqlcomm.Parameters.AddWithValue("@StartDate", sdate);
                    sqlcomm.Parameters.AddWithValue("@EndDate", edate);
                    sqlcomm.Parameters.AddWithValue("@CompanyID", companyID);
                    sqlcomm.Parameters.AddWithValue("@Status", "1");
                    sqlcomm.Parameters.AddWithValue("@CreatedBy", "2");
                    sqlcomm.Parameters.AddWithValue("@Duration", videoDurationTB.Text);
                    sqlcomm.ExecuteNonQuery();
                    sqlconn.Close();
                }
                else
                {
                    User userObj = new User();
                    UserManagement uDao = new UserManagement();
                    userObj = uDao.getUserByID(Session["userID"].ToString());
                    sqlcomm.Parameters.AddWithValue("@CreatedOn", DateTime.Now);
                    sqlcomm.Parameters.AddWithValue("@Name", adNameTB.Text);
                    sqlcomm.Parameters.AddWithValue("@Item", imagelink);
                    sqlcomm.Parameters.AddWithValue("@ItemType", Literal2.Text);
                    sqlcomm.Parameters.AddWithValue("@StartDate", sdate);
                    sqlcomm.Parameters.AddWithValue("@EndDate", edate);
                    sqlcomm.Parameters.AddWithValue("@CompanyID", userObj.CompanyID);
                    sqlcomm.Parameters.AddWithValue("@Status", "1");
                    sqlcomm.Parameters.AddWithValue("@CreatedBy", "2");
                    sqlcomm.Parameters.AddWithValue("@Duration", videoDurationTB.Text);
                    sqlcomm.ExecuteNonQuery();
                    sqlconn.Close();
                }

                    SqlConnection sqlcon = new SqlConnection(Reference.Constr);
                    string sqlquery = "Insert into [AdvertisementCategory](AdvID,CategoryID) values(@AdvID,@CategoryID)";
                    SqlCommand sqlcom = new SqlCommand(sqlquery, sqlcon);
                    sqlcon.Open();
                    string str = adCategoryTB.Text;
                    string[] splitstr = str.Split(',');
                    int id = GetMaxIDAdvertisement();


                    foreach (string s in splitstr)
                    {
                        //trim the string, i.e. remove the space if any
                        string _s = s;
                        _s = _s.Trim();
                        sqlcom.Parameters.AddWithValue("@AdvID", id);
                        //sqlcom.Parameters.AddWithValue("@CategoryID", s);
                        sqlcom.Parameters.AddWithValue("@CategoryID", _s);
                        sqlcom.ExecuteNonQuery();
                        sqlcom.Parameters.Clear();
                    }


                    sqlcon.Close();



                List<int> ListOfID = new List<int>();
                SqlConnection sqlconnn = new SqlConnection(Reference.Constr);
                    string sqlqueryy = "Insert into [AdvertisementLocation](AdvID,BillboardID) values(@AdvID,@BillboardID)";
                    SqlCommand sqlcommm = new SqlCommand(sqlqueryy, sqlconnn);
                    sqlconnn.Open();

                    int AdvId = GetMaxIDAdvertisement();
                //Label bblabel = (Label)gvr.FindControl("lb_BillboardID");
                for (int i = 0; i < GridView1.Rows.Count; i++)
                    {
                    //Label bblabel = (Label)gvr.FindControl("lb_BillboardID");
                   // billboardDisplayTB.Text = billboardDisplayTB.Text + "," + bblabel.Text;
                    GridViewRow row = GridView1.Rows[i];
                        bool chkbx = ((CheckBox)row.FindControl("CheckBoxSelector")).Checked;
                        if (chkbx)
                        {
                            Label bblabel = (Label)GridView1.Rows[i].FindControl("lb_BillboardID");
                            sqlcommm.Parameters.AddWithValue("@BillboardID", Convert.ToInt32(bblabel.Text));
                            sqlcommm.Parameters.AddWithValue("@AdvID", AdvId);
                            sqlcommm.ExecuteNonQuery();
                            sqlcommm.Parameters.Clear();
                        }
                    }
                    sqlconnn.Close();




                    SqlConnection sqlcn = new SqlConnection(Reference.Constr);
                    string sqlque = "Insert into [AdvertisementAudience](AdvID,AgeID,GenderID) values(@AdvID,@AgeID,@GenderID)";
                    SqlCommand sqlcm = new SqlCommand(sqlque, sqlcn);
                    sqlcn.Open();

                    int ID_audience = GetMaxIDAdvertisement();


                    for (int i = 0; i < CheckBoxList2.Items.Count; i++)
                    {
                        if (CheckBoxList2.Items[i].Selected == true)
                        {

                            string stri = string.Empty;
                            stri = CheckBoxList2.Items[i].ToString();

                            if (stri.Contains("Male") & stri.Contains("Child"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "M");
                                sqlcm.Parameters.AddWithValue("@AgeID", "1");
                            }
                            else if (stri.Contains("Male") & stri.Contains("Young Adult"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "M");
                                sqlcm.Parameters.AddWithValue("@AgeID", "2");
                            }
                            else if (stri.Contains("Male") & stri.Contains("Age 31-65"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "M");
                                sqlcm.Parameters.AddWithValue("@AgeID", "3");
                            }
                            else if (stri.Contains("Male") & stri.Contains("Senior"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "M");
                                sqlcm.Parameters.AddWithValue("@AgeID", "4");
                            }
                            else if (stri.Contains("Female") & stri.Contains("Child"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "F");
                                sqlcm.Parameters.AddWithValue("@AgeID", "1");
                            }
                            else if (stri.Contains("Female") & stri.Contains("Young Adult"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "F");
                                sqlcm.Parameters.AddWithValue("@AgeID", "2");
                            }
                            else if (stri.Contains("Female") & stri.Contains("Age 31-65"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "F");
                                sqlcm.Parameters.AddWithValue("@AgeID", "3");
                            }
                            else if (stri.Contains("Female") & stri.Contains("Senior"))
                            {
                                sqlcm.Parameters.AddWithValue("@GenderID", "F");
                                sqlcm.Parameters.AddWithValue("@AgeID", "4");
                            }


                            sqlcm.Parameters.AddWithValue("@AdvID", ID_audience);
                            sqlcm.ExecuteNonQuery();
                            sqlcm.Parameters.Clear();

                        }

                    
                    
                    }

                sqlcn.Close();
                adNameTB.Text = string.Empty;
                DropDownListCompany.SelectedIndex = 0;
                startDateTB.Text = string.Empty;
                endDateTB.Text = string.Empty;
                videoDurationTB.Text = string.Empty;
                adCategoryTB.Text = string.Empty;
                billboardDisplayTB.Text = string.Empty;
                for (int i = 0; i < CheckBoxList1.Items.Count; i++)
                {
                    CheckBoxList1.Items[i].Selected = false;
                }
                for (int i = 0; i > CheckBoxList2.Items.Count; i++)
                {
                    CheckBoxList2.Items[i].Selected = false;
                }
                //alertWarning.Visible = false;
                //alertSuccess.Visible = true;
                Session["AdvertCreate"] = 2;
                Response.Redirect("AdvertList.aspx");
            }
            

        }


        



        protected void CategoryButton_Click(object sender, EventArgs e)
        {
            string name = "";
            for (int i = 0; i < CheckBoxList1.Items.Count; i++)
            {

                if (CheckBoxList1.Items[i].Selected)
                {

                    name = name + ", " + CheckBoxList1.Items[i].Value;

                }


            }

            adCategoryTB.Text = (name).Substring(1);
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

           

        }
      
        protected void BillboardSearch_Click(object sender, EventArgs e)
        {
            List<int> lstBillboardID = new List<int>();

            billboardDisplayTB.Text = "";
            foreach (GridViewRow gvr in GridView1.Rows)
            {
                if (gvr.RowType == DataControlRowType.DataRow)
                {
                    CheckBox cb = (CheckBox)(gvr.FindControl("CheckBoxSelector"));
                    if (cb.Checked == true)
                    {
                       // Label bblabel = (Label)gvr.FindControl("lb_BillboardID");
                        billboardDisplayTB.Text = billboardDisplayTB.Text + ", " + gvr.Cells[2].Text;
                       //  ListOfID.Add(Convert.ToInt32(bblabel.Text));
                    }
                }
            }

            if (billboardDisplayTB.Text != "")
            {
                billboardDisplayTB.Text = (billboardDisplayTB.Text).Substring(1); 
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "hideModal();", true);
        }

        //protected void btnRun_Click(object sender, EventArgs e)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
        //}

        protected void btnBack_User(object sender, EventArgs e)
        {
            Response.Redirect("AdvertList.aspx");
        }



    }
}


