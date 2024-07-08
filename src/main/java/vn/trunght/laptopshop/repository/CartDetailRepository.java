package vn.trunght.laptopshop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.trunght.laptopshop.domain.Cart;
import vn.trunght.laptopshop.domain.CartDetail;
import vn.trunght.laptopshop.domain.Product;

public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findByCartAndProduct(Cart cart, Product product);

    Optional<CartDetail> findByCart(Cart cart);

    void deleteByCartAndProduct(Cart cart, Product product);

}
