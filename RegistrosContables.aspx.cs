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
    public partial class RegistrosContables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                completarTabla();
            }
        }

        protected void completarTabla()
        {
            try
            {
                DataView dv = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);


                if (dv != null && dv.Count > 0)
                {
                    // Rellenar cabecera
                    TableRow headerRow = new TableRow();

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "Cuenta";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Monto";
                    headerRow.Cells.Add(headerCell2);

                    TableCell headerCell3 = new TableCell();
                    headerCell3.Text = "Estado";
                    headerRow.Cells.Add(headerCell3);

                    Table1.Rows.Add(headerRow);

                    // Rellenar las filas
                    foreach (DataRowView rowView in dv)
                    {
                        DataRow row = rowView.Row;
                        TableRow tableRow = new TableRow();

                        TableCell cell1 = new TableCell();
                        cell1.Text = row["descripcion"].ToString();
                        tableRow.Cells.Add(cell1);

                        TableCell cell2 = new TableCell();
                        cell2.Text = row["monto"].ToString();
                        tableRow.Cells.Add(cell2);


                        TableCell cell3 = new TableCell();
                        bool estadoValue;
                        if (bool.TryParse(row["estado"].ToString(), out estadoValue))
                        {
                            if (estadoValue)
                            {
                                cell3.Text = "Haber";
                            }
                            else
                            {
                                cell3.Text = "Debe";
                            }
                        }
                        else
                        {
                            cell3.Text = "Valor no válido";
                        }

                        tableRow.Cells.Add(cell3);


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
                SqlDataSource2.InsertParameters["idCuenta"].DefaultValue = DropDownList1.SelectedValue;
                SqlDataSource2.InsertParameters["monto"].DefaultValue = TextBox1.Text;

                // Obtén el valor booleano del CheckBox
                bool estado = CheckBox1.Checked;
                SqlDataSource2.InsertParameters["estado"].DefaultValue = estado.ToString();

                int result = SqlDataSource2.Insert();
                if (result > 0)
                {
                    Label2.Text = "Se ha agregado correctamente";
                    TextBox1.Text = string.Empty;
                    completarTabla();

                    // No necesitas limpiar el CheckBox porque los checkboxes no tienen Text
                }
                else
                {
                    Label2.Text = "No se agregaron registros.";
                }
            }
            catch (SqlException)
            {
                Label2.Text = "Se ha producido un error.";
            }


        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource2.UpdateParameters["idCuenta"].DefaultValue = DropDownList1.SelectedValue;
                SqlDataSource2.UpdateParameters["monto"].DefaultValue = TextBox1.Text;

                bool estado = CheckBox1.Checked;
                SqlDataSource2.UpdateParameters["estado"].DefaultValue = estado.ToString();

                SqlDataSource2.UpdateParameters["id"].DefaultValue = DropDownList2.SelectedValue;

                int result = SqlDataSource2.Update();
                if (result > 0)
                {
                    Label2.Text = "Se ha modificado correctamente";
                    TextBox1.Text = string.Empty;
                    completarTabla();
                }
                else
                {
                    Label2.Text = "No se han modificado los registros.";
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
                int result = SqlDataSource3.Delete();
                if (result > 0)
                {
                    Label2.Text = "Se ha borrado correctamente.";
                    completarTabla();
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

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
            if (dv != null && dv.Count > 0)
            {
                DataRowView row = dv[0];
                //Creo que deberia ser "DropDownList1.SelectedValue" pero me tira error :(
                DropDownList2.SelectedValue = row["id"].ToString();
                TextBox1.Text = row["monto"].ToString();

                // Obtener el valor booleano del campo "estado"
                bool estado;
                if (bool.TryParse(row["estado"].ToString(), out estado))
                {
                    CheckBox1.Checked = estado;
                }
                else
                {
                    CheckBox1.Checked = false;
                }
            }

            completarTabla();

        }
    }
}