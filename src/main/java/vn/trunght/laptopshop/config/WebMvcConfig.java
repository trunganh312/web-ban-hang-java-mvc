package vn.trunght.laptopshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

    // Config đường link đến view
    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        return bean;
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(viewResolver());
    }

    // Config đường link đên resources
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Link đến file /resources/css/
        registry.addResourceHandler("/css/**").addResourceLocations("/resources/css/");

        // Link đến file /resources/js/
        registry.addResourceHandler("/js/**").addResourceLocations("/resources/js/");

        // Link đến file /resources/images/
        registry.addResourceHandler("/images/**").addResourceLocations("/resources/images/");

        // Link đến file /resources/client/
        registry.addResourceHandler("/client/**").addResourceLocations("/resources/client/");
    }

}
