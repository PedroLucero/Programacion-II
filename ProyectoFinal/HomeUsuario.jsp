<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="oracle.jdbc.driver.OracleDriver" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    if (nombreUsuario == null) {
        response.sendRedirect("LogInDefault.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Art of Kitchen</title>
    <link rel="stylesheet" href="stylesHomeDefault.css">
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
            <li class="opcion"><a class="menu-superior" href="CatalogoMenu.jsp">CATÁLOGO</a></li>
            <li class="opcion"><a class="menu-superior" href="Contacto.html">CONTACTO</a></li>
            <li id="login"><a class="menu-superior" href="PerfilCliente.jsp">HOLA, <%= nombreUsuario %></a></li>
        </ul>
    </nav>

    <section id="home" class="banner">
        <div class="container_banner">
            <h2 style="color: black;">Bienvenidos a The Art Of Kitchen</h2>
            <p id="slogan">"Crafting Culinary Elegance"</p>
        </div>
    </section>

    <section id="news" class="news">
        <div class="container">
            <h2>Noticias Relevantes</h2>
            <div class="news-list">
                <div class="news-item">
                    <img src="noticia1.jpg" alt="Noticia">
                    <h3>"Ideas que funcionan para decorar cocinas pequeñas"</h3>
                    <p><a class="boton-noticia"
                            href="https://www.hola.com/decoracion/20230403229339/cocinas-pequenas-mc/">Conoce más
                            aquí</a>
                    </p>
                </div>
                <div class="news-item">
                    <iframe id="iframe-height" width="560" height="315"
                        src="https://www.youtube.com/embed/UZQ2mlHG7jo?si=MP-7XZRjiEd3JCtg" title="YouTube video player"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                    <h3>"Top Kitchen Trends: Kitchen Design Tips & Hacks"</h3>
                    <p><a class="boton-noticia" href="">Conoce más aquí</a></p>
                </div>
                <div class="news-item">
                    <img src="noticia3.jpg" alt="Noticia">
                    <h3>"Una cocina que armoniza lo rústico y lo moderno"</h3>
                    <p><a class="boton-noticia"
                            href="https://www.hola.com/decoracion/20240628700915/cocina-estilo-rustico-moderno-en-perfecto-equilibrio-am/">Conoce
                            más aquí</a>
                    </p>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="footer-banner">
            <nav class="footer-nav">
                <ul>
                    <li><a class="menu-inferior" href="HomeDefault.html">HOME</a></li>
                    <li><a class="menu-inferior" href="CatalogoMenu.jsp">CATÁLOGO</a></li>
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
