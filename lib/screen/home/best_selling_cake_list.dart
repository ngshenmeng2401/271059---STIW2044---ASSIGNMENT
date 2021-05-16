import 'package:flutter/material.dart';
import 'package:little_cake_story/model/best_selling_product.dart';
import 'package:little_cake_story/screen/home/product_details_screen.dart';

List<BestSellingProduct> productList =[
  BestSellingProduct(code:"CKRV01",name:"Chinese Birthday Cake",image: "assets/images/product1.jpg",rating: 4.5,oldprice: 119,newprice: 89),
  BestSellingProduct(code:"CKRV02",name:"Birthday Cake 1",image: "assets/images/product2.jpg",rating: 4.5,oldprice: 109,newprice: 89),
  BestSellingProduct(code:"CKRV03",name:"Birthday Cake 2",image: "assets/images/product3.jpg",rating: 4.5,oldprice: 129,newprice: 99),
  BestSellingProduct(code:"CKRV04",name:"Birthday Cake 3",image: "assets/images/product4.jpg",rating: 4.5,oldprice: 139,newprice: 99),
  BestSellingProduct(code:"CKRV05",name:"Happy Mother Day Cake",image: "assets/images/product5.jpg",rating: 4.5,oldprice: 119,newprice: 89),
];

class BestSellingCakeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (_,index){
          return Padding(
          padding: const EdgeInsets.all(10),
            child: Hero(
              tag:productList[index].code,
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>ProductDetailsScreen(

                      product_code: productList[index].code,
                      product_name: productList[index].name,
                      product_picture: productList[index].image,
                      product_old_price: productList[index].oldprice.round(),
                      product_new_price: productList[index].newprice.round(),
                    ))
                  );
                },
                child: Container(
                  height: 260,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      ),
                    ]
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:BorderRadius.only(
                        topLeft:Radius.circular(5),
                        topRight:Radius.circular(5),),
                        child: Image.asset(productList[index].image,height: 150,width: 150,)), 
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                        child: Text("${productList[index].name}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).appBarTheme.textTheme.headline2),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text("RM ${productList[index].newprice.round()}",
                            style: TextStyle(fontSize:16,),),
                          ),
                          SizedBox(width:10),
                          Text("RM${productList[index].oldprice.round()}",
                            style: Theme.of(context).appBarTheme.textTheme.headline3,)
                        ],),
                      SizedBox(height:6),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text("${productList[index].rating}",
                            style: TextStyle(fontSize:12,color: Colors.orange),),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.star,size: 16,color: Colors.orange),
                          Icon(Icons.star,size: 16,color: Colors.orange),
                          Icon(Icons.star,size: 16,color: Colors.orange),
                          Icon(Icons.star,size: 16,color: Colors.orange),
                          Icon(Icons.star_half,size: 16,color: Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
    );
  }
}