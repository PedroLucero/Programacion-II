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
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="stylesInfoCocina.css" />
  </head>

  <body>
  <%
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
        String username = prop.getProperty("db.username");
        String password = prop.getProperty("db.password");

        Connection conn = null;
        Statement coc_stmt = null;
        ResultSet coc_rs = null;
        Statement det_stmt = null;
        ResultSet det_rs = null;
        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Establish the connection
            conn = DriverManager.getConnection(jdbcUrl, username, password);
            // Create a statement
            coc_stmt = conn.createStatement();
            det_stmt = conn.createStatement();
            // Execute the query
            String id = request.getParameter("id");
            String cocina_query = "SELECT * FROM COCINA WHERE ID = " + id + "";
            String detalles_query = "SELECT * FROM DETALLES_COCINA WHERE ID_COCINA = " + id + "";
            coc_rs = coc_stmt.executeQuery(cocina_query);
            det_rs = det_stmt.executeQuery(detalles_query);

        } catch (ClassNotFoundException e) {
            out.println("Error: Oracle JDBC Driver not found.");
        } catch (SQLException e) {
            out.println("SQL Error: " + e.getMessage());
        }
    %>
    <header>
      <img src="nb-logow.png" alt="Logo" class="logo" />
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

    <h1 class="main-title">Detalles de cocina</h1>
    
    <section class="product-section">
        <div class="product-image">
            <img src="ruta-de-la-imagen.jpg" alt="Producto">
        </div>
        <div class="product-details">
          <%
            coc_rs.next();
            String nombre_c = coc_rs.getString("NOMBRE");
            out.println("<h2>" + nombre_c + "</h2>");

            int numserie = coc_rs.getInt("NUMSERIE");
            int disponible = coc_rs.getInt("INSTOCK");
            int precio = coc_rs.getInt("PRECIO");
            out.println("<p>");
            out.println("Número de serie: " + numserie + "<br><br>");
            out.println("Cantidad disponible: " + disponible + "<br><br>");
            out.println("Número de serie: " + precio + "<br><br>");
            out.println("</p>");
          %>
        </div>
    </section>

    <h2 class="secondary-title">Muebles de la cocina</h2>
    
    <section class="related-products">
        <%
          while(det_rs.next()) {
            out.println("<div class='product-card'>");
            String nombre_p = det_rs.getString("NOMBRE");

              int tipo = det_rs.getInt("TIPO_MUEBLE");
            switch(tipo) {
                case 1:
                    Double altura = det_rs.getDouble("ALTURA");
                    Double c_peso = det_rs.getDouble("C_PESO");
                    int divisiones = det_rs.getInt("DIVISIONES");
                    out.println("<img src='mueble_alto.png' alt='Mueble alto'>");
                    out.println("<h3>" + nombre_p + "</h3>");
                    out.println("<p>");
                    out.println("Altura: " + altura + "<br><br>");
                    out.println("Capacidad de peso: " + c_peso + "<br><br>");
                    out.println("Divisiones: " + divisiones + "<br><br>");
                    break;
                case 2:
                    Double altura_suelo = det_rs.getDouble("ALTURA");
                    int num_divisiones = det_rs.getInt("DIVISIONES");
                    out.println("<img src='mueble_bajo.png' alt='Mueble bajo'>");
                    out.println("<h3>" + nombre_p + "</h3>");
                    out.println("<p>");
                    out.println("Altura del suelo: " + altura_suelo + "<br><br>");
                    out.println("Divisiones: " + num_divisiones + "<br><br>");
                    break;
                case 3:
                    String material = det_rs.getString("MATERIAL");
                    Double tam_comp = det_rs.getDouble("T_COMPONENTE");
                    out.println("<img src='panel.png' alt='Panel'>");
                    out.println("<h3>" + nombre_p + "</h3>");
                    out.println("<p>");
                    out.println("Material: " + material + "<b><br>");
                    out.println("Tamaño del componente: " + tam_comp + "<br><br>");
                break;
                case 4:
                    char mat_enc = det_rs.getString("MAT_ENC").charAt(0);
                    String Material_encimera = "Mármol";
                    if (mat_enc == 'A'){
                      Material_encimera = "Aglomerado";
                    }
                    out.println("<img src='encimera.png' alt='Encimera'>");
                    out.println("<h3>" + nombre_p + "</h3>");
                    out.println("<p>");
                    out.println("Material de la encimera: " + Material_encimera + "<br><br>");
                break;
                default:
                    out.println("<img src='sofa-moderno.jpg' alt='Sofá Moderno'>");
                    out.println("<h3>" + nombre_p + "</h3>");
                    out.println("<p>");
                    out.println("HUBO UN ERROR");
                    out.println("</p>");
            }

            int cantidad_en_c = det_rs.getInt("CANTIDAD");
            String color = det_rs.getString("COLOR");
            String linea = det_rs.getString("LINEA");
            Double ancho = det_rs.getDouble("ANCHO");
            Double alto = det_rs.getDouble("ALTO");
            
            // out.println("Cantidad en la cocina: " + cantidad_en_c + "<br><br>");
            out.println("Color: " + color + "<br><br>");
            out.println("Linea: " + linea + "<br><br>");
            out.println("Dimensiones: " + ancho + "x" + alto + "<br><br>");
            out.println("</p>");
            out.println("</div>");
          }
        %>
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
  </body>
</html>