<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionarCuentas.aspx.cs" Inherits="Clase05.GestionarCuentas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Menu.aspx">Volver</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Cuentas:"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Agregar" OnClick="Button1_Click" />
            <br />
            <asp:Label ID="Label2" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Table runat="server" ID="Table1" CssClass="table table-dark"></asp:Table>
            <br />
            <br />
            <asp:ListBox ID="ListBox1" runat="server" DataTextField="descripcion" DataValueField="id" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
            <br />
            <br />
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" Text="Modificar" OnClick="Button2_Click" />
            <asp:Button ID="Button3" runat="server" Text="Eliminar" OnClick="Button3_Click" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" DeleteCommand="DELETE FROM [Cuentas] WHERE [id] = @id" InsertCommand="INSERT INTO [Cuentas] ([descripcion]) VALUES (@descripcion)" ProviderName="<%$ ConnectionStrings:cadena.ProviderName %>" SelectCommand="SELECT * FROM [Cuentas]" UpdateCommand="UPDATE [Cuentas] SET [descripcion] = @descripcion WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="descripcion" Type="String"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="descripcion" Type="String"></asp:Parameter>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div>
            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [Cuentas] WHERE ([id] = @id)" ID="SqlDataSource2">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ListBox1" PropertyName="SelectedValue" Name="id" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            &nbsp;</div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
