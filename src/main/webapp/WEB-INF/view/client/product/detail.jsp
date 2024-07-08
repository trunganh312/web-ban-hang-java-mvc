<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Fruitables - Vegetable Website Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
      rel="stylesheet"
    />

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  </head>

  <body>
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />
    <jsp:include page="/WEB-INF/view/client/layout/banner-detail.jsp" />

    <div class="container-fluid py-5 mt-5">
      <div class="container py-5">
        <div class="row g-4 mb-5">
          <div>
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết sản phẩm</li>
              </ol>
            </nav>
          </div>
          <div class="col-lg-8 col-xl-9">
            <div class="row g-4">
              <div class="col-lg-6">
                <div class="border rounded">
                  <a href="#">
                    <img src="/images/product/${product.image}" class="img-fluid rounded" alt="Image" />
                  </a>
                </div>
              </div>
              <div class="col-lg-6">
                <h4 class="fw-bold mb-3">${product.name}</h4>
                <p class="mb-3">Category: ${product.factory}</p>
                <h5 class="fw-bold mb-3"> <fmt:formatNumber type="number" value="${product.price}" />đ</h5>
                <div class="d-flex mb-4">
                  <i class="fa fa-star text-secondary"></i>
                  <i class="fa fa-star text-secondary"></i>
                  <i class="fa fa-star text-secondary"></i>
                  <i class="fa fa-star text-secondary"></i>
                  <i class="fa fa-star"></i>
                </div>
                <p class="mb-4">
                  ${product.shortDesc}
                </p>
                <div class="input-group quantity mb-5" style="width: 100px">
                  <div class="input-group-btn">
                    <button class="btn btn-sm btn-minus rounded-circle bg-light border">
                      <i class="fa fa-minus"></i>
                    </button>
                  </div>
                  <input
                    type="text"
                    class="form-control form-control-sm text-center border-0"
                    value="1"
                  />
                  <div class="input-group-btn">
                    <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                      <i class="fa fa-plus"></i>
                    </button>
                  </div>
                </div>
                <a
                  href="#"
                  class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"
                  ><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a
                >
              </div>
              <div class="col-lg-12">
                <nav>
                  <div class="nav nav-tabs mb-3">
                    <button
                      class="nav-link active border-white border-bottom-0"
                      type="button"
                      role="tab"
                      id="nav-about-tab"
                      data-bs-toggle="tab"
                      data-bs-target="#nav-about"
                      aria-controls="nav-about"
                      aria-selected="true"
                    >
                      Mô tả
                    </button>
                  </div>
                </nav>
                <div class="tab-content mb-5">
                  <div
                    class="tab-pane active"
                    id="nav-about"
                    role="tabpanel"
                    aria-labelledby="nav-about-tab"
                  >

                    <p>
                      ${product.detailDesc}
                    </p>
                  </div>

                  <div class="tab-pane" id="nav-vision" role="tabpanel">
                    <p class="text-dark">
                      Tempor erat elitr rebum at clita. Diam dolor diam ipsum et tempor sit. Aliqu
                      diam amet diam et eos labore. 3
                    </p>
                    <p class="mb-0">
                      Diam dolor diam ipsum et tempor sit. Aliqu diam amet diam et eos labore. Clita
                      erat ipsum et lorem et sit
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4 col-xl-3">
            <div class="row g-4 fruite">
              <div class="col-lg-12">
                <div class="mb-4">
                  <h4>Categories</h4>
                  <ul class="list-unstyled fruite-categorie">
                    <li>
                      <div class="d-flex justify-content-between fruite-name">
                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Apples</a>
                        <span>(3)</span>
                      </div>
                    </li>
                    <li>
                      <div class="d-flex justify-content-between fruite-name">
                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Oranges</a>
                        <span>(5)</span>
                      </div>
                    </li>
                    <li>
                      <div class="d-flex justify-content-between fruite-name">
                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Strawbery</a>
                        <span>(2)</span>
                      </div>
                    </li>
                    <li>
                      <div class="d-flex justify-content-between fruite-name">
                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Banana</a>
                        <span>(8)</span>
                      </div>
                    </li>
                    <li>
                      <div class="d-flex justify-content-between fruite-name">
                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Pumpkin</a>
                        <span>(5)</span>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        <h1 class="fw-bold mb-0">Sản phẩm liên quan</h1>



        <div class="vesitable">
          <div class="owl-carousel vegetable-carousel justify-content-center">
            <!-- Debugging Output -->
            <c:forEach var="item" items="${productByFactory}">
              <div class="border border-primary rounded position-relative vesitable-item">
                <div class="vesitable-img">
                  <img
                          src="/images/product/${item.image}"
                          class="img-fluid w-100 rounded-top"
                          alt=""
                  />
                </div>
                <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px">
                    ${item.factory}
                </div>
                <div class="p-4 pb-0 rounded-bottom">
                  <h4 style="font-size: 15px; text-align: center">
                    <a href="/product/${item.id}">${item.name}</a>
                  </h4>
                  <p style="font-size: 13px; text-align: center; width: 100%">
                      ${item.shortDesc}
                  </p>
                  <div class="d-flex justify-content-between flex-lg-wrap">
                    <p class="text-dark fs-5 fw-bold mx-auto">
                      <fmt:formatNumber type="number" value="${item.price}" />đ
                    </p>
                    <a href="#" class="btn mx-auto border border-secondary rounded-pill px-3 py-1 mb-4 text-primary">
                      <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart
                    </a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>

      </div>
    </div>

    <jsp:include page="/WEB-INF/view/client/layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
  </body>
</html>
