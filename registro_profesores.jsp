<%@ page import="java.sql.*" %>
<%
    String message = "";
    boolean success = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Obtener los parámetros de la solicitud
        String nombre = request.getParameter("nombre");
        String cedula = request.getParameter("cedula");
        String materia = request.getParameter("materia");
        String centro = request.getParameter("centro");
        String experiencia = request.getParameter("experiencia");

        Connection conn = null;
        PreparedStatement pst = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/asig4", "root", "");
            String sql = "INSERT INTO profesores (nombre, cedula, materia, centro, experiencia) VALUES (?, ?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setString(1, nombre);
            pst.setString(2, cedula);
            pst.setString(3, materia);
            pst.setString(4, centro);
            pst.setString(5, experiencia);
            pst.executeUpdate();
            success = true;
            message = "Registro exitoso";
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error en la conexión a la base de datos.";
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
    <title>Registro de Profesores - Universidad del Pueblo</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <img src="logo.png" alt="Logo Universidad del Pueblo">
        <div class="banner">Registro de Profesores</div>
    </header>
    <main>
        <section>
            <h2>Registro de Profesores</h2>
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
            %>
                <p><%= message %></p>
                <button onclick="window.location.href='registro_profesores.jsp'">Volver</button>
            <% 
                } else {
            %>
                <form action="registro_profesores.jsp" method="post">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="input-field" value="<%= request.getParameter("nombre") %>">
                    
                    <label for="cedula">Cédula:</label>
                    <input type="text" id="cedula" name="cedula" class="input-field" value="<%= request.getParameter("cedula") %>">
                    
                    <label for="materia">Materia:</label>
                    <input type="text" id="materia" name="materia" class="input-field" value="<%= request.getParameter("materia") %>">
                    
                    <label for="centro">Centro:</label>
                    <input type="text" id="centro" name="centro" class="input-field" value="<%= request.getParameter("centro") %>">
                    
                    <label for="experiencia">Experiencia:</label>
                    <input type="text" id="experiencia" name="experiencia" class="input-field" value="<%= request.getParameter("experiencia") %>">
                    
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
