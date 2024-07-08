package vn.trunght.laptopshop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.trunght.laptopshop.domain.dto.LoginDTO;

public class LoginValidator implements ConstraintValidator<RegisterChecked, LoginDTO> {
    @Override
    public boolean isValid(LoginDTO loginDTO, ConstraintValidatorContext context) {
        boolean valid = true;

        return valid;
    }

}
