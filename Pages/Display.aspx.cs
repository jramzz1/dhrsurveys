using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.IO;

namespace DHRSurveys
{
    public partial class Test : System.Web.UI.Page
    {
        protected SqlConnection Connection()
        {
            // New sql connection to database
            return new SqlConnection(WebConfigurationManager.ConnectionStrings["AppWeb_Jesus"].ConnectionString);
        }
        public bool InputValidate(string command, int index)
        {
            // Used for looping through Textboxes
            string[] surveyItem = new string[3] { "txtFirstName", "txtLastName", "txtPhone" };

            // Regex variables for match validation
            Regex letters = new Regex(@"^[A-Za-z]+$");
            Regex validNums = new Regex(@"^[1-3]$");
            Regex phoneno = new Regex(@"^[0-9]{10}$");

            // On Update Button Click
            if (command == "Update")
            {
                // Loop through First and Last Name to see if valid
                for (int i = 0; i < 2; i++)
                    if (!letters.IsMatch((SurveyTBL.Rows[index].FindControl(surveyItem[i]) as TextBox).Text))
                        return false;

                // Check Phone# Field if valid
                if (!phoneno.IsMatch((SurveyTBL.Rows[index].FindControl("txtPhone") as TextBox).Text)
                    || Int64.Parse((SurveyTBL.Rows[index].FindControl("txtPhone") as TextBox).Text) == 0)
                    return false;

                // Check if Inputs besides PhoneNumber were changed, if yes skip database validation (return true)
                if (saveFirst.Text != (SurveyTBL.Rows[index].FindControl("txtFirstName") as TextBox).Text ||
                    saveLast.Text != (SurveyTBL.Rows[index].FindControl("txtLastName") as TextBox).Text)
                    return true;

                // Check if changes have been made to Question responses, if yes skip database validation (return true)
                // compares saved values on edit click and values on save click
                // creates a string of values to compare
                string responseEdit = "";

                for (int i = 0; i < 5; ++i)
                    responseEdit += (SurveyTBL.Rows[index].FindControl("txtQ" + (i + 1).ToString()) as DropDownList).SelectedValue;

                if (responseEdit != saveResponse.Text)
                    return true;

                // Check if Phone Number already in Database
                if (phoneno.IsMatch((SurveyTBL.Rows[index].FindControl("txtPhone") as TextBox).Text))   //Valid Input
                {
                    SqlConnection sqlConn = Connection();
                    SqlCommand sqlComm = sqlConn.CreateCommand();
                    sqlComm.CommandText = "SELECT * FROM tbl_SurveyResponses WHERE pat_phone = @pat_phone";
                    sqlComm.Parameters.Add("@pat_phone", SqlDbType.BigInt).Value = Int64.Parse((SurveyTBL.Rows[index].FindControl("txtPhone") as TextBox).Text);
                    sqlConn.Open();

                    // If Execute returns back a data entry, means there is already a survey with this phone number so return false
                    if (sqlComm.ExecuteScalar() != null)
                    {
                        sqlConn.Close();
                        SurveyTBL.EditIndex = index;
                        GenerateTable();
                        return false;
                    }
                    // Otherwise Execute found nothing so close connection and continue (validated)
                    else
                        sqlConn.Close();
                }
            }

            // On Add Button Click
            if (command == "Add")
            {
                // Loop through First and Last Name to see if valid
                for (int i = 0; i < 2; i++)
                    if (!letters.IsMatch((SurveyTBL.FooterRow.FindControl(surveyItem[i] + "Footer") as TextBox).Text))
                        return false;

                // Check Phone# Field if valid
                if (!phoneno.IsMatch((SurveyTBL.FooterRow.FindControl("txtPhone" + "Footer") as TextBox).Text)
                    || Int64.Parse((SurveyTBL.FooterRow.FindControl("txtPhone" + "Footer") as TextBox).Text) == 0)
                    return false;

                // Check if Question Responses are valid (not really necessary as only available options are 1-3 not able to input anything else)
                for (int i = 0; i < 5; i++)
                    if (!validNums.IsMatch((SurveyTBL.FooterRow.FindControl("txtQ" + (i+1).ToString() + "Footer") as DropDownList).SelectedValue))
                        return false;

                // Check if Phone Number already in Database
                if (phoneno.IsMatch((SurveyTBL.FooterRow.FindControl("txtPhoneFooter") as TextBox).Text))   //Valid Input
                {
                    SqlConnection sqlConn = Connection();
                    SqlCommand sqlComm = sqlConn.CreateCommand();
                    sqlComm.CommandText = "SELECT * FROM tbl_SurveyResponses WHERE pat_phone = @pat_phone";
                    sqlComm.Parameters.Add("@pat_phone", SqlDbType.BigInt).Value = Int64.Parse((SurveyTBL.FooterRow.FindControl("txtPhoneFooter") as TextBox).Text);
                    sqlConn.Open();

                    // If Execute returns back a data entry, means there is already a survey with this phone number so return false
                    if (sqlComm.ExecuteScalar() != null)
                    {
                        sqlConn.Close();
                        return false;
                    }
                    // Otherwise Execute found nothing so close connection and continue (validated)
                    else
                        sqlConn.Close();
                }
                // Everything validated correctly
                return true;
            }
            return true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Generate new table to Page Load
            if (!IsPostBack) GenerateTable();
        }

        // Generates Table from database
        void GenerateTable()
        {
            // Create new Datatable and connect to Database
            DataTable dt = new DataTable();
            using (SqlConnection sqlConn = Connection())
            {
                sqlConn.Open();
                SqlDataAdapter sqlData = new SqlDataAdapter("SELECT * FROM tbl_SurveyResponses", sqlConn);
                sqlData.Fill(dt);
            }

            // If rows found there is data, Bind to GridView
            if (dt.Rows.Count > 0)
            {
                SurveyTBL.DataSource = dt;
                SurveyTBL.DataBind();
            }

            // No data found in database create new row displaying "No Data Found"
            else
            {
                dt.Rows.Add(dt.NewRow());
                SurveyTBL.DataSource = dt;
                SurveyTBL.DataBind();
                SurveyTBL.Rows[0].Cells.Clear();
                SurveyTBL.Rows[0].Cells.Add(new TableCell());
                SurveyTBL.Rows[0].Cells[0].ColumnSpan = dt.Columns.Count;
                SurveyTBL.Rows[0].Cells[0].Text = "No Data Found";
                SurveyTBL.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
        }

        // On Save Button Press add new database entry
        protected void SurveyTBL_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add"))
            {
                if (InputValidate("Add", 0))
                {
                    //SQL Code to be used when writing a brand new record.
                    SqlConnection sqlConn = Connection();
                    SqlCommand sqlComm = sqlConn.CreateCommand();
                    sqlComm.CommandText = @"INSERT INTO [tbl_SurveyResponses] ( [pat_first],[pat_last],[pat_phone],[survey_datetime],[Q1_Response],[Q2_Response],[Q3_Response],[Q4_Response],[Q5_Response]) VALUES ( @pat_first,@pat_last,@pat_phone,@survey_datetime,@Q1_Response,@Q2_Response,@Q3_Response,@Q4_Response,@Q5_Response) SET @ID = SCOPE_IDENTITY(); ";
                    sqlComm.Parameters.Add("@ID", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

                    sqlComm.Parameters.Add("@pat_first", SqlDbType.VarChar).Value = (SurveyTBL.FooterRow.FindControl("txtFirstNameFooter") as TextBox).Text.Trim();
                    sqlComm.Parameters.Add("@pat_last", SqlDbType.VarChar).Value = (SurveyTBL.FooterRow.FindControl("txtLastNameFooter") as TextBox).Text.Trim();
                    sqlComm.Parameters.Add("@pat_phone", SqlDbType.BigInt).Value = Int64.Parse((SurveyTBL.FooterRow.FindControl("txtPhoneFooter") as TextBox).Text.Trim(new Char[] { ' ', '-', '(', ')' }));
                    sqlComm.Parameters.Add("@survey_datetime", SqlDbType.DateTime).Value = DateTime.Now;
                    for (int i = 1; i < 6; ++i)
                        sqlComm.Parameters.Add("@Q" + i + "_Response", SqlDbType.Int).Value = Convert.ToInt32((SurveyTBL.FooterRow.FindControl("txtQ" + i + "Footer") as DropDownList).SelectedValue);

                    try
                    {
                        sqlConn.Open();
                        sqlComm.ExecuteNonQuery();
                        GenerateTable();
                        AlertMessage("Survey Entry Added");
                        sqlConn.Close();
                    }

                    catch
                    {
                        //Error - unable to add survey entry
                        AlertMessage("Unable to add Survey.");
                    }
                }

                else
                    AlertMessage("Invalid Input Fields, Unable to Insert Survey Entry.");
            }
        }

        // On Edit Button Press sets row into edit mode
        protected void SurveyTBL_RowEditing(object sender, GridViewEditEventArgs e)
        {
            MessageShow.Visible = false;
            SurveyTBL.EditIndex = e.NewEditIndex;
            GenerateTable();
            saveFirst.Text = (SurveyTBL.Rows[SurveyTBL.EditIndex].FindControl("txtFirstName") as TextBox).Text;     // Stores current text for first name
            saveLast.Text = (SurveyTBL.Rows[SurveyTBL.EditIndex].FindControl("txtLastName") as TextBox).Text;       // Store current text for last name

            // Creates and stores text for current question answers
            saveResponse.Text = "";
            for (int i = 0; i < 5; ++i)
                saveResponse.Text += (SurveyTBL.Rows[SurveyTBL.EditIndex].FindControl("txtQ" + (i + 1).ToString()) as DropDownList).SelectedValue;

            
        }

        // On Cancel Button Press Exit out of edit mode and re-draw table
        protected void SurveyTBL_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            AlertMessage("No changes made");
            SurveyTBL.EditIndex = -1;
            GenerateTable();
        }

        // Update Database Entry
        protected void SurveyTBL_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {            
            if (InputValidate("Update", e.RowIndex))
            {
                SqlConnection sqlConn = Connection();
                SqlCommand sqlComm = sqlConn.CreateCommand();

                //SQL Code to be used when writing a brand new record.     
                sqlComm.CommandText = "UPDATE tbl_SurveyResponses SET pat_first = @pat_first, pat_last = @pat_last, pat_phone = @pat_phone, survey_datetime = @survey_datetime, Q1_Response = @Q1_Response, Q2_Response = @Q2_Response,  Q3_Response = @Q3_Response, Q4_Response = @Q4_Response, Q5_Response = @Q5_Response WHERE ID = @id";

                sqlComm.Parameters.Add("@pat_first", SqlDbType.VarChar).Value = (SurveyTBL.Rows[e.RowIndex].FindControl("txtFirstName") as TextBox).Text.Trim();
                sqlComm.Parameters.Add("@pat_last", SqlDbType.VarChar).Value = (SurveyTBL.Rows[e.RowIndex].FindControl("txtLastName") as TextBox).Text.Trim();
                sqlComm.Parameters.Add("@pat_phone", SqlDbType.BigInt).Value = Int64.Parse((SurveyTBL.Rows[e.RowIndex].FindControl("txtPhone") as TextBox).Text.Trim(new Char[] { ' ', '-', '(', ')' }));
                sqlComm.Parameters.Add("@survey_datetime", SqlDbType.DateTime).Value = DateTime.Now;
                for(int i = 1; i < 6; ++i)
                    sqlComm.Parameters.Add("@Q" + i + "_Response", SqlDbType.Int).Value = Convert.ToInt32((SurveyTBL.Rows[e.RowIndex].FindControl("txtQ" + i) as DropDownList).SelectedValue);
                sqlComm.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(SurveyTBL.DataKeys[e.RowIndex].Value.ToString());

                try
                {
                    sqlConn.Open();
                    sqlComm.ExecuteNonQuery();
                    SurveyTBL.EditIndex = -1;
                    GenerateTable();
                    AlertMessage("Survey Entry Updated");
                    sqlConn.Close();
                }
                catch
                {
                    //Error - unable to update survey entry
                    AlertMessage("Survey Entry Unable to Update");
                }
            }
            else
            {
                SurveyTBL.EditIndex = -1;
                GenerateTable();
                AlertMessage("No changes made");
            }

        }

        // Delete Database Entry
        protected void SurveyTBL_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection sqlConn = Connection();
            SqlCommand sqlComm = sqlConn.CreateCommand();

            //SQL Code to be used when writing a brand new record.     
            sqlComm.CommandText = "DELETE FROM tbl_SurveyResponses WHERE ID = @id";
            sqlComm.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(SurveyTBL.DataKeys[e.RowIndex].Value.ToString());

            try
            {
                sqlConn.Open();
                sqlComm.ExecuteNonQuery();
                GenerateTable();
                AlertMessage("Survey Entry Deleted");
                sqlConn.Close();
            }
            catch
            {
                //Error - unable to delete survey entry
                AlertMessage("Survey Entry Unable to Delete");
            }
        }

        protected void AlertMessage(string alert)
        {
            MessageShow.Visible = true;
            MessageShow.InnerHtml = alert;
        }

        protected void SurveyTBL_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            SurveyTBL.PageIndex = e.NewPageIndex;
            MessageShow.Visible = false;
            GenerateTable();
        }
    }
}