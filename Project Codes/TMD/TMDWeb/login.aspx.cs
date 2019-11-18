using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using targeted_marketing_display;


namespace targeted_marketing_display
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
      
        }

        protected void login_onclick(object sender, EventArgs e)
        {
            string Email = unTB.Text;

            User userObj = new User();
            User userObj1 = new User();
            UserManagement uDao = new UserManagement();

            userObj1 = uDao.checkEmail(Email);

            int EmailMatch = 0;


            if (userObj1 != null)
            {
                EmailMatch = 1;
            }

            if (EmailMatch == 1)
            {
                userObj = uDao.getUserByEmail(Email);
                int pswdMatch = 1;

                //noted,CheEe(002):comment this to bypass the login!!!
               
                string pswdHash = userObj.PasswordHash;

                // convert into bytes
                byte[] hashbytes = Convert.FromBase64String(pswdHash);

                // take the salt out of the string
                byte[] salt = new byte[16];
                Array.Copy(hashbytes, 0, salt, 0, 16);

                // hash the entered password
                var pbkdf2 = new Rfc2898DeriveBytes(pwTB.Text, salt, 10000);

                byte[] hash = pbkdf2.GetBytes(20);

                for (int i = 0; i < 20; i++)
                {
                    if (hashbytes[i + 16] != hash[i])
                        pswdMatch = 0;
                }
          


                if (pswdMatch == 1)
                {
                    Session["userID"] = userObj.UserID;
                    //System.Diagnostics.Debug.Write(Session["userID"]);
                    Session["userType"] = userObj.Type;
                   
                    if ((string)Session["userType"] == Reference.USR_ADM || (string)Session["userType"] == Reference.USR_MEM)
                    {
                        Response.Redirect("ProfileInfo.aspx");
                    }
                } 
                else
                {
                    string script = "alert('Password is incorrect. Please re-enter the correct password.');";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
                }

            }
            else
            {
                string script = "alert('Email not registered. Please re-enter a correct email.');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        protected void fp_onclick(object sender, EventArgs e)
        {
            string Email = fpEmail.Text;
            string Pswd = CreatePassword(8);
            string lastUpdOn = DateTime.Now.ToString("MM/dd/yyyy h:mm tt");

            //string lastUpdBy = Session["userID"].ToString();
            //string lastUpdOn = DateTime.Now.ToString("MM/dd/yyyy h:mm tt");

            User userObj = new User();
            User userObj1 = new User();
            UserManagement uDao = new UserManagement();

            userObj1 = uDao.checkEmail(Email);

            int EmailMatch = 0;

            if (userObj1 != null)
            {
                EmailMatch = 1;
            }

            if (EmailMatch == 1) // if email matches
            {
                userObj = uDao.getUserByEmail(Email); // get email from sql

                // Password codes below
                // make a new byte array
                byte[] salt;

                // generate salt
                new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

                // hash and salt using PBKDF2
                var pbkdf2 = new Rfc2898DeriveBytes(Pswd, salt, 10000);

                // place string in byte array
                byte[] hash = pbkdf2.GetBytes(20);

                // make new byte array to store hashed password + salt
                // 36 --> 16(salt) + 20(hash)

                byte[] hashbytes = new byte[36];
                Array.Copy(salt, 0, hashbytes, 0, 16);
                Array.Copy(hash, 0, hashbytes, 16, 20);

                string PasswordHash = Convert.ToBase64String(hashbytes);
                string PasswordSalt = Convert.ToBase64String(salt);

                // Database codes insert below
                Boolean insCnt = uDao.updateUserPassword(Email, PasswordHash, PasswordSalt, lastUpdOn);

                // Email codes below
                string body = "Dear User, " + Environment.NewLine + Environment.NewLine + "Your Password Is Successfully Reset! " + Environment.NewLine + "This Is Your Current Login Password: " + Pswd + ". Please Proceed To Change Your Password Upon Your Login. Thank you. " + Environment.NewLine + Environment.NewLine + Environment.NewLine + "Regards, " + Environment.NewLine + "Targeted Marketing Admin Team";
                string subject = "Password Successfully Reset!";
                string toEmail = Email;
                sendMail(subject, body, toEmail);

                string script = "alert('Password successfully reset! Please check your new password at your email!');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
            else
            {
                string script = "alert('Email not registered. Please re-enter a correct email.');";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            }
        }

        public string CreatePassword(int length)
        {
            const string valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            while (0 < length--)
            {
                res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }

        protected void sendMail(string subject, string body, string toEmail)
        {
            var fromAddress = "tmdboss2019@gmail.com";
            var toAddress = toEmail;
            const string fromPassword = "swqa1234";
            var smtp = new System.Net.Mail.SmtpClient();
            {
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                smtp.Credentials = new NetworkCredential(fromAddress, fromPassword);

            }
            smtp.Send(fromAddress, toAddress, subject, body);
        }

    }
}
 