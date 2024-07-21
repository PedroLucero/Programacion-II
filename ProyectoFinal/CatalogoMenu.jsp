<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="oracle.jdbc.driver.OracleDriver" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    boolean isLoggedIn = (nombreUsuario != null);
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Art of Kitchen</title>
    <link rel="stylesheet" href="stylesCatalogoMenu.css">
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

    <nav>
        <ul class="nav-ul-superior">
            <li class="opcion"><a class="menu-superior" href="HomeDefault.html">HOME</a></li>
            <li class="opcion"><a class="menu-superior" href="CatalogoMenu.html">CATÁLOGO</a></li>
            <li class="opcion"><a class="menu-superior" href="Contacto.html">CONTACTO</a></li>
            <li id="login">
                <a class="menu-superior" href="<%= isLoggedIn ? "PerfilCliente.jsp" : "LogInDefault.jsp" %>">
                    <%= isLoggedIn ? "Hola, " + nombreUsuario : "INICIAR SESIÓN" %>
                </a>
            </li>
        </ul>
    </nav>

    <section id="home" class="banner">
        <div class="container_banner">
            <h1>¿Qué desea buscar?</h1>
        </div>
    </section>

    <div class="menucatalogo">
        <div class="image-link">
            <a href="<%= isLoggedIn ? "CatalogoMueble.jsp" : "LogInDefault.jsp" %>">
                <img src="mueble.jpg" alt="Descripción de la imagen 1">
                <p>Muebles</p>
            </a>
        </div>
        <div class="image-link">
            <a href="<%= isLoggedIn ? "CatalogoCocina.jsp" : "LogInDefault.jsp" %>">
                <img src="mueble.jpg" alt="Descripción de la imagen 2">
                <p>Cocinas</p>
            </a>
        </div>
    </div>
    <div><br><br><br><br<br><br><br><br><br></div>
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
