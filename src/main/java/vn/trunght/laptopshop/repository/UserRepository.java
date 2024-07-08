package vn.trunght.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.trunght.laptopshop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User user);

    User findByEmail(String email);

    User findById(long id);

    boolean existsByEmail(String email);

}
