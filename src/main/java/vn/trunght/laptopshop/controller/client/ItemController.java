package vn.trunght.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.trunght.laptopshop.domain.Cart;
import vn.trunght.laptopshop.domain.CartDetail;
import vn.trunght.laptopshop.domain.Product;
import vn.trunght.laptopshop.domain.Product_;
import vn.trunght.laptopshop.domain.User;
import vn.trunght.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.trunght.laptopshop.service.ProductService;

@Controller
public class ItemController {

    private final ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/{id}")
    public String getDetaiProductPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        List<Product> productByFactory = this.productService.fetchAllProductByFactory(product.getFactory());
        model.addAttribute("productByFactory", productByFactory);
        model.addAttribute("product", product);
        return "/client/product/detail";
    }

    @PostMapping("/add-to-cart/{id}")
    public String handleAddToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return "redirect:/login";
        }
        String email = (String) session.getAttribute("email");
        this.productService.handleAddToCart(email, id, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartId = (long) session.getAttribute("cart_id");
        Cart cart = this.productService.getCartById(cartId);
        List<CartDetail> cartDetails = cart.getCartDetails();
        double totalPrice = 0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("cart", cart);
        return "/client/cart/show";
    }

    @PostMapping("/cart/{id}")
    public String handleDeleteProductCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartId = (long) session.getAttribute("cart_id");
        Cart cart = this.productService.getCartById(cartId);
        Product product = this.productService.getProductById(id);
        this.productService.handleDeleteProductCart(cart, product, session);

        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartId = (long) session.getAttribute("cart_id");

        Cart cart = this.productService.getCartById(cartId);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {

        return "client/cart/thanks";
    }

    // @GetMapping("/products")
    // public String getProductPage(Model model,
    // ProductCriteriaDTO productCriteriaDTO) {
    // int page = 1;
    // try {
    // if (productCriteriaDTO.getPage().isPresent()) {
    // // convert from String to int
    // page = Integer.parseInt(productCriteriaDTO.getPage().get());
    // } else {
    // // page = 1
    // }
    // } catch (Exception e) {
    // // page = 1
    // // TODO: handle exception
    // }

    // Pageable pageable = PageRequest.of(page - 1, 60);

    // Page<Product> prs = this.productService.fetchAllProductWithSpec(pageable,
    // productCriteriaDTO);
    // // case 1
    // // double min = minOptional.isPresent() ?
    // Double.parseDouble(minOptional.get())
    // // : 0;
    // // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
    // min);

    // // case 2
    // // double max = maxOptional.isPresent() ?
    // Double.parseDouble(maxOptional.get())
    // // : 0;
    // // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
    // max);

    // // case 3
    // // String factory = factoryOptional.isPresent() ? factoryOptional.get() : "";
    // // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
    // // factory);

    // // case 4
    // // List<String> factory = Arrays.asList(factoryOptional.get().split(","));
    // // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
    // // factory);

    // // case 5
    // // String price = priceOptional.isPresent() ? priceOptional.get() : "";
    // // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
    // // price);

    // // case 6
    // // List<String> price = Arrays.asList(priceOptional.get().split(","));
    // // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
    // // price);

    // List<Product> products = prs.getContent();

    // model.addAttribute("products", products);
    // model.addAttribute("currentPage", page);
    // model.addAttribute("totalPages", prs.getTotalPages());
    // return "client/product/show";
    // }

    @GetMapping("/products")
    public String getProductPage(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {
        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                // convert from String to int
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        // check sort price
        Pageable pageable = PageRequest.of(page - 1, 3);

        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 10, Sort.by(Product_.PRICE).ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(page - 1, 10, Sort.by(Product_.PRICE).descending());
            }
        }

        Page<Product> prs = this.productService.fetchAllProductWithSpec(pageable, productCriteriaDTO);

        List<Product> products = prs.getContent().size() > 0 ? prs.getContent()
                : new ArrayList<Product>();

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + page, "");
        }

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("queryString", qs);
        return "client/product/show";
    }

}
