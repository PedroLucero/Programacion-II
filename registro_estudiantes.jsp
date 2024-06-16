<%@ page import="java.sql.*" %>
<%
    String mensaje = "";
    boolean epsito = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Obtener los parámetros de la solicitud
        String nombre = request.getParameter("nombre");
        String cedula = request.getParameter("cedula");
        String ano = request.getParameter("ano");
        String centro = request.getParameter("centro");
        String cursos = request.getParameter("cursos");
        String indice = request.getParameter("indice");

        Connection conn = null;
        PreparedStatement pst = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tu_base_de_datos", "tu_usuario", "tu_contraseña");
            String sql = "INSERT INTO estudiantes (nombre, cedula, ano_lectivo, centro, cursos, indice) VALUES (?, ?, ?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setString(1, nombre);
            pst.setString(2, cedula);
            pst.setString(3, ano);
            pst.setString(4, centro);
            pst.setString(5, cursos);
            pst.setString(6, indice);
            pst.executeUpdate();
            epsito = true;
            mensaje = "Registro exitoso";
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "Error en la conexión a la base de datos.";
        } finally {
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Estudiantes - Universidad del Pueblo</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <img src="logo.png" alt="Logo Universidad del Pueblo">
        <div class="banner">Registro de Estudiantes</div>
    </header>
    <main>
        <section>
            <h2>Registro de Estudiantes</h2>
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
            %>
                <p><%= mensaje %></p>
                <button onclick="window.location.href='registro_estudiantes.jsp'">Volver</button>
            <% 
                } else {
            %>
                <form action="registro_estudiantes.jsp" method="post">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="input-field" value="<%= request.getParameter("nombre") %>">
                    
                    <label for="cedula">Cédula:</label>
                    <input type="text" id="cedula" name="cedula" class="input-field" value="<%= request.getParameter("cedula") %>">
                    
                    <label for="ano">Año lectivo:</label>
                    <input type="text" id="ano" name="ano" class="input-field" value="<%= request.getParameter("ano") %>">
                    
                    <label for="centro">Centro:</label>
                    <input type="text" id="centro" name="centro" class="input-field" value="<%= request.getParameter("centro") %>">
                    
                    <label for="cursos">Cursos:</label>
                    <input type="text" id="cursos" name="cursos" class="input-field" value="<%= request.getParameter("cursos") %>">
                    
                    <label for="indice">Índice:</label>
                    <input type="text" id="indice" name="indice" class="input-field" value="<%= request.getParameter("indice") %>">
                    
                    <button type="submit" class="submit-button">Enviar</button>
                </form>
            <% 
                }
            %>
        </section>
    </main>
    <footer>
        <ul>
            <li><a href="home.html">Home</a></li>
            <li><a href="registro_profesores.jsp">Registro de Profesores</a></li>
            <li><a href="registro_estudiantes.jsp">Registro de Estudiantes</a></li>
            <li><a href="calendario.html">Calendario</a></li>
            <li><a href="soporte.html">Soporte</a></li>
        </ul>
        <p>© 2024 Universidad del Pueblo</p>
    </footer>
</body>
</html>
