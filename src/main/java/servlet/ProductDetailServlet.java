package servlet;

import dao.ProductDAO;
import dao.ProductMediaDAO;
import entity.Product;
import entity.ProductMedia;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private ProductMediaDAO mediaDAO = new ProductMediaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        // 1. Kiểm tra tham số ID
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int productId = Integer.parseInt(idStr);

            // 2. Lấy thông tin sản phẩm chính
            Product product = productDAO.findById(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            // 3. Lấy danh sách ảnh/video chi tiết từ bảng ProductMedia
            List<ProductMedia> mediaList = mediaDAO.findByProductId(productId);

            // 4. Gán thuộc tính sang JSP
            request.setAttribute("product", product);
            request.setAttribute("mediaList", mediaList);

            // 5. Forward sang trang chi tiết
            request.getRequestDispatcher("/product-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Trường hợp user nhập id không phải là số (VD: /product-detail?id=abc)
            response.sendRedirect(request.getContextPath() + "/home");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}