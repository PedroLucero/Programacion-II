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
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
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
                <li class="opcion"><a class="menu-superior" href="Entregas.jsp">ENTREGAS</a></li>
                <li id="login"><a class="menu-superior" href="LogInDefault.jsp">CERRAR SESION</a></li>
            </ul>
        </nav>

        <div class="container main-content">

        <div class="content">
            <section id="home" class="banner">
                <div class="container_banner">
                    <h2>Bienvenidos a The Art Of Kitchen</h2>
                    <p id="slogan">"Crafting Culinary Elegance"</p>
                </div>
            </section>
            
            <h1>Inventario de Muebles</h1>

            <h2>Muebles Altos</h2>
            <div class="table-container">
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
                            <th>Fabricante</th>
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
                                String queryAltos = "SELECT M.ID, cantidad, color, linea, ancho, alto, precio, fecha_compra, altura, c_peso, divisiones, nombre FROM Mueble M join Fabricante F on m.id_fabricante = F.id where m.tipo_mueble = 1";
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
                                    out.println("<td>" + rsAltos.getString("nombre") + "</td>");
                                    out.println("</tr>");
                                }
                        %>
                    </tbody>
                </table>
            </div>

            <h2>Muebles Bajos</h2>
            <div class="table-container">
                <table id="tableBajos">
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
                            <th>Altura del Suelo</th>
                            <th>Número de Divisiones</th>
                            <th>Fabricante</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                // Muebles Bajos
                                stmtBajos = conn.createStatement();
                                String queryBajos = "SELECT M.ID, cantidad, color, linea, ancho, alto, precio, fecha_compra, altura_suelo, num_divisiones,  nombre FROM Mueble M join Fabricante F on m.id_fabricante = F.id where m.tipo_mueble = 2";
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
                                    out.println("<td>" + rsBajos.getString("nombre") + "</td>");
                                    out.println("</tr>");
                                }
                        %>
                    </tbody>
                </table>
            </div>

            <h2>Paneles</h2>
            <div class="table-container">
                <table id="tablePaneles">
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
                            <th>Material</th>
                            <th>Tipo de Componente</th>
                            <th>Fabricante</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                // Paneles
                                stmtPaneles = conn.createStatement();
                                String queryPaneles = "SELECT M.ID, cantidad, color, linea, ancho, alto, precio, fecha_compra, material, t_componente,  nombre FROM Mueble M join Fabricante F on m.id_fabricante = F.id where m.tipo_mueble = 3";
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
                                    out.println("<td>" + rsPaneles.getString("nombre") + "</td>");
                                    out.println("</tr>");
                                }
                        %>
                    </tbody>
                </table>
            </div>

            <h2>Encimeras</h2>
            <div class="table-container">
                <table id="tableEncimeras">
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
                            <th>Material de Encimera</th>
                            <th>Fabricante</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                // Encimeras
                                stmtEncimeras = conn.createStatement();
                                String queryEncimeras = "SELECT M.ID, cantidad, color, linea, ancho, alto, precio, fecha_compra, mat_enc,  nombre FROM Mueble M join Fabricante F on m.id_fabricante = F.id where m.tipo_mueble = 4";
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
                                    out.println("<td>" + rsEncimeras.getString("nombre") + "</td>");
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
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
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

    </div>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="MainColaborador.jsp">PERFIL DEL COLABORADOR</a></li>
                    <li><a class="menu-inferior" href="inventario.jsp">INVENTARIO</a></li>
                    <li><a class="menu-inferior" href="Entregas.jsp">ENTREGAS</a></li>
                    <li><a class="menu-inferior" id="logout" href="HomeDefault.html">CERRAR SESION</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer-container">
            <p>&copy; 2024 The Art of Kitchen. Todos los derechos reservados. Designed in Mouth The Box</p>
        </div>
    </footer>
</body>

</html>
