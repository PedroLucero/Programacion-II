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
    <title>Art of Kitchen</title>
    <link rel="stylesheet" href="stylesCatalogo.css">
</head>

<body>
    <%
        String username = (String) session.getAttribute("username");
        String nombreUsuario = (String) session.getAttribute("nombreUsuario");
        if (username == null) {
            response.sendRedirect("CatalogoCocinaNOLOGIN.jsp");
            return;
        }

        //cosita para no tener que escribir password y user
        Properties prop = new Properties();
        String configPath = application.getRealPath("WEB-INF/config.properties");
        try (InputStream input = new FileInputStream(configPath)) {
            prop.load(input);
        } catch (Exception e) {
            out.println("archivo config error: " + e.getMessage());
        }
        // Database connection parameters
        String jdbcUrl = "jdbc:oracle:thin:@//localhost:1521/XE";
        String dbUsername = prop.getProperty("db.username");
        String dbPassword = prop.getProperty("db.password");

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Statement stmtcq = null;
        ResultSet cqrs = null;
        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Establish the connection
            conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
            // Create a statement
            stmt = conn.createStatement();
            stmtcq = conn.createStatement();
            // Execute the query
            String catalogue_query = "SELECT * FROM COCINA";
            String sales_query = "SELECT C.NOMBRE, D.CANTIDAD, C.PRECIO, V.FECHA_VENTA " +
                                "FROM DETALLE_V_COCINAS D " +
                                "JOIN COCINA C ON D.ID_COCINA = C.ID " +
                                "JOIN VENTA V ON D.NUM_FACTURA = V.NUM_FACTURA " +
                                "JOIN CLIENTE CL ON V.ID_CLIENTE = CL.ID " +
                                "JOIN CREDENCIALES CR ON CL.ID_CREDENCIALES = CR.ID " +
                                "WHERE CR.USUARIO = '" + username + "'";
            rs = stmt.executeQuery(catalogue_query);
            cqrs = stmtcq.executeQuery(sales_query);

        } catch (ClassNotFoundException e) {
            out.println("Error: Oracle JDBC Driver not found.");
        } catch (SQLException e) {
            out.println("SQL Error: " + e.getMessage());
        }
    %>

    <header>
        <img src="nb-logow.png" alt="Logo" class="logo">
        <div class="iconos">
            <a class="icono" href="https://www.google.com"><img src="lupa-1.png"></a>
            <a class="icono" href="https://www.instagram.com"><img src="instagram-1.png"></a>
            <a class="icono" href="https://www.tiktok.com/discover?lang=es"><img src="tik-tok.png"></a>
            <a class="icono" href="https://www.pinterest.com"><img src="pinterest.png"></a>
        </div>
    </header>

    <nav>
        <ul class="nav-ul-superior">
            <li class="opcion"><a class="menu-superior" href="HomeUsuario.html">HOME</a></li>
            <li class="opcion"><a class="menu-superior" href="CatalogoMenu.html">CATALOGO</a></li>
            <li class="opcion"><a class="menu-superior" href="Contacto.html">CONTACTO</a></li>
            <li id="login"><a class="menu-superior" href="PerfilCliente.jsp">Hola, <%= nombreUsuario %></a></li>
        </ul>
    </nav>

    <section id="SeccionCatalogoCompras">
        <div id="catalogo">
            <h1>Catálogo de Cocinas</h1>
            <%
                while (rs.next()) {
                    out.println("<div class='mueble'>");
                    out.println("<img src='cocina.png' alt='Imagen cocina'>");
                    out.println("<div class='mueble-info'>");
                    String nombre = rs.getString("NOMBRE");
                    out.println("<h2>"+  nombre + "</h2>");
                    double precio = rs.getDouble("PRECIO");
                    int cantidad_m = rs.getInt("NUMMUEBLES");
                    int stock = rs.getInt("INSTOCK");
                    
                    out.println("Precio: $" + precio + "<br><br>");
                    out.println("Número de muebles: " + cantidad_m + "<br><br>");
                    if (stock >= 1){
                        out.println("- Esta cocina está disponible - <br><br>");
                    }
                    else {
                        out.println("- Esta cocina no está disponible - <br><br>");
                    }
                    int id = rs.getInt("ID");
                    out.println("<a class='menu-inferior' href='InfoCocina.jsp?id=" + id + "'><button>Ver detalles</button></a>");
                    out.println("</div></div>");
                }
            %>

        </div>
        
        <div id="compras">
            <h1>Tus Compras</h1>
            <%
            while (cqrs.next()) {
                out.println("<div class='compra'>");
                String nombre = cqrs.getString("NOMBRE");
                out.println("<h3>"+  nombre + "</h3>");
                int cantidad = cqrs.getInt("CANTIDAD");
                double precio = cqrs.getDouble("PRECIO");
                Date fechaCompra = cqrs.getDate("FECHA_VENTA");
                out.println("Cantidad: " + cantidad + "<br><br>");
                out.println("Monto: $" + precio*cantidad +  "<br><br>");
                out.println("Fecha de Compra: " + fechaCompra + "<br><br>");
                out.println("</div>");
            }
        %>
        </div>
    </section>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeUsuario.html">HOME</a></li>
                    <li><a class="menu-inferior" href="CatalogoMenu.html">CATALOGO</a></li>
                    <li><a class="menu-inferior" href="Contacto.html">CONTACTO</a></li>
                    <li><a class="menu-inferior" href="LogInDefault.jsp">CERRAR SESION</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer-container">
            <p>&copy; 2024 The Art of Kitchen. Todos los derechos reservados. Designed in Mouth The Box</p>
        </div>
    </footer>
</body>

</html>
