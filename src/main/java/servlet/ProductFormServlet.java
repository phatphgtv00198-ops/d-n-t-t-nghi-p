package servlet;

import dao.CategoryDAO;
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/staff/product-add", "/staff/product-edit"})
public class ProductFormServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categoryList = categoryDAO.findAll();
        request.setAttribute("categories", categoryList);

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            // Chế độ CHỈNH SỬA
            int id = Integer.parseInt(idStr);
            Product product = productDAO.findById(id);
            request.setAttribute("product", product);
            request.setAttribute("pageTitle", "Chỉnh Sửa Sản Phẩm");
        } else {
            // Chế độ THÊM MỚI
            request.setAttribute("product", new Product());
            request.setAttribute("pageTitle", "Thêm Sản Phẩm Mới");
        }

        request.getRequestDispatcher("/staff/product-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String idStr = request.getParameter("productID");
            String productName = request.getParameter("productName");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            Integer stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            Integer categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String description = request.getParameter("description");
            String thumbnailUrl = request.getParameter("thumbnailUrl");
            String videoUrl = request.getParameter("videoUrl");

            Product product = new Product();
            if (idStr != null && !idStr.isEmpty()) {
                product.setProductID(Integer.parseInt(idStr));
            }

            product.setProductName(productName);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setDescription(description);
            product.setThumbnailUrl(thumbnailUrl);
            product.setVideoUrl(videoUrl);

            // Gán Category
            Category category = categoryDAO.findById(categoryId);
            product.setCategory(category);

            // Lưu vào CSDL
            if (product.getProductID() != null) {
                productDAO.update(product);
            } else {
                productDAO.create(product); // 👈 Đã đổi thành create()
            }

            response.sendRedirect(request.getContextPath() + "/staff/products");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());
            doGet(request, response);
        }
    }
}