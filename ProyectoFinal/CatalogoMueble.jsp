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
        //cosita para que no se dañe todo cuando hacemos pullpush
        Properties prop = new Properties();
        String configPath = application.getRealPath("WEB-INF/config.properties");
        try (InputStream input = new FileInputStream(configPath)) {
            prop.load(input);
        } catch (Exception e) {
        out.println("archivo config error: " + e.getMessage());
        }
        // Database connection parameters
        String jdbcUrl = "jdbc:oracle:thin:@//localhost:1521/XE";
        String username = prop.getProperty("db.username");
        String password = prop.getProperty("db.password");

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Statement stmtcq = null;
        ResultSet cqrs = null;
        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Establish the connection
            conn = DriverManager.getConnection(jdbcUrl, username, password);
            // Create a statement
            stmt = conn.createStatement();
            stmtcq = conn.createStatement();
            // Execute the query
            String catalogue_query = "SELECT * FROM MUEBLE M JOIN TIPO_MUEBLE T ON M.TIPO_MUEBLE = T.ID_TIPO";
            String sales_query = "SELECT * FROM DETALLE_V_MUEBLES D JOIN MUEBLE M ON D.ID_MUEBLE = M.ID JOIN TIPO_MUEBLE T ON M.TIPO_MUEBLE = T.ID_TIPO";
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
            <li class="opcion"><a class="menu-superior" href="HomeDefault.html">HOME</a></li>
            <li class="opcion"><a class="menu-superior" href="CatalogoMenu.html">CATALOGO</a></li>
            <li class="opcion"><a class="menu-superior" href="pagina3.html">CONTACTO</a></li>
            <li id="login"><a class="menu-superior" href="LogInDefault.html">INICIAR SESION</a></li>
        </ul>
    </nav>

    <section id="SeccionCatalogoCompras">
        <div id="catalogo">
            <h1>Catálogo de Muebles</h1>

        <%
            while (rs.next()) {
                out.println("<div class='mueble'>");
                int tipo = rs.getInt("TIPO_MUEBLE");
                switch(tipo) {
                    case 1:
                        out.println("<img src='mueble_alto.png' alt='Mueble alto'>");
                        break;
                    case 2:
                        out.println("<img src='mueble_bajo.png' alt='Mueble bajo'>");
                        break;
                    case 3:
                        out.println("<img src='panel.png' alt='Panel'>");
                    break;
                    case 4:
                        out.println("<img src='encimera.png' alt='Encimera'>");
                    break;
                    default:
                        out.println("<img src='sofa-moderno.jpg' alt='Sofá Moderno'>");
                    }
                out.println("<div class='mueble-info'>");
                String nombre = rs.getString("NOMBRE");
                out.println("<h2>"+  nombre + "</h2>");
                double precio = rs.getDouble("PRECIO");
                double ancho = rs.getDouble("ANCHO");
                double alto = rs.getDouble("ALTO");
                int disponibles = rs.getInt("CANTIDAD");

                String color = rs.getString("COLOR");
                String linea = rs.getString("LINEA");

                
                out.println("Precio: $" + precio + " Dimensiones: " + ancho + "x" + alto + "''<br><br>");
                out.println("Disponibles: " + disponibles + "<br><br>");
                out.println("Color: " + color + "<br><br>");
                out.println("Linea: " + linea + "<br><br>");
                out.println("<button>Añadir al carrito</button>");
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
                out.println("Cantidad: " + cantidad + "<br><br>");
                out.println("Precio: $" + precio*cantidad +  "<br><br>");
                out.println("</div>");
            }
        %>
        </div>
    </section>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                    <li><a class="menu-inferior" href="CatalogoMenu.html">CATALOGO</a></li>
                    <li><a class="menu-inferior" href="contacto.html">CONTACTO</a></li>
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