package servlet;

import dao.CategoryDAO; // Cần import CategoryDAO của bạn
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff/products")
public class StaffProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO(); // Tạo DAO lấy danh mục

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("categoryId");

        // 1. Lấy danh sách sản phẩm (có hỗ trợ filter)
        List<Product> productList = productDAO.findAll(); // Hoặc hàm filter từ DAO của bạn

        // 2. Lấy danh sách danh mục để đổ vào Dropdown Filter
        List<Category> categoryList = categoryDAO.findAll();

        // 3. Tính toán thống kê nhanh
        long totalProducts = productList.size();
        long outOfStock = productList.stream().filter(p -> p.getStockQuantity() <= 0).count();
        long lowStock = productList.stream().filter(p -> p.getStockQuantity() > 0 && p.getStockQuantity() <= 5).count();

        // Trả data về JSP
        request.setAttribute("products", productList);
        request.setAttribute("categories", categoryList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedCategoryId", categoryIdStr);

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("outOfStock", outOfStock);
        request.setAttribute("lowStock", lowStock);

        request.getRequestDispatcher("/staff/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}