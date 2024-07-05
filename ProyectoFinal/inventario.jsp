<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario de Muebles</title>
    <link rel="stylesheet" href="stylesinv.css">
</head>

<body>
    <header>
        <div class="logo">LOGO</div>
        <div class="icons">
            <div class="icon"></div>
            <div class="icon"></div>
            <div class="icon"></div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="HomeDefault.html">HOME</a></li>
            <li><a href="CatalogoMenu.html">CATÁLOGO</a></li>
            <li><a href="pagina3.html">CONTÁCTENOS</a></li>
        </ul>
    </nav>

    <div class="container">
        <h1>Inventario de Muebles</h1>

        <h2>Muebles Altos</h2>
        <table id="tableAltos">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cantidad</th>
                    <th>Color</th>
                    <th>Línea</th>
                    <th>Ancho</th>
                    <th>Alto</th>
                    <th>Precio</th>
                    <th>Fecha de Compra</th>
                    <th>Altura</th>
                    <th>Capacidad de Peso</th>
                    <th>Divisiones</th>
                    <th>ID del Fabricante</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Properties prop = new Properties();
                    String configPath = application.getRealPath("WEB-INF/config.properties");
                    try (InputStream input = new FileInputStream(configPath)) {
                        prop.load(input);
                    } catch (Exception e) {
                        out.println("archivo config error: " + e.getMessage());
                    }

                    String jdbcUrl = "jdbc:oracle:thin:@//localhost:1521/XE";
                    String dbUsername = prop.getProperty("db.username");
                    String dbPassword = prop.getProperty("db.password");

                    Connection conn = null;
                    Statement stmtAltos = null;
                    ResultSet rsAltos = null;
                    Statement stmtBajos = null;
                    ResultSet rsBajos = null;
                    Statement stmtPaneles = null;
                    ResultSet rsPaneles = null;
                    Statement stmtEncimeras = null;
                    ResultSet rsEncimeras = null;

                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                        // Muebles Altos
                        stmtAltos = conn.createStatement();
                        String queryAltos = "SELECT id, cantidad, color, linea, ancho, alto, precio, fecha_compra, altura, c_peso, divisiones, id_fabricante FROM Mueble WHERE tipo_mueble = 1";
                        rsAltos = stmtAltos.executeQuery(queryAltos);

                        while (rsAltos.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rsAltos.getInt("id") + "</td>");
                            out.println("<td>" + rsAltos.getInt("cantidad") + "</td>");
                            out.println("<td>" + rsAltos.getString("color") + "</td>");
                            out.println("<td>" + rsAltos.getString("linea") + "</td>");
                            out.println("<td>" + rsAltos.getBigDecimal("ancho") + "</td>");
                            out.println("<td>" + rsAltos.getBigDecimal("alto") + "</td>");
                            out.println("<td>" + rsAltos.getBigDecimal("precio") + "</td>");
                            out.println("<td>" + rsAltos.getDate("fecha_compra") + "</td>");
                            out.println("<td>" + rsAltos.getBigDecimal("altura") + "</td>");
                            out.println("<td>" + rsAltos.getInt("c_peso") + "</td>");
                            out.println("<td>" + rsAltos.getInt("divisiones") + "</td>");
                            out.println("<td>" + rsAltos.getInt("id_fabricante") + "</td>");
                            out.println("</tr>");
                        }

                        // Muebles Bajos
                        out.println("</tbody></table><h2>Muebles Bajos</h2><table id='tableBajos'><thead><tr>");
                        out.println("<th>ID</th><th>Cantidad</th><th>Color</th><th>Línea</th><th>Ancho</th><th>Alto</th><th>Precio</th><th>Fecha de Compra</th><th>Altura del Suelo</th><th>Número de Divisiones</th><th>ID del Fabricante</th></tr></thead><tbody>");

                        stmtBajos = conn.createStatement();
                        String queryBajos = "SELECT id, cantidad, color, linea, ancho, alto, precio, fecha_compra, altura_suelo, num_divisiones, id_fabricante FROM Mueble WHERE tipo_mueble = 2";
                        rsBajos = stmtBajos.executeQuery(queryBajos);

                        while (rsBajos.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rsBajos.getInt("id") + "</td>");
                            out.println("<td>" + rsBajos.getInt("cantidad") + "</td>");
                            out.println("<td>" + rsBajos.getString("color") + "</td>");
                            out.println("<td>" + rsBajos.getString("linea") + "</td>");
                            out.println("<td>" + rsBajos.getBigDecimal("ancho") + "</td>");
                            out.println("<td>" + rsBajos.getBigDecimal("alto") + "</td>");
                            out.println("<td>" + rsBajos.getBigDecimal("precio") + "</td>");
                            out.println("<td>" + rsBajos.getDate("fecha_compra") + "</td>");
                            out.println("<td>" + rsBajos.getBigDecimal("altura_suelo") + "</td>");
                            out.println("<td>" + rsBajos.getInt("num_divisiones") + "</td>");
                            out.println("<td>" + rsBajos.getInt("id_fabricante") + "</td>");
                            out.println("</tr>");
                        }

                        // Paneles
                        out.println("</tbody></table><h2>Paneles</h2><table id='tablePaneles'><thead><tr>");
                        out.println("<th>ID</th><th>Cantidad</th><th>Color</th><th>Línea</th><th>Ancho</th><th>Alto</th><th>Precio</th><th>Fecha de Compra</th><th>Material</th><th>Tipo de Componente</th><th>ID del Fabricante</th></tr></thead><tbody>");

                        stmtPaneles = conn.createStatement();
                        String queryPaneles = "SELECT id, cantidad, color, linea, ancho, alto, precio, fecha_compra, material, t_componente, id_fabricante FROM Mueble WHERE tipo_mueble = 3";
                        rsPaneles = stmtPaneles.executeQuery(queryPaneles);

                        while (rsPaneles.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rsPaneles.getInt("id") + "</td>");
                            out.println("<td>" + rsPaneles.getInt("cantidad") + "</td>");
                            out.println("<td>" + rsPaneles.getString("color") + "</td>");
                            out.println("<td>" + rsPaneles.getString("linea") + "</td>");
                            out.println("<td>" + rsPaneles.getBigDecimal("ancho") + "</td>");
                            out.println("<td>" + rsPaneles.getBigDecimal("alto") + "</td>");
                            out.println("<td>" + rsPaneles.getBigDecimal("precio") + "</td>");
                            out.println("<td>" + rsPaneles.getDate("fecha_compra") + "</td>");
                            out.println("<td>" + rsPaneles.getString("material") + "</td>");
                            out.println("<td>" + rsPaneles.getString("t_componente") + "</td>");
                            out.println("<td>" + rsPaneles.getInt("id_fabricante") + "</td>");
                            out.println("</tr>");
                        }

                        // Encimeras
                        out.println("</tbody></table><h2>Encimeras</h2><table id='tableEncimeras'><thead><tr>");
                        out.println("<th>ID</th><th>Cantidad</th><th>Color</th><th>Línea</th><th>Ancho</th><th>Alto</th><th>Precio</th><th>Fecha de Compra</th><th>Material de Encimera</th><th>ID del Fabricante</th></tr></thead><tbody>");

                        stmtEncimeras = conn.createStatement();
                        String queryEncimeras = "SELECT id, cantidad, color, linea, ancho, alto, precio, fecha_compra, mat_enc, id_fabricante FROM Mueble WHERE tipo_mueble = 4";
                        rsEncimeras = stmtEncimeras.executeQuery(queryEncimeras);

                        while (rsEncimeras.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rsEncimeras.getInt("id") + "</td>");
                            out.println("<td>" + rsEncimeras.getInt("cantidad") + "</td>");
                            out.println("<td>" + rsEncimeras.getString("color") + "</td>");
                            out.println("<td>" + rsEncimeras.getString("linea") + "</td>");
                            out.println("<td>" + rsEncimeras.getBigDecimal("ancho") + "</td>");
                            out.println("<td>" + rsEncimeras.getBigDecimal("alto") + "</td>");
                            out.println("<td>" + rsEncimeras.getBigDecimal("precio") + "</td>");
                            out.println("<td>" + rsEncimeras.getDate("fecha_compra") + "</td>");
                            out.println("<td>" + rsEncimeras.getString("mat_enc") + "</td>");
                            out.println("<td>" + rsEncimeras.getInt("id_fabricante") + "</td>");
                            out.println("</tr>");
                        }
                    } catch (SQLException e) {
                        out.println("SQL Error: " + e.getMessage());
                    } finally {
                        if (rsAltos != null) try { rsAltos.close(); } catch (SQLException e) {}
                        if (stmtAltos != null) try { stmtAltos.close(); } catch (SQLException e) {}
                        if (rsBajos != null) try { rsBajos.close(); } catch (SQLException e) {}
                        if (stmtBajos != null) try { stmtBajos.close(); } catch (SQLException e) {}
                        if (rsPaneles != null) try { rsPaneles.close(); } catch (SQLException e) {}
                        if (stmtPaneles != null) try { stmtPaneles.close(); } catch (SQLException e) {}
                        if (rsEncimeras != null) try { rsEncimeras.close(); } catch (SQLException e) {}
                        if (stmtEncimeras != null) try { stmtEncimeras.close(); } catch (SQLException e) {}
                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#tableAltos').DataTable({
                "paging": false,
                "info": false,
                "lengthChange": false
            });
            $('#tableBajos').DataTable({
                "paging": false,
                "info": false,
                "lengthChange": false
            });
            $('#tablePaneles').DataTable({
                "paging": false,
                "info": false,
                "lengthChange": false
            });
            $('#tableEncimeras').DataTable({
                "paging": false,
                "info": false,
                "lengthChange": false
            });
        });
    </script>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                    <li><a class="menu-inferior" href="CatalogoMenu.html">CATALOGO</a></li>
                    <li><a class="menu-inferior" href="contacto.html">CONTACTO</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer-container">
            <p>&copy; 2024 The Art of Kitchen. Todos los derechos reservados. Designed in Mouth The Box</p>
        </div>
    </footer>
</body>

</html>
