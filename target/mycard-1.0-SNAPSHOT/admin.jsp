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
        <%@include file="components/common_css_js.jsp" %>
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
                            <!--<div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/" alt="">
                            </div>-->
                            <h1><%= m.get("userCount") %></h1>
                            <h1 class="text-uppercase-muted">Users</h1>
                        </div>
                    </div> 
                </div>
                 <!--second col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <!--<div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/" alt="">
                            </div>-->
                            <h1><%= list.size() %></h1>
                            <h1 class="text-uppercase-muted">Categories</h1>
                        </div>
                    </div> 
                </div>
                  <!--third col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <!--<div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/" alt="">
                            </div>-->
                            <h1><%= m.get("productCount") %></h1>
                            <h1 class="text-uppercase-muted">Products</h1>
                        </div>
                    </div> 
                </div>
            
        </div>
        <!--second row-->
        <div class="row mt-3">
            <!--second row first column-->
            <div class="col-md-6">
                <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <!--<div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/" alt="">
                            </div>-->
                            <p class="mt-2"> Click here to add new category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
            </div>
             <!--second row second column-->
             <div class="col-md-6">
                
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <!--<div class="container">
                                <img style="max-width: 100;" class="img-fluid rounded-circle" src="img/" alt="">
                            </div>-->
                            <p class="mt-2">Click here to add new product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div> 
            </div>
        </div>
        
        
        
        
        
        <!-- add product model-->
         <!-- Modal -->
            <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                  <div class="modal-header custom-bg text-white">
                    <h5 class="modal-title" id="exampleModalLabel">Product details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
               <!--End Form-->
               <form action="categoryservlet" method="post" >
                   <input type="hidden" name="operation" value="addproduct"/>
                          <!--product title-->
                          <div class="form-group">
                              <input type="text" class="form-control"  placeholder="Enter product name" name="pName"required />
                          </div>
                          <div class="form-group">
                              <textarea style="height:150px " class="form-control" placeholder="Enter product description" name="pDesc" required></textarea>
                          </div>
                          <div class="form-group">
                              <input type="number" class="form-control" placeholder="Enter product Price" name="pPrice" required />
                          </div>
                          <div class="form-group">
                              <input type="number" class="form-control"  placeholder="Enter product Discount" name="pDiscount" required />
                          </div>
                          <div class="form-group">
                              <input type="number" class="form-control"  placeholder="Enter product Quantity" name="pQuantity" required />
                          </div>
                          <!--product category-->
                         
                          
                          
                           <div class="form-group">
                               <select name="catId" class="form-control" id="">
                                  <%
                                      for(category c:list){
                                  %> 
                                   
                                  <option value="<%=c.getCategoryId()%>"><%= c.getCategoryTitle() %></option>
                                   <%}%>
                               </select>
                           </div>
                          
                            <!--product file-->
                            <div class="form-group">
                                <label for="pPic"> Select picture of product</label>
                                <br>
                                <input type="file" id="pPic" name="pPic" />
                            </div>
                            
                          <div class="container text-center">
                              <button class="btn btn-outline-success">Add Product</button>
                   </div>
                            
                      </form>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                      </div>
                  </div>
                </div>
              </div>
            </div>
         
         
         
         
         
         
        <!-- add category model-->
         <!-- Modal -->
            <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                  <div class="modal-header custom-bg text-white">
                    <h5 class="modal-title" id="exampleModalLabel">Fill Category details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div class="modal-body">
                      <form action="categoryservlet" method="post">
                          <input type="hidden" name="operation" value="addcategory">
                          <div class="form-group">
                              <input type="text" class="form-control" name="catTitle" placeholder="Enter category name" required />
                          </div>
                          <div class="form-group">
                              <textarea style="height:150px " class="form-control" placeholder="Enter product description" name="catDescription" required></textarea>
                          </div>
                          <div class="container text-center">
                              <button class="btn btn-outline-success">Add Category</button>
                              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                          </div>
                      </form>
                  </div>
                </div>
              </div>
            </div>
        <!--End category model-->
        
        <%@include file="components/common_modals.jsp" %>
        
        
        
        
        
    </body>
</html>
