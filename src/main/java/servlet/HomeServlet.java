package servlet;

import dao.ProductDAO;
import entity.Product;
import service.EntityConnectivity;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "", "/api/search-suggestions"})
public class HomeServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();

        // 1. XỬ LÝ LẤY GỢI Ý TÌM KIẾM (AJAX từ JavaScript gọi vào)
        if ("/api/search-suggestions".equals(servletPath)) {
            response.setContentType("application/json;charset=UTF-8");
            String query = request.getParameter("query");

            EntityManager em = EntityConnectivity.getEntityManager();
            try {
                List<Product> products = em.createQuery(
                                "SELECT p FROM Product p WHERE LOWER(p.productName) LIKE LOWER(:query)", Product.class)
                        .setParameter("query", "%" + (query != null ? query : "") + "%")
                        .setMaxResults(5) // Lấy tối đa 5 gợi ý
                        .getResultList();

                // Tạo chuỗi JSON danh sách tên sản phẩm gợi ý thủ công
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < products.size(); i++) {
                    json.append("\"").append(products.get(i).getProductName().replace("\"", "\\\"")).append("\"");
                    if (i < products.size() - 1) json.append(",");
                }
                json.append("]");

                PrintWriter out = response.getWriter();
                out.print(json.toString());
                out.flush();
            } finally {
                em.close();
            }
            return; // Dừng không chạy xuống dưới
        }

        // 2. XỬ LÝ HIỂN THỊ TRANG CHỦ & TÌM KIẾM SẢN PHẨM (/home hoặc trang gốc)
        try {
            String query = request.getParameter("query");
            List<Product> products;

            if (query != null && !query.trim().isEmpty()) {
                // Gọi hàm findByName đã có sẵn trong ProductDAO
                products = productDAO.findByName(query.trim());
            } else {
                // Lấy toàn bộ sản phẩm nếu không tìm kiếm
                products = productDAO.findAll();
            }

            request.setAttribute("products", products);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Chuyển hướng sang giao diện index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}