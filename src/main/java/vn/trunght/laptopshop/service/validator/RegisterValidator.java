package vn.trunght.laptopshop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.trunght.laptopshop.domain.dto.RegisterDTO;
import vn.trunght.laptopshop.service.UserService;

public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private  final UserService userService;
    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if password fields match
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Mật khẩu không khớp.")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        if(userService.isEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại.")
                   .addPropertyNode("email")
                   .addConstraintViolation()
                   .disableDefaultConstraintViolation();
            valid = false;
        }

        // Additional validations can be added here

        return valid;
    }
}
