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
    <title>Create product - Trung HT</title>

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
              <li class="breadcrumb-item active">
                <a href="/admin/product">Product</a>
              </li>
              <li class="breadcrumb-item active">Create</li>
            </ol>
            <div class="container mt-5">
              <div class="row">
                <div class="col-md-6 col-12 mx-auto">
                  <h3>Create a poduct</h3>
                  <hr />
                  <form:form class="row" method="post" action="/admin/product/create" enctype="multipart/form-data" modelAttribute="newProduct" >
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorName">
                          <form:errors path="name" cssClass="invalid-feedback"/>
                      </c:set>
                      <label class="form-label">Name:</label>
                      <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="name" />
                      ${errorName}
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorPrice">
                        <form:errors path="price" cssClass="invalid-feedback"/>
                      </c:set>
                      <label class="form-label">Price:</label>
                      <form:input type="number"  class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" path="Price" />
                        ${errorPrice}
                    </div>
                    <div class="mb-3 col-12 ">
                      <c:set var="errorDetailDesc">
                        <form:errors path="detailDesc" cssClass="invalid-feedback" />
                      </c:set>
                      <label class="form-label">Detail description:</label>
                      <form:textarea type="text" rows="5" class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" path="detailDesc" />
                        ${errorDetailDesc}
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorShortDesc">
                        <form:errors path="shortDesc" cssClass="invalid-feedback" />
                      </c:set>
                      <label class="form-label">Short description:</label>
                      <form:input type="text" class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" path="shortDesc" />
                        ${errorShortDesc}
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <c:set var="errorQuantity">
                        <form:errors path="quantity" cssClass="invalid-feedback"/>
                      </c:set>
                      <label class="form-label">Quantity:</label>
                      <form:input type="number" class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" path="quantity" />
                        ${errorQuantity}

                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Factory:</label>
                      <form:select class="form-select" aria-label="select role" path="factory">
                        <form:option value="APPLE">Apple(MaBook)</form:option>
                        <form:option value="ASUS">Asus</form:option>
                        <form:option value="LENOVO">Lenovo</form:option>
                        <form:option value="DELL">Dell</form:option>
                        <form:option value="ACER">Acer</form:option>
                        <form:option value="LG">LG</form:option>
                      </form:select>
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Target:</label>
                      <form:select class="form-select" aria-label="select role" path="target">
                        <form:option value="GAMING">Gaming</form:option>
                        <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</form:option>
                        <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                        <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                        <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                      </form:select>
                    </div>
                    <div class="mb-3 col-12 ">
                      <label for="image" class="form-label">Image:</label>
                      <input path="image" class="form-control" type="file" id="image" name="imageFile" accept=".jpg, .png, .jpeg">
                    </div>
                    <div class="mb-3 col-12 ">
                      <img src="" alt="Image preview" style="display: none; max-height: 250px;" id="imagePreview" >
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
        $("#image").change((e) => {
          const imageInput = e.target;
          const imageFile = imageInput.files[0];
          const imagePreview = $("#imagePreview");

          const imgURL = URL.createObjectURL(imageFile);
          console.log(imgURL);
          imagePreview.attr("src", imgURL);
          imagePreview.css({
            display: "block",
          });
        });
      });
    </script>
  </body>
</html>
