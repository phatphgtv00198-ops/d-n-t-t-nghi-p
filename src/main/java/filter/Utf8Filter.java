package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class Utf8Filter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;

        // Ép kiểu Encoding cho Request (Đọc dữ liệu từ Form/URL không bị lỗi font)
        httpServletRequest.setCharacterEncoding("UTF-8");

        // Ép kiểu Encoding cho Response (Trả về HTML tiếng Việt chuẩn)
        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.setContentType("text/html; charset=UTF-8");

        // Cho phép Request đi tiếp sang các Filter khác hoặc Servlet
        chain.doFilter(httpServletRequest, httpServletResponse);
    }
}