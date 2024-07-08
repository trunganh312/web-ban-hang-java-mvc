<%@page contentType="text/html" pageEncoding="UTF-8" %> 
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
              <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Trung HT - Dự án laptopshop" />
    <meta name="author" content="Trung HT" />
    <title>Create user - Trung HT</title>

    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                  <h3>Create a user</h3>
                  <hr />
                  <form:form class="row" method="post" action="/admin/user/create" modelAttribute="newUser" enctype="multipart/form-data" >
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorEmail">
                          <form:errors path="email" cssClass="invalid-feedback" />
                      </c:set>
                      <label class="form-label">Email:</label>
                      <form:input type="email" class="form-control  ${not empty errorEmail ? 'is-invalid' : ''  }" path="email" />
                        ${errorEmail}
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorPassword">
                          <form:errors path="password" cssClass="invalid-feedback"/>
                      </c:set>
                      <label class="form-label">Password:</label>
                      <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid' : ''  }" path="password" />
                      ${errorPassword}
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Phone number:</label>
                      <form:input type="text" class="form-control" path="phone" />
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorFullName">
                        <form:errors path="fullName" cssClass="invalid-feedback"/>
                      </c:set>
                      <label class="form-label">Full Name:</label>
                      <form:input type="text" class="form-control ${not empty errorFullName ? 'is-invalid' : ''  }" path="fullName" />
                        ${errorFullName}
                    </div>
                    <div class="mb-3 col-12 ">
                      <label class="form-label">Address:</label>
                      <form:input type="text" class="form-control" path="address" />
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label  class="form-label">Role:</label>
                      <form:select class="form-select" aria-label="select role" path="role.name"  >
                        <form:option  value="ADMIN">ADMIN</form:option>
                        <form:option value="USER">USER</form:option>
                      </form:select>
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label for="avatar" class="form-label">Avatar:</label>
                      <input class="form-control" type="file" id="avatar" name="avatarFile" accept=".jpg, .png, .jpeg">
                    </div>
                    <div class="mb-3 col-12 ">
                      <img src="" alt="Avatar preview" style="display: none; max-height: 250px;" id="avatarPreview" >
                    </div>

                    <div class="col-12 mb-5">
                      <button type="submit" class="btn btn-primary">Create</button>
                    </div>
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
    <script src="/js/scripts.js"></script>
    <script>
      $(document).ready(() => {
        $("#avatar").change((e) => {
          const avatarInput = e.target;
          const avatarFile = avatarInput.files[0];
          const avatarPreview = $("#avatarPreview");

          const imgURL = URL.createObjectURL(avatarFile);
          console.log(imgURL);
            avatarPreview.attr("src", imgURL);
            avatarPreview.css({
              "display": "block"
            });

        })
      })
    </script>
  </body>
</html>
