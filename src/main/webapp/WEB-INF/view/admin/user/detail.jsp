<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Trung HT - Dự án laptopshop" />
    <meta name="author" content="Trung HT" />
    <title>${user.fullName} - Trung HT</title>

    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Dashboard</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin">Dashboard</a>
              </li>
              <li class="breadcrumb-item active">User</li>
            </ol>
            <div class="container mt-5">
              <div class="row">
                <div class="col-12 mx-auto">
                  <div class="d-flex justify-content-between">
                    <h3>User with id: ${user.id}</h3>
                  </div>
                  <hr />
                  <div class="card" style="width: 100%">
                    <div class="card-header">User infomation:</div>
                    <ul class="list-group list-group-flush">
                      <li class="list-group-item">Email - ${user.email}</li>
                      <li class="list-group-item">Fullname - ${user.fullName}</li>
                      <li class="list-group-item">Phone - ${user.phone}</li>
                      <li class="list-group-item">Address - ${user.address}</li>
                      <li class="list-group-item">Role - ${user.role.getName()}</li>
                    </ul>
                  </div>
                  <a class="btn btn-success mt-3" href="/admin/user">Back</a>
                </div>
              </div>
            </div>
          </div>
        </main>
        <footer class="py-4 bg-light mt-auto">
          <div class="container-fluid px-4">
            <div class="d-flex align-items-center justify-content-between small">
              <div class="text-muted">Copyright &copy; Trung HT 2024</div>
              <div>
                <!-- <a href="https://hoidanit.vn/" target="_blank">Website</a>
                &middot;
                <a href="https://www.youtube.com/@hoidanit" target="_blank">Youtube channel</a> -->
              </div>
            </div>
          </div>
        </footer>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/scripts.js"></script>
  </body>
</html>
