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
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
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
            <li><a class="menu-superior" href="CatalogoMenu.html">CATALOGO</a></li>
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
                <a href="register.jsp" id="registro-link">Registrarse</a>
                <button type="submit">Login</button>
            </form>
        </div>
        <a id="LGTRABAJADOR" href="#">Iniciar sesión como colaborador</a>
    </section>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                    <li><a class="menu-inferior" href="catalogo.html">CATALOGO</a></li>
                    <li><a class="menu-inferior" href="contacto.html">CONTACTO</a></li>
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
        boolean success = false;
        String errorMessage = "";

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Properties prop = new Properties();
            String configPath = application.getRealPath("WEB-INF/config.properties");
            try (InputStream input = new FileInputStream(configPath)) {
                prop.load(input);
            } catch (Exception e) {
                errorMessage = "archivo config error: " + e.getMessage();
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
                String query = "SELECT * FROM CREDENCIALES WHERE USUARIO = ? AND CONTRASENA = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                stmt.setString(2, password);

                // Ejecutar la consulta
                rs = stmt.executeQuery();

                if (rs.next()) {
                    // Usuario y contraseña correctos
                    String role = rs.getString("ROL");
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    if ("CLIENTE".equalsIgnoreCase(role)) {
                        response.sendRedirect("homeusuario.jsp");
                    } else if ("EMPLEADO".equalsIgnoreCase(role)) {
                        response.sendRedirect("employeeHome.jsp");
                    }
                } else {
                    // Usuario o contraseña incorrectos
                    errorMessage = "Usuario o contraseña incorrectos.";
                }

            } catch (ClassNotFoundException e) {
                errorMessage = "Error: Oracle JDBC Driver not found.";
            } catch (SQLException e) {
                errorMessage = "SQL Error: " + e.getMessage();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>

    <% if (!success && !errorMessage.isEmpty()) { %>
    <div id="myModal" class="modal" style="display:block;">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p><%= errorMessage %></p>
        </div>
    </div>
    <% } %>

    <script>
        // Obtener el modal
        var modal = document.getElementById("myModal");

        // Obtener el <span> que cierra el modal
        var span = document.getElementsByClassName("close")[0];

        // Cuando el usuario hace click en <span> (x), se cierra el modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // Cuando el usuario hace click fuera del modal, se cierra
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>
