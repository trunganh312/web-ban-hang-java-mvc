<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib uri="http://www.springframework.org/tags/form"
prefix="form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Trung HT - Dự án laptopshop" />
    <meta name="author" content="Trung HT" />
    <title>${updateUser.fullName} - Trung HT</title>

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
                <div class="col-md-6 col-12 mx-auto">
                  <h3>Update a user</h3>
                  <hr />
                  <form:form method="post" action="/admin/user/update" modelAttribute="updateUser">
                    <div class="mb-3" style="display: none">
                      <label class="form-label">Id:</label>
                      <form:input type="text" class="form-control" path="id" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Email:</label>
                      <form:input type="email" class="form-control" path="email" disabled="true" />
                    </div>

                    <div class="mb-3">
                      <label class="form-label">Phone number:</label>
                      <form:input type="text" class="form-control" path="phone" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Full Name:</label>
                      <form:input type="text" class="form-control" path="fullName" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Address:</label>
                      <form:input type="text" class="form-control" path="address" />
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Role:</label>
                      <form:select class="form-select" aria-label="select role" path="role.name">
                        <form:option value="ADMIN">ADMIN</form:option>
                        <form:option value="USER">USER</form:option>
                      </form:select>
                    </div>

                    <button type="submit" class="btn btn-warning">Update</button>
                  </form:form>
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