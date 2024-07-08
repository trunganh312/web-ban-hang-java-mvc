package vn.trunght.laptopshop.controller.admin;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.trunght.laptopshop.domain.Product;
import vn.trunght.laptopshop.service.ProductService;
import vn.trunght.laptopshop.service.UploadService;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class ProductController {
    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            } else {
                page = 1;
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 2);
        Page<Product> pageProducts = this.productService.fetchAllProduct(pageable);
        List<Product> listProducts = pageProducts.getContent();
        model.addAttribute("products", listProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageProducts.getTotalPages());
        return "/admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "/admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String handleCreateProduct(Model model, @ModelAttribute("newProduct") @Valid Product newProduct,
            BindingResult newProductBindingResult,
            @RequestParam("imageFile") MultipartFile file) {
        if (newProductBindingResult.hasErrors()) {
            return "/admin/product/create";
        }
        String imageProduct = this.uploadService.handleUploadImage(file, "product");
        newProduct.setImage(imageProduct);
        this.productService.handleSaveProduct(newProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("updateProduct", product);
        return "/admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String handleUpdateProduct(Model model, @ModelAttribute("updateProduct") @Valid Product updateProduct,
            BindingResult updateProductBindingResult, @RequestParam("imageFile") MultipartFile file) {
        if (updateProductBindingResult.hasErrors()) {
            return "/admin/product/update";
        }
        Product product = this.productService.getProductById(updateProduct.getId());
        if (product != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleUploadImage(file, "product");
                product.setImage(img);
            }
            product.setDetailDesc(updateProduct.getDetailDesc());
            product.setName(updateProduct.getName());
            product.setFactory(updateProduct.getFactory());
            product.setPrice(updateProduct.getPrice());
            product.setQuantity(updateProduct.getQuantity());
            product.setShortDesc(updateProduct.getShortDesc());
            product.setTarget(updateProduct.getTarget());
            this.productService.handleSaveProduct(product);
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getProductDeletePage(Model model, @PathVariable long id) {
        Product deleteProduct = this.productService.getProductById(id);
        model.addAttribute("deleteProduct", deleteProduct);
        return "/admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String handleDeleteProduct(@ModelAttribute("deleteProduct") Product deleteProduct) {
        this.productService.deleteProductById(deleteProduct.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        model.addAttribute("product", product);
        return "/admin/product/detail";
    }

}
