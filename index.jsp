<%-- 
    Document   : index
    Created on : 24-Feb-2022, 8:12:03 PM
    Author     : priya
--%>

<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entites.category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entites.product"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.Factoryprovider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        

 <!-- <div class="container">
 
  <h3>Bootstrap 4 Carousel Demo</h2>
 
 
 
<div id="bs4-slide-carousel" class="carousel slide" data-ride="carousel" >
 
  <ol class="carousel-indicators">
 
    <li data-target="#bs4-slide-carousel" data-slide-to="0" class="active"></li>
 
    <li data-target="#bs4-slide-carousel" data-slide-to="1"></li>
 
    <li data-target="#bs4-slide-carousel" data-slide-to="2"></li>
 
  </ol>
 
  <div class="carousel-inner">
 
    <div class="carousel-item active">
 
      <img class="d-inline w-100" src="img/choli1.jpg" alt="Slide One">
 
      <!--Captions for the slides go here -->
 
        <!--<div class="carousel-caption text-success d-none d-sm-block">
 
        </div>
 
      <!--Captions ending here for slide 1--> 
 
   <!--</div>
 
    <div class="carousel-item">
 
      <img class="d-inline w-100" src="img/dress.jpg" alt="Slide Two">
 
      <!--Captions for the slides go here -->

       
 
       <!-- </div>
 
      <!--Captions ending here for slide 2-->       
 
    <!--</div>
 
    <div class="carousel-item">
 
      <img class="d-block w-100" src="img/olp2.jpg" alt="Slide Three">
 
      <!--Captions for the slides go here -->
 
        <!--<div class="carousel-caption text-warning d-none d-sm-block">
 
 
        </div>
 
      <!--Captions ending here for slide 3-->       
 
    <!--</div>
 
  </div>
 
  <a class="carousel-control-prev" href="#bs4-slide-carousel" role="button" data-slide="prev">
 
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
 
    <span class="sr-only">Previous</span>
 
  </a>
 
  <a class="carousel-control-next" href="#bs4-slide-carousel" role="button" data-slide="next">
 
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
 
    <span class="sr-only">Next</span>
 
  </a> 
 
</div>
 
 
 
</div>-->
        <div class="row mt-2 mx-3">
            
            <%
                String cat = request.getParameter("category");
                
                
             ProductDao dao = new ProductDao(Factoryprovider.getFacory());
             List<product> list = dao.getAllProducts();
             
            
                CategoryDao cdao = new CategoryDao(Factoryprovider.getFacory());
                List<category>clist = cdao.getcategoryies();
             %>
            <!--  if(cat==null || cat.trim().equals("all"))
             {
              list = dao.getAllProducts();
            }else {
            
                int cid = Integer.parseInt(cat.trim());
                list=dao.getAllProductsById(cid);
                
            }
            // List<product> list = dao.getAllProducts();
           
            -->
            
            <!--show categories-->
            <div class="col-md-2">
                
                 <%
		       // To give color in category section
		        String f="";
		         if(cat==null){
		        	 f="active";
		         }
		         else if(cat.trim().equals("all")){
		        	 f="active";
		         }
		         else f="";
		       %>
                
                <div class="list-group" mt-4>
                     <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                         All Products
                     </a>
                    <%
			// To give color in category section
              for(category c:clist ){
            	 
            %>
                                
                
                
                
                
                    <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action "><%= c.getCategoryTitle()%></a>
  
                    
                    
                    
                    <%
                }
                    
                %>
                
                </div>
            </div>
               
                <!-- show products-->
                <div class="col-md-10">
                  <!--row-->  
                  <div class="row mt-4">
                      <!--col:12-->
                      <div class="col-md-12">
                          <div class="card-columns">
                          <!--traversing product-->
                          <%
                          for(product p:list){
                          
                          %>
                          <!--product card-->
                          
                          <div class="card product-card">
                              <div class="container text-center">
                              <img class="card-img-top" src="img/products/<%= p.getpPhoto()%>" style="max-heigh:270px;max-width:100%;width:auto; " clas="card-img-topm-m2" alt="Card image cap">
                              </div>
                              <div class="card-body">
                                  <h5 class="card-title"><%= p.getpName() %></h5>
                                  <p class="card-text"><%= Helper.get10Words(p.getpDesc())%></p>
                              </div>
                              
                              <div class="card-footer text-center">
                                  <button  class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId()%>,'<%= p.getpName()%>',<%= p.getPriceAfterApplyingDiscount()%>)"> Add to Cart </button>                                  
                                  <button class="btn btn-outline-success">  &#8377; <%= p.getPriceAfterApplyingDiscount()%>/- <span class="text-secondary discount-lable"> &#8377;<%= p.getpPrice()%><%= p.getpDiscount()%>%off</span></button>
                              </div>
                          </div>
                          
                          <% } 
                            if(list.size()==0)
                            {
                              out.println("<h3>No Item in This Category</h3>");
                            }
                          
                          
                          %>
                          </div>  
                      </div>
                  </div>
        </div>
  </div>
                    
                          
                          
                          
                          
                          
                          <%@include file="components/common_modals.jsp" %>
                          
    </body>
</html>
