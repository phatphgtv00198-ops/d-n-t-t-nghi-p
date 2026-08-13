package servlet;

import service.EntityConnectivity;
import util.AuthUtil;

import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Kiểm tra trạng thái đăng nhập với AuthUtil
        if (!AuthUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Kiểm tra vai trò (Chỉ Manager hoặc Staff mới được vào trang quản trị)
        if (!AuthUtil.isManager(request) && !AuthUtil.isStaff(request)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 3. Lấy dữ liệu thống kê từ database bằng EntityConnectivity
        EntityManager em = EntityConnectivity.getEntityManager();
        try {
            Long totalAccounts = em.createQuery("SELECT COUNT(a) FROM Account a", Long.class).getSingleResult();
            request.setAttribute("totalAccounts", totalAccounts);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        // 4. Chuyển tiếp tới trang dashboard.jsp
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}