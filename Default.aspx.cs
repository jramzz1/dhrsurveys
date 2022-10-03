using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Diagnostics;
using System.Text.RegularExpressions;

public static class MessageBox
{
    public static void Show(this Page Page, String Message)
    {
        Page.ClientScript.RegisterStartupScript(
           Page.GetType(),
           "MessageBox",
           "<script language='javascript'>alert('" + Message + "');</script>"
        );
    }
}

namespace DHRSurveys
{
    public partial class Default : System.Web.UI.Page
    {
        SqlConnection sqlConn = new SqlConnection(WebConfigurationManager.ConnectionStrings["AppWeb_Jesus"].ConnectionString);
        int[] ratings = new int[5];
        int check_sql_save = 0;
        object found = new object();

        protected bool RadioValidate()
        {
            bool response = false;

            // Loop through radios and assign value if checked (Unable to use .Value or convert .Text to int)
            RadioButton[] radios = new RadioButton[15] { Q1B, Q1N, Q1E, Q2B, Q2N, Q2E, Q3B, Q3N, Q3E, Q4B, Q4N, Q4E, Q5B, Q5N, Q5E };

            for (int radIndex = 0, ratIndex = 0, value = 1; radIndex < 15; radIndex++, value++)
            {
                if (radios[radIndex].Checked)       // If radio is checked assign value (1,2,3) and increment ratings index by 1
                {
                    ratings[ratIndex] = value;
                    ratIndex++;
                }
                if (value % 3 == 0) value = 0;    // If value reached reset (loop back will increment 1)
            }

            // Server side validation for radio selection, if not selected inform user of which question is missing
            for (int i = 0; i < 5; ++i)
            if (ratings[i] == 0)
            {
                radioError.Text = "You must enter a response for question " + (i + 1).ToString() + ".";
                response = false;
            }
            else
                response = true;

            return response;
        }

        protected bool InDatabase()
        {
            SqlCommand sqlComm = sqlConn.CreateCommand();

            // Check to see if already submitted by looking up phone number
            sqlComm.CommandText = "SELECT * FROM tbl_SurveyResponses WHERE pat_phone = @pat_phone";
            string result = Regex.Replace(pat_phone.Text, @"[^0-9]", "");
            sqlComm.Parameters.Add("@pat_phone", SqlDbType.BigInt).Value = Int64.Parse(result);

            try
            {
                sqlConn.Open();
                found = sqlComm.ExecuteScalar();
                sqlConn.Close();
                sqlComm.CommandText = "";
            }
            catch(SqlException ex)
            {
                //Error - was unable to create row, so return 0
                Debug.WriteLine(ex.Message);
                radioError.Text = "survey response already submitted.";
                sqlConn.Close();
            }

            if (found == null) return false;
            else return true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if(InDatabase()) return;
            if(!RadioValidate()) return;

            SqlCommand sqlComm = sqlConn.CreateCommand();

            //SQL Code to be used when writing a brand new record.     
            sqlComm.CommandText = @"INSERT INTO [tbl_SurveyResponses] ( [pat_first],[pat_last],[pat_phone],[survey_datetime],[Q1_Response],[Q2_Response],[Q3_Response],[Q4_Response],[Q5_Response]) VALUES ( @pat_first,@pat_last,@pat_phone,@survey_datetime,@Q1_Response,@Q2_Response,@Q3_Response,@Q4_Response,@Q5_Response) SET @ID = SCOPE_IDENTITY(); ";
            sqlComm.Parameters.Add("@ID", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

            sqlComm.Parameters.Add("@pat_first", SqlDbType.VarChar).Value = first.Text;
            sqlComm.Parameters.Add("@pat_last", SqlDbType.VarChar).Value = last.Text;
            string result = Regex.Replace(pat_phone.Text, @"[^0-9]", "");
            sqlComm.Parameters.Add("@pat_phone", SqlDbType.BigInt).Value = Int64.Parse(result);
            sqlComm.Parameters.Add("@survey_datetime", SqlDbType.DateTime).Value = DateTime.Now;
            sqlComm.Parameters.Add("@Q1_Response", SqlDbType.Int).Value = Convert.ToInt32(ratings[0]);
            sqlComm.Parameters.Add("@Q2_Response", SqlDbType.Int).Value = Convert.ToInt32(ratings[1]);
            sqlComm.Parameters.Add("@Q3_Response", SqlDbType.Int).Value = Convert.ToInt32(ratings[2]);
            sqlComm.Parameters.Add("@Q4_Response", SqlDbType.Int).Value = Convert.ToInt32(ratings[3]);
            sqlComm.Parameters.Add("@Q5_Response", SqlDbType.Int).Value = Convert.ToInt32(ratings[4]);

            if (found == null)
            {
                try
                {
                    sqlConn.Open();
                    check_sql_save = sqlComm.ExecuteNonQuery();
                    sqlConn.Close();
                }
                catch (SqlException ex)
                {
                    //error - was unable to create row, so return 0
                    Debug.WriteLine(ex.Message);
                    sqlConn.Close();
                }

                if (check_sql_save != 1)
                {
                    // no entry.
                    //Did not work
                    Response.Redirect("/Default.aspx");
                    radioError.Text = "Unable to record survey entry.";
                    //the save was not successful.
                }
                if (check_sql_save == 1)
                {
                    //successful entry, redirect.
                    Response.Redirect("/surveytest/Pages/Thanks.aspx");   
                }
            }
            else
                radioError.Text = "survey response already submitted.";
        }
    }
}