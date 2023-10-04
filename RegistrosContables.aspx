<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrosContables.aspx.cs" Inherits="Clase05.RegistrosContables" %>

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
            <asp:Label ID="Label1" runat="server" Text="Registros Contables"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Agregar un registro:"></asp:Label>
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" DataTextField="descripcion" DataValueField="id" DataSourceID="SqlDataSource1"></asp:DropDownList>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="Monto" TextMode="Number" AutoCompleteType="Disabled"></asp:TextBox>
            <asp:CheckBox runat="server" Text="Haber" ID="CheckBox1"></asp:CheckBox>
            <asp:Button ID="Button1" runat="server" Text="Agregar" OnClick="Button1_Click" />   
            <asp:Button ID="Button2" runat="server" Text="Modificar" OnClick="Button2_Click" />
            <br />
            <asp:Label ID="Label2" runat="server"></asp:Label>
            <br />
            <br />
            <asp:DropDownList ID="DropDownList2" runat="server" DataTextField="descripcion" DataValueField="id" DataSourceID="SqlDataSource3" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
            <asp:Button ID="Button3" runat="server" Text="Eliminar" OnClick="Button3_Click" />
            <br />
            <br />
            <asp:Table ID="Table1" runat="server" CssClass="table table-dark"></asp:Table>
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [Cuentas]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO [RegistrosContables] ([idCuenta], [monto], [estado]) VALUES (@idCuenta, @monto, @estado)" SelectCommand="SELECT * FROM [RegistrosContables]" UpdateCommand="UPDATE [RegistrosContables] SET [idCuenta] = @idCuenta, [monto] = @monto, [estado] = @estado WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="idCuenta" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="monto" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="estado" Type="Boolean"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="idCuenta" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="monto" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="estado" Type="Boolean"></asp:Parameter>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT RegistrosContables.id, RegistrosContables.monto, RegistrosContables.estado, Cuentas.descripcion, RegistrosContables.idCuenta FROM RegistrosContables INNER JOIN Cuentas ON RegistrosContables.idCuenta = Cuentas.id" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="DropDownList2" PropertyName="SelectedValue" Name="id"></asp:ControlParameter>
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [RegistrosContables] WHERE ([id] = @id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" PropertyName="SelectedValue" Name="id" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
