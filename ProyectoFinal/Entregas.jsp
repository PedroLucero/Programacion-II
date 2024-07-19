<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="oracle.jdbc.driver.OracleDriver" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Entregas</title>
    <link rel="stylesheet" href="stylesEntregas.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
</head>

<body>
    <header>
        <img src="nb-logow.png" alt="Logo" class="logo">
        <div class="iconos">
            <a class="icono" href="https://www.google.com"><img src="lupa-1.png"></a>
            <a class="icono" href="https://www.instagram.com"><img src="instagram-1.png"></a>
            <a class="icono" href="https://www.tiktok.com/discover?lang=es"><img src="tik-tok.png"></a>
            <a class="icono" href="https://www.pinterest.com"><img src="pinterest.png"></a>
        </div>
    </header>

    <div class="container">
        <nav class="nav-superior">
            <ul class="nav-ul-superior">
                <li class="opcion"><a class="menu-superior" href="MainColaborador.jsp">PERFIL DEL COLABORADOR</a></li>
                <li class="opcion"><a class="menu-superior" href="inventario.jsp">INVENTARIO</a></li>
                <li class="opcion"><a class="menu-superior" href="Contacto.html">CONTACTO</a></li>
                <li id="login"><a class="menu-superior" href="LogInDefault.jsp">INICIAR SESION</a></li>
            </ul>
        </nav>

        <div class="content">
            <section id="home" class="banner">
                <div class="container_banner">
                    <h2>Bienvenidos a The Art Of Kitchen</h2>
                    <p id="slogan">"Crafting Culinary Elegance"</p>
                </div>
            </section>

            <div class="table-container">
                <table id="entregasTable" class="display">
                    <thead>
                        <tr>
                            <th>REPARTIDOR</th>
                            <th>#FACTURA</th>
                            <th>CLIENTE</th>
                            <th>FECHA</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Properties prop = new Properties();
                            String configPath = application.getRealPath("WEB-INF/config.properties");
                            try (InputStream input = new FileInputStream(configPath)) {
                                prop.load(input);
                            } catch (Exception e) {
                                out.println("Archivo config error: " + e.getMessage());
                            }

                            String jdbcUrl = "jdbc:oracle:thin:@//localhost:1521/XE";
                            String dbUsername = prop.getProperty("db.username");
                            String dbPassword = prop.getProperty("db.password");

                            Connection conn = null;
                            PreparedStatement stmt = null;
                            ResultSet rs = null;

                            try {
                                // Cargar el controlador JDBC de Oracle
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                // Establecer la conexión
                                conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                                // Preparar la consulta SQL
                                String query = "SELECT r.nombre AS repartidor, e.num_factura, e.fecha_asignada, c.nombre AS cliente " +
                                               "FROM entrega e " +
                                               "JOIN repartidor r ON e.id_repartidor = r.id " +
                                               "JOIN venta v ON e.num_factura = v.num_factura " +
                                               "JOIN cliente c ON v.id_cliente = c.id";
                                stmt = conn.prepareStatement(query);

                                // Ejecutar la consulta
                                rs = stmt.executeQuery();

                                // Mostrar resultados
                                while (rs.next()) {
                                    String repartidor = rs.getString("repartidor");
                                    int numFactura = rs.getInt("num_factura");
                                    String cliente = rs.getString("cliente");
                                    Date fechaAsignada = rs.getDate("fecha_asignada");

                                    out.println("<tr>");
                                    out.println("<td>" + repartidor + "</td>");
                                    out.println("<td>" + numFactura + "</td>");
                                    out.println("<td>" + cliente + "</td>");
                                    out.println("<td>" + fechaAsignada + "</td>");
                                    out.println("</tr>");
                                }

                            } catch (ClassNotFoundException e) {
                                out.println("Error: Oracle JDBC Driver not found.");
                            } catch (SQLException e) {
                                out.println("SQL Error: " + e.getMessage());
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                                if (conn != null) try { conn.close(); } catch (SQLException e) {}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                    <li><a class="menu-inferior" href="CatalogoMenu.jsp">CATALOGO</a></li>
                    <li><a class="menu-inferior" href="contacto.html">CONTACTO</a></li>
                    <li><a class="menu-inferior" href="HomeDefault.html">CERRAR SESION</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer-container">
            <p>
                &copy; 2024 The Art of Kitchen. Todos los derechos reservados.
                Designed in Mouth The Box
            </p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#entregasTable').DataTable({
                "paging": false, // Disable pagination
                "info": false, // Disable the info text
                "dom": '<"top"f>rt<"bottom"i><"clear">' // Only show the search bar
            });
        });
    </script>
</body>

</html>
