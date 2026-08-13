package filter;

import java.io.IOException;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.AuthUtil;

@WebFilter(urlPatterns = { "/dashboard", "/manager/*", "/staff/*" }, dispatcherTypes = { DispatcherType.REQUEST })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // 1. Loại trừ trang Login và static files để tránh lặp vô tận
        if (uri.endsWith("/login") || uri.contains("/css/") || uri.contains("/js/")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Chưa đăng nhập -> Bắt về /login
        if (!AuthUtil.isAuthenticated(req)) {
            req.getSession().setAttribute("REDIRECT_URL", uri);
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // 3. Khách hàng cố truy cập vùng quản trị -> Chặn 403
        if (AuthUtil.isCustomer(req)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }

        // 4. Vùng dành riêng cho Manager
        if (uri.startsWith(contextPath + "/manager/") && !AuthUtil.isManager(req)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Chỉ Quản lý mới có quyền thao tác!");
            return;
        }

        chain.doFilter(request, response);
    }
}