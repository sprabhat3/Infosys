using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Configuration;

namespace Infosys
{
    public partial class RegistrationForm : System.Web.UI.Page
    {
        //Connection in Web.config file
        //single Stored Procedure "InfosysProc"
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Infosys"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
                Clear();
                Gender();
                Country();
                ddlstate.Items.Insert(0, new ListItem("--Select--", "0"));

            }
        }
        public void Clear()
        {
            txtname.Text = "";
            txtemail.Text = "";
            txtdob.Text = "";
            txtsalary.Text = "";
            rblgender.ClearSelection();
            cblskills.ClearSelection();
            ddlcountry.SelectedValue = "1";
            ddlstate.SelectedValue = "0";
        }
        public void Show()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("InfosysProc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "SHOW");
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            gvregistration.DataSource = dt;
            gvregistration.DataBind();
        }
        public void Gender()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("InfosysProc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "GENDER");
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            rblgender.DataValueField = "gender_id";
            rblgender.DataTextField = "gender_name";
            rblgender.DataSource = dt;
            rblgender.DataBind();
        }

        public void Country()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("InfosysProc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "COUNTRY");
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            ddlcountry.DataValueField = "country_id";
            ddlcountry.DataTextField = "country_name";
            ddlcountry.DataSource = dt;
            ddlcountry.DataBind();
        }

        public void State()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("InfosysProc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "STATE");
            cmd.Parameters.AddWithValue("@country_id", ddlcountry.SelectedValue);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            ddlstate.DataValueField = "state_id";
            ddlstate.DataTextField = "state_name";
            ddlstate.DataSource = dt;
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            State();
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            string str = "";
            for (int i=0; i<cblskills.Items.Count;i++)
            {
                if (cblskills.Items[i].Selected == true)
                {
                    str += cblskills.Items[i].Text + ",";
                }
            }
            str=str.TrimEnd();
            if (btnsave.Text == "Save")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("InfosysProc", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@action", "INSERT");
                cmd.Parameters.AddWithValue("@user_name", txtname.Text);
                cmd.Parameters.AddWithValue("@user_email", txtemail.Text);
                cmd.Parameters.AddWithValue("@user_skills", str);
                cmd.Parameters.AddWithValue("@user_salary", txtsalary.Text);
                cmd.Parameters.AddWithValue("@user_gender", rblgender.SelectedValue);
                cmd.Parameters.AddWithValue("@user_country", ddlcountry.SelectedValue);
                cmd.Parameters.AddWithValue("@user_state", ddlstate.SelectedValue);
                cmd.Parameters.AddWithValue("@user_dob", txtdob.Text);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                //for Sussess Msg
                if (i == 1)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Record Saved Successfully!!');", true);
                }
            }
            else if (btnsave.Text == "Update")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("InfosysProc", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@action", "UPDATE");
                cmd.Parameters.AddWithValue("@user_name", txtname.Text);
                cmd.Parameters.AddWithValue("@user_email", txtemail.Text);
                cmd.Parameters.AddWithValue("@user_skills", str);
                cmd.Parameters.AddWithValue("@user_salary", txtsalary.Text);
                cmd.Parameters.AddWithValue("@user_gender", rblgender.SelectedValue);
                cmd.Parameters.AddWithValue("@user_country", ddlcountry.SelectedValue);
                cmd.Parameters.AddWithValue("@user_dob", txtdob.Text);
                cmd.Parameters.AddWithValue("@user_state", ddlstate.SelectedValue);
                cmd.Parameters.AddWithValue("@user_id", ViewState["ID"]);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i == 1)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Record Updated Successfully!!');", true);
                }
                btnsave.Text = "Save";
            }
            Show();
            Clear();
        }

        protected void gvregistration_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Del")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("InfosysProc", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@action", "DELETE");
                cmd.Parameters.AddWithValue("@user_id", e.CommandArgument);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i == 1)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Record Deleted Successfully!!');", true);
                }
                Show();

            }
            else if (e.CommandName == "Edi")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("InfosysProc", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@action", "EDIT");
                cmd.Parameters.AddWithValue("@user_id", e.CommandArgument);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                txtname.Text = dt.Rows[0]["user_name"].ToString();
                txtemail.Text = dt.Rows[0]["user_email"].ToString();
                txtdob.Text = dt.Rows[0]["user_dob"].ToString();
                txtsalary.Text = dt.Rows[0]["user_salary"].ToString();
                rblgender.SelectedValue = dt.Rows[0]["user_gender"].ToString();
                ddlcountry.SelectedValue = dt.Rows[0]["user_country"].ToString();
                State();
                ddlstate.SelectedValue = dt.Rows[0]["user_state"].ToString();
                string[] arr = dt.Rows[0]["user_skills"].ToString().Split(',');
                cblskills.ClearSelection();
                for(int i = 0; i < cblskills.Items.Count; i++)
                {
                    for(int j=0; j<arr.Length;j++)
                    {
                        if (cblskills.Items[i].Text == arr[j])
                        {
                            cblskills.Items[i].Selected = true;
                        }
                    }
                }
                btnsave.Text = "Update";
                ViewState["ID"] = e.CommandArgument;
            }
        }
    }
}