<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%=request.getContextPath()%>/adminController/View.htm">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Admin</div>
    </a>
     <hr class="sidebar-divider">
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/adminController/View.htm">
            <i class="fas fa-shopping-bag"></i>
            <span>Menu chính</span></a>
    </li>
    <hr class="sidebar-divider">
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/adminOrder/View.htm">
            <i class="fas fa-shopping-bag"></i>
            <span>Đơn Hàng</span></a>
    </li>
     <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/adminOrder/orderFalse.htm">
            <i class="fas fa-times-circle"></i>
            <span>Đơn Hàng Từ Chối</span></a>
    </li>
    <hr class="sidebar-divider">
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/adminComment/View.htm">
            <i class="fas fa-comment"></i>
            <span>Bình Luận</span></a>
    </li>
    <hr class="sidebar-divider">
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/adminStar/View.htm">
            <i class="fas fa-star"></i>
            <span>Đánh Giá</span></a>
    </li>
    <hr class="sidebar-divider">
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-fw fa-table"></i>
            <span>Các Bảng</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">Custom Table:</h6>
                <a class="collapse-item" href="<%=request.getContextPath()%>/adminCategories/index.htm">Danh Mục Sản Phẩm</a>
                <a class="collapse-item" href="<%=request.getContextPath()%>/adminProduct/View.htm">Sản Phẩm</a>
                <a class="collapse-item" href="<%=request.getContextPath()%>/adminBlog/View.htm">Bài Viết</a>
                <a class="collapse-item" href="<%=request.getContextPath()%>/adminUsers/View.htm">Người Dùng</a>
                <a class="collapse-item" href="<%=request.getContextPath()%>/adminBanner/View.htm">Quảng Cáo</a>
                <a class="collapse-item" href="<%=request.getContextPath()%>/adminContact/View.htm">Thông Tin Shop</a>
            </div>
        </div>
    </li>
    <hr class="sidebar-divider">
    <!-- Heading -->
    <div class="sidebar-heading">
        Thêm
    </div>
    <!-- Nav Item - Pages Collapse Menu -->
     <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/adminController/profile.htm">
            <i class="fas fa-id-card"></i>
            <span>Người Quản Trị</span></a>
    </li>
    <hr class="sidebar-divider d-none d-md-block">
    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->