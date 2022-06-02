function add_to_cart(pid,pname,price)
{
    let cart = localStorage.getItem("cart");
    
        if(cart == null)
        {
        //no cart yet
        let products=[];
        let product = { productId: pid,productName: pname,productQuantity:1,productPrice:price }
        products.push(product);
        localStorage.setItem("cart",JSON.stringify(products));
       // console.log("product is added for the first time")
        showToast("Iteam is added to cart")
        } else
    {
       
        //cart is already present
      let pcart = JSON.parse(cart);
        let oldproduct = pcart.find((item)=> item.productId == pid)
        if(oldproduct)
        {
            // we have to increase the quantity
           oldproduct.productQuantity = oldproduct.productQuantity+1
            pcart.map((item)=>{
                if(item.productId == oldproduct.productId)
                {
                    item.productQuantity = oldproduct.productQuantity;
                }
            })
            localStorage.setItem("cart",JSON.stringify(pcart));
            //console.log("product quantity is increased")
            showToast(oldProduct.productName+" quantity is increased,Quantity"+oldProduct.productQuantity)
        }
        else
        {
            //we have to add the product
             let product={ productId:pid,productName:pname,productQuantity:1,productPrice:price }
             pcart.push(product);
             localStorage.setItem("cart",JSON.stringify(pcart))
              //console.log("product is added")\
              showToast("product is added to cart");
        }
    }
    updateCart();
}
//update cart
function updateCart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if(cart==null || cart.length==0)
    {
        console.log("cart is empty!!")
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>cart does not have any items </h3>");
        $(".checkout-btn").attr('disabled',true);
    }

       else
    {
        //there is some in cart to show
        console.log(cart)
         $(".cart-items").html(`(${cart.length})`);
        let table=`
            <table class='table'>
            <thead class='thead-light'>
            <tr>
            <th>Item Name</th>
            <th>price</th>
            <th>Quantity</th>
            <th>Total price/th>
            <th>Action/th>
            </tr>
            </thead>
            
    `;
    
        let totalPrice= 0;
        cart.map((item)=>{
            table+= `
                    <tr>
            <td> ${item.productName} </td>
            <td>${item.productPrice}</td>
            <td>${item.productQuantity}</td>
            <td>${item.productQuantity*item.productPrice}</td>
            <td><button onclick='deleteItemFromCart(${item.productId})' class="btn btn-danger btn-sm">Remove</button></td>
           </tr>
           
           `
            totalPrice += item.productPrice*item.productQuantity;
           
        })
        
    
      table = table+`
                <tr><td colspan='5' class='text-right font-weight-bold m-5'> Total Price: ${totalPrice}</td></tr>

        </table>`
       $(".cart-body").html(table);
     $(".checkout-btn").attr('disabled',false);
 
   }

}



//delete item
function deleteItemFromCart(pid)
{
    let cart  = JSON.parse(localStorage.getItem('cart'));
    let newcart = cart.filter((item)=>item.productId!=pid)
    localStorage.setItem('cart',JSON.stringify(newcart));
    updateCart();
    showToast("Item is Removed from cart")
}


$(document).ready(function(){
    updateCart()
})


//create a order from javascripts
const paymentStart=()=>{
	//console.log("payment started...");
  //to get value how much payment do
	let amount=finalPrice+"";
	let username=$('#userName').val();
	let usermail=$('#usermail').val();
	let usermobile=$('#usermobile').val();
	let useraddr=$('#useraddr').val();
	console.log(useraddr);
	if(amount==null || amount==''){
		alert("amount is required");
		return;
	}
	
	//to create order
	//we use ajax to send request to server to create order
	
	$.ajax({
		
		url:("./CreateOrder"),
		data:JSON.stringify({price:amount,uname:username, uemail:usermail, umo:usermobile, uaddr:useraddr}),
		dataType: 'json',
        contentType:'application/json',
		type:'POST',
			success:function(data,textStatus, jqXHR){
				//This function is involked when success
			//	console.log(textStatus);
			//	alert("Data inserted..")
			//	console.log(data);
				
				let options={
						key:'rzp_test_Ef7CdBS83L4yE0',
						amount:data.amount,
						currency:'INR',
						name:'MyCart',
						description:'pay your bill',
						image:'img/logo.png',
						order_id:data.id,
						handler:function(response){
//							console.log(response.razorpay_payment_id);
//							console.log(response.razorpay_order_id);
//							console.log(response.razorpay_signature);
//							console.log('payment successfully!!');
							Swal.fire({
								  position: 'top-center',
								  icon: 'success',
								  title: 'Congratulation! Payment Success',
								  showConfirmButton: false,
								  timer: 3000
								})

						},
						"prefill": {
					        "name": username,
					        "email": usermail,
					        "contact": usermobile
					    },
					    "notes": {
					        "address": "MyCart is best plateform"
					    },
					    "theme": {
					        "color": "#FF3D00"
					    }

				};
				let rzp1 = new Razorpay(options);
				rzp1.on('payment.failed', function (response){
				        alert(response.error.code);
				        alert(response.error.description);
				        alert(response.error.source);
				        alert(response.error.step);
				        alert(response.error.reason);
				        alert(response.error.metadata.order_id);
				        alert(response.error.metadata.payment_id);
				        Swal.fire({
				        	  icon: 'error',
				        	  title: 'Oops...',
				        	  text: 'Something went wrong!',
				        	  timer: 6000
				        	})
				});
				rzp1.open();
				
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				//invoked when error created
				console.log("error")
			}
		
	})
};


 
function showToast(content){
$("#toast").addClass("display");
$("#toast").html(content);
setTimeout(()=>{
$("#toast").removeClass("display");
},2000);
}



function goToCheckout(){
    
    window.location ="checkout.jsp"
}

