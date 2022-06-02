<%@page import="com.learn.mycart.entites.OrderDetail"%>
<%@page import="com.learn.mycart.dao.OrderDetailDao"%>
<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entites.category"%>
<%@page import="com.learn.mycart.entites.product"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.Factoryprovider"%>
<%@page import="com.learn.mycart.entites.user"%>
<%

    user user =(user) session.getAttribute("current-user");
    if(user==null)
    {
    
    session.setAttribute("message", "You are not logged in !! Login first");
    response.sendRedirect("login.jsp");
    return;
}
else
{
    if(user.getUserType().equals("normal"))
    {
        session.setAttribute("message", "You are not Admin!! Do not access this page");
    response.sendRedirect("login.jsp");
    
    
    return;
}
}

%>

 <%
                              
         CategoryDao cdao= new CategoryDao(Factoryprovider.getFacory());
         List<category> list = cdao.getcategoryies();
         
//getting count


       Map<String,Long> m = Helper.getCounts(Factoryprovider.getFacory());
 %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="container admin">
            
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>
       
            <!--first row-->
            <div class="row mt-3">
                <!--first col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/about-us.png" alt="">
                            </div>
                            <h1><%= m.get("userCount") %></h1>
                            <h1 class="text-uppercase-muted">Users</h1>
                        </div>
                    </div> 
                </div>
                 <!--second col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/list.png" alt="">
                            </div>
                            <h1><%= list.size() %></h1>
                            <h1 class="text-uppercase-muted">Categories</h1>
                        </div>
                    </div> 
                </div>
                  <!--third col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/box.png" alt="">
                            </div>
                            <h1><%= m.get("productCount") %></h1>
                            <h1 class="text-uppercase-muted">Products</h1>
                        </div>
                    </div> 
                </div>
            
        </div>
        <!--second row-->
        <div class="row mt-6">
            <!--second row first column-->
            <div class="col-md-6 mt-2">
                <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/add-file.png" alt="">
                            </div>
                            <p class="mt-2"> Click here to add new category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
            </div>
             <!--second row second column-->
             <div class="col-md-6 mt-2">
                
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/add_product.png" alt="">
                            </div>
                            <p class="mt-2">Click here to add new product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div> 
            </div>
    </body>
</html>
