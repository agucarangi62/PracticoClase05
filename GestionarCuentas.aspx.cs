using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Clase05
{
    public partial class GestionarCuentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                actualizarLabel();
            }
        }

        protected void actualizarLabel()
        {
            try
            {
                DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);


                if (dv != null && dv.Count > 0)
                {
                    // Rellenar cabecera
                    TableRow headerRow = new TableRow();

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "id";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Cuenta";
                    headerRow.Cells.Add(headerCell2);

                    Table1.Rows.Add(headerRow);

                    // Rellenar las filas
                    foreach (DataRowView rowView in dv)
                    {
                        DataRow row = rowView.Row;
                        TableRow tableRow = new TableRow();

                        TableCell cell1 = new TableCell();
                        cell1.Text = row["id"].ToString();
                        tableRow.Cells.Add(cell1);

                        TableCell cell2 = new TableCell();
                        cell2.Text = row["descripcion"].ToString();
                        tableRow.Cells.Add(cell2);

                        Table1.Rows.Add(tableRow);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", $"alert('Error');", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource1.InsertParameters["descripcion"].DefaultValue = TextBox1.Text;
                int result = SqlDataSource1.Insert();
                if (result > 0)
                {
                    Label2.Text = "Se ha agregado correctamente.";
                    actualizarLabel();
                    TextBox1.Text = "";
                }
                else
                {
                    Label2.Text = "No se agregaron registros.";
                }
            }
            catch (SqlException)
            {
                Label2.Text = "Complete todos los datos";
            }
        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Esto trae solo el ID del item
            //TextBox2.Text = ListBox1.SelectedValue.ToString();

            //Para que traiga lo que muestra el listbox y no el id de esos items
            SqlDataSource2.DataSourceMode = SqlDataSourceMode.DataReader;
            SqlDataReader reader = (SqlDataReader)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            if (reader.Read())
            {
                TextBox2.Text = reader["descripcion"].ToString();
                actualizarLabel();
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource1.UpdateParameters["id"].DefaultValue = ListBox1.SelectedValue.ToString();
                SqlDataSource1.UpdateParameters["descripcion"].DefaultValue = TextBox2.Text;
                int result = SqlDataSource1.Update();
                if (result > 0)
                {
                    Label2.Text = "Se ha modificado correctamente.";
                    actualizarLabel();
                    TextBox2.Text = "";
                }
                else
                {
                    Label2.Text = "No se modifico el registro.";
                }
            }
            catch (SqlException)
            {
                Label2.Text = "Se ha producido un error.";

            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource1.DeleteParameters["id"].DefaultValue = ListBox1.SelectedValue;
                int result = SqlDataSource1.Delete();
                if (result > 0)
                {
                    Label2.Text = "Se ha borrado correctamente.";
                    actualizarLabel();
                    TextBox2.Text = "";
                }
                else
                {
                    Label2.Text = "No se borro el registro.";
                }
            }
            catch (SqlException)
            {
                Label2.Text = "Se ha producido un error.";

            }
        }

    }
}