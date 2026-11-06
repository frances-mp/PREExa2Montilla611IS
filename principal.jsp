<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Tips IA - KUMON</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.html">KUMON | Tips de IA Generativa</a>
            <a href="index.html" class="btn btn-outline-light btn-sm">Inicio</a>
        </div>
    </nav>

    <div class="container my-4">
        <div class="row mb-4 align-items-center">
            <div class="col-12 col-md-7">
                <h2 class="h4 fw-bold mb-1">Catálogo de Tips y Consejos</h2>
                <p class="text-muted mb-0">RF-001: Consulta de información sobre Inteligencia Artificial Generativa</p>
            </div>
            <div class="col-12 col-md-5 mt-3 mt-md-0">
                <form method="get" action="principal.jsp" class="d-flex">
                    <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar tip..."
                           value="<%= request.getParameter("buscar") != null ? request.getParameter("buscar") : "" %>">
                    <button type="submit" class="btn btn-primary">Buscar</button>
                </form>
            </div>
        </div>

        <div class="row g-4">
            <%
                String buscar = request.getParameter("buscar");
                try {
                    String sql = "SELECT id_tip, nombre, fecha_publicacion, descripcion_tip FROM tips";
                    if (buscar != null && !buscar.trim().isEmpty()) {
                        sql += " WHERE nombre LIKE ? OR descripcion_tip LIKE ?";
                    }
                    st = conexion.prepareStatement(sql);
                    if (buscar != null && !buscar.trim().isEmpty()) {
                        st.setString(1, "%" + buscar.trim() + "%");
                        st.setString(2, "%" + buscar.trim() + "%");
                    }
                    rs = st.executeQuery();
                    while (rs.next()) {
            %>
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <span class="badge bg-primary">ID Tip: <%= rs.getInt("id_tip") %></span>
                        <small class="text-muted"><%= rs.getDate("fecha_publicacion") %></small>
                    </div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-primary fw-bold"><%= rs.getString("nombre") %></h5>
                        <p class="card-text flex-grow-1"><%= rs.getString("descripcion_tip") %></p>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error en consulta: " + e.getMessage() + "</div>");
                } finally {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                    if (conexion != null) conexion.close();
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>