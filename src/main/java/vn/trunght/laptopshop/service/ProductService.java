package vn.trunght.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpSession;
import vn.trunght.laptopshop.domain.Cart;
import vn.trunght.laptopshop.domain.CartDetail;
import vn.trunght.laptopshop.domain.Order;
import vn.trunght.laptopshop.domain.OrderDetail;
import vn.trunght.laptopshop.domain.Product;
import vn.trunght.laptopshop.domain.User;
import vn.trunght.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.trunght.laptopshop.repository.CartDetailRepository;
import vn.trunght.laptopshop.repository.CartRepository;
import vn.trunght.laptopshop.repository.OrderDetailRepository;
import vn.trunght.laptopshop.repository.OrderRepository;
import vn.trunght.laptopshop.repository.ProductRepository;
import vn.trunght.laptopshop.repository.UserRepository;
import vn.trunght.laptopshop.service.specification.ProductSpecs;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, UserRepository userRepository,
            CartRepository cartRepository, CartDetailRepository cartDetailRepository,
            OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;

    }

    public void handleSaveProduct(Product product) {
        this.productRepository.save(product);
    }

    public Page<Product> fetchAllProduct(Pageable pageable) {
        Page<Product> products = this.productRepository.findAll(pageable);
        return products;
    }

    // Tìm kiếm theo tên sản phẩm
    public Page<Product> fetchAllProductWithSpec(Pageable page, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getTarget() == null
                && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null) {
            return this.productRepository.findAll(page);
        }

        Specification<Product> combinedSpec = Specification.where(null);

        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.listTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.listFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    // case 6
    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null); // disconjunction
        for (String p : price) {
            double min = 0;
            double max = 0;

            // Set the appropriate min and max based on the price range string
            switch (p) {
                case "duoi-10-trieu":
                    min = 0;
                    max = 10000000;
                    break;
                case "10-15-trieu":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-20-trieu":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "tren-20-trieu":
                    min = 20000000;
                    max = 200000000;
                    break;
            }

            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.priceRange(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    // Tìm kiếm theo giá min sản phẩm
    // public Page<Product> fetchAllProductWithSpec(Pageable pageable, double min) {
    // Page<Product> products =
    // this.productRepository.findAll(ProductSpecs.min(min), pageable);
    // return products;
    // }

    // Tìm kiếm theo giá max
    // public Page<Product> fetchAllProductWithSpec(Pageable pageable, double max) {
    // Page<Product> products =
    // this.productRepository.findAll(ProductSpecs.max(max), pageable);
    // return products;
    // }

    // Tìm kiếm theo khoảng giá min - max
    // public Page<Product> fetchAllProductWithSpec(Pageable pageable, double min,
    // double max) {
    // Page<Product> products =
    // this.productRepository.findAll(ProductSpecs.priceRange(min, max), pageable);
    // return products;
    // }

    // Tìm kiếm theo nhà sản xuất
    // public Page<Product> fetchAllProductWithSpec(Pageable pageable, List<String>
    // factory) {
    // Page<Product> products =
    // this.productRepository.findAll(ProductSpecs.listFactory(factory), pageable);
    // return products;
    // }

    public Product getProductById(long id) {
        Product product = this.productRepository.findById(id);
        return product;
    }

    public void deleteProductById(long id) {
        this.productRepository.deleteById(id);
    }

    public List<Product> fetchAllProductByFactory(String factory) {
        List<Product> products = this.productRepository.findProductByFactory(factory);
        return products;
    }

    public void handleAddToCart(String email, long productId, HttpSession session) {

        User user = this.userRepository.findByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            // Check xem user đã có cart chưa, nếu chưa thì tạo cart cho user
            if (cart == null) {
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);
            }

            Product product = this.productRepository.findById(productId);

            if (product != null) {
                // Check xem sản phầm đã có trong giỏ hàng chưa
                CartDetail oCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (oCartDetail == null) {
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setProduct(product);
                    cartDetail.setCart(cart);
                    cartDetail.setQuantity(1);
                    cartDetail.setPrice(product.getPrice());
                    this.cartDetailRepository.save(cartDetail);
                    // Update cart sum
                    long s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oCartDetail.setQuantity(oCartDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oCartDetail);
                }

            }
        }

    }

    public Cart getCartById(long id) {
        Optional<Cart> cart = this.cartRepository.findById(id);
        if (cart.isPresent()) {
            return cart.get();
        }
        return null;
    }

    @Transactional
    public void handleDeleteProductCart(Cart cart, Product product, HttpSession session) {
        // Xóa sản phẩm trong cart
        // Update cart sum
        this.cartDetailRepository.deleteByCartAndProduct(cart, product);
        long s = cart.getSum() - 1;
        cart.setSum(s);
        this.cartRepository.save(cart);
        session.setAttribute("sum", s);
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone) {

        // create order
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order = this.orderRepository.save(order);

        // create orderDetail

        // step 1: get cart by user
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();

            if (cartDetails != null) {
                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);
                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                this.cartRepository.deleteById(cart.getId());

                // step 3 : update session
                session.setAttribute("sum", 0);
            }
        }

    }

}
