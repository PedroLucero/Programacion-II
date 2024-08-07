<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="oracle.jdbc.driver.OracleDriver" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="stylesLogInDefault.css">
</head>

<body>
    <header>
        <img src="nb-logow.png" alt="Logo" class="logo">
        <div class="iconos">
            <a class="icono" href="https://www.google.com"><img src="lupa-1.png" alt="Buscar"></a>
            <a class="icono" href="https://www.instagram.com"><img src="instagram-1.png" alt="Instagram"></a>
            <a class="icono" href="https://www.tiktok.com/discover?lang=es"><img src="tik-tok.png" alt="TikTok"></a>
            <a class="icono" href="https://www.pinterest.com"><img src="pinterest.png" alt="Pinterest"></a>
        </div>
    </header>

    <nav>
        <ul class="nav-ul-superior">
            <li><a class="menu-superior" href="HomeDefault.html">HOME</a></li>
            <li><a class="menu-superior" href="CatalogoMenu.html">CATÁLOGO</a></li>
            <li><a class="menu-superior" href="pagina3.html">CONTACTO</a></li>
        </ul>
    </nav>

    <section class="banner">
        <div class="container_banner">
            <h2>The Art Of Kitchen</h2>
            <p id="slogan">Inicio de Sesión</p>
        </div>
    </section>

    <section class="form-section">
        <div class="formularios">
            <form class="form" id="login-form" method="post" action="LogInDefault.jsp">
                <h2>Iniciar Sesión</h2>
                <label for="login-username">Usuario:</label>
                <input type="text" id="login-username" name="username" required>
                <label for="login-password">Contraseña:</label>
                <input type="password" id="login-password" name="password" required>
                <a href="registrarse.jsp" id="registro-link">Registrarse</a>
                <button type="submit">Login</button>
            </form>
        </div>
    </section>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                    <li><a class="menu-inferior" href="CatalogoMenu.jsp">CATÁLOGO</a></li>
                    <li><a class="menu-inferior" href="Contacto.html">CONTACTO</a></li>
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

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

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

            try {
                // Cargar el controlador JDBC de Oracle
                Class.forName("oracle.jdbc.driver.OracleDriver");
                // Establecer la conexión
                conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                // Preparar la consulta SQL
                String query = "SELECT c.rol, c.usuario, cl.nombre FROM CREDENCIALES c LEFT JOIN CLIENTE cl ON c.ID = cl.ID_CREDENCIALES LEFT JOIN USUARIO u ON c.ID = u.ID_CREDENCIALES WHERE c.usuario = ? AND c.contrasena = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, username.trim());
                stmt.setString(2, password.trim());

                // Ejecutar la consulta
                rs = stmt.executeQuery();

                if (rs.next()) {
                    // Usuario y contraseña correctos
                    String role = rs.getString("rol");
                    String nombreUsuario = rs.getString("nombre");
                    if (nombreUsuario == null) {
                        nombreUsuario = rs.getString("usuario");
                    }
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);
                    session.setAttribute("nombreUsuario", nombreUsuario);

                    if ("CLIENTE".equalsIgnoreCase(role)) {
                        response.sendRedirect("HomeUsuario.jsp");
                    } else if ("EMPLEADO".equalsIgnoreCase(role)) {
                        response.sendRedirect("MainColaborador.jsp");
                    }
                } else {
                    // Usuario o contraseña incorrectos
                    out.println("<p>Usuario o contraseña incorrectos.</p>");
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
        }
    %>
</body>
</html>
