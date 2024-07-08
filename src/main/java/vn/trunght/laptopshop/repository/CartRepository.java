package vn.trunght.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.trunght.laptopshop.domain.Cart;
import vn.trunght.laptopshop.domain.User;

public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);

}
