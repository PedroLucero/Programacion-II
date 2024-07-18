<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Obtener el username de la sesión
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("LogInDefault.jsp");
        return;
    }

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
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String nombre = "";
    String direccion = "";
    String telefono = "";
    int clienteId = 0;

    try {
        // Cargar el controlador JDBC de Oracle
        Class.forName("oracle.jdbc.driver.OracleDriver");
        // Establecer la conexión
        conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // Preparar la consulta SQL
        String query = "SELECT c.id, c.nombre, c.direccion, c.telefono " +
                       "FROM cliente c " +
                       "JOIN credenciales cr ON c.id_credenciales = cr.id " +
                       "WHERE cr.usuario = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, username);

        // Ejecutar la consulta
        rs = stmt.executeQuery();

        if (rs.next()) {
            clienteId = rs.getInt("id");
            nombre = rs.getString("nombre");
            direccion = rs.getString("direccion");
            telefono = rs.getString("telefono");
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

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil</title>
    <link rel="stylesheet" href="stylesColaborador.css">
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
            <li class="opcion"><a class="menu-superior" href="PerfilCliente.jsp">PERFIL DEL CLIENTE</a></li>
            <li class="opcion"><a class="menu-superior" href="CatalogoMenu.html">CATÁLOGO</a></li>
            <li class="opcion"><a class="menu-superior" href="Contacto.html">CONTACTO</a></li>
            <li id="login"><a class="menu-superior" href="LogInDefault.jsp">CERRAR SESIÓN</a></li>
        </ul>
    </nav>

    <div class="content">
        <section id="home" class="banner">
            <div class="container_banner">
                <h2>Bienvenidos a The Art Of Kitchen</h2>
                <p id="slogan">"Crafting Culinary Elegance"</p>
            </div>
        </section>

        <div class="user-info">
            <img src="usuario.png" alt="Foto de usuario">
            <h2><%= nombre %></h2>
        </div>

        <div class="general-info">
            <h3>DATOS GENERALES</h3>
            <table>
                <tr>
                    <th>Nombre</th>
                    <td><%= nombre %></td>
                </tr>
                <tr>
                    <th>Id Cliente</th>
                    <td><%= clienteId %></td>
                </tr>
                <tr>
                    <th>Dirección</th>
                    <td><%= direccion %></td>
                </tr>
                <tr>
                    <th>Teléfono</th>
                    <td><%= telefono %></td>
                </tr>
            </table>
        </div>
    </div>
</div>

<footer>
    <div class="footer-banner">
        <nav class="footer-nav">
            <ul>
                <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                <li><a class="menu-inferior" href="CatalogoMenu.html">CATÁLOGO</a></li>
                <li><a class="menu-inferior" href="Contacto.html">CONTACTO</a></li>
                <li><a class="menu-inferior" id="logout" href="HomeDefault.html">CERRAR SESIÓN</a></li>
            </ul>
        </nav>
    </div>
    <div class="footer-container">
        <p>&copy; 2024 The Art of Kitchen. Todos los derechos reservados. Designed in Mouth The Box</p>
    </div>
</footer>
</body>
</html>
