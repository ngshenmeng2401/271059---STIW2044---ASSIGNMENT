import 'package:flutter/material.dart';
import 'package:little_cake_story/model/best_selling_product.dart';
import 'product_details_screen.dart';


List<BestSellingProduct> productList =[
  BestSellingProduct(code:"CKRV01",name:"Chinese Birthday Cake",image: "assets/images/product1.jpg",rating: 4.5,oldprice: 119,newprice: 89),
  BestSellingProduct(code:"CKRV02",name:"Birthday Cake 1",image: "assets/images/product2.jpg",rating: 4.5,oldprice: 109,newprice: 89),
  BestSellingProduct(code:"CKRV03",name:"Birthday Cake 2",image: "assets/images/product3.jpg",rating: 4.5,oldprice: 129,newprice: 99),
  BestSellingProduct(code:"CKRV04",name:"Birthday Cake 3",image: "assets/images/product4.jpg",rating: 4.5,oldprice: 139,newprice: 99),
  BestSellingProduct(code:"CKRV05",name:"Happy Mother Day Cake",image: "assets/images/product5.jpg",rating: 4.5,oldprice: 119,newprice: 89),
];

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2), 
        itemBuilder: (BuildContext context, int index){
          return SingleProduct(
            productCode:productList[index].code,
            productName: productList[index].name,
            productPicture: productList[index].image,
            oldPrice: productList[index].oldprice.round(),
            newPrice: productList[index].newprice.round(),
          );
        }
    );
  }
}

class SingleProduct extends StatelessWidget {

  final productCode;
  final productName;
  final productPicture;
  final oldPrice;
  final newPrice;

  const SingleProduct({Key key, this.productName, this.productPicture, this.oldPrice, this.newPrice, this.productCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: productName, 
        child: Material(
          child:InkWell(
            onTap: (){
              Navigator.push(
                context,MaterialPageRoute(builder: (context)=>ProductDetailsScreen(
                  product_code: productCode,
                  product_name: productName,
                  product_picture: productPicture,
                  product_old_price: oldPrice,
                  product_new_price: newPrice,
                ))
              );
            },
            child: GridTile(
              footer: Container(
                height: 60,
                color:Colors.white24,
                child:ListTile(
                  leading:Wrap(
                    direction: Axis.vertical,
                    children:<Widget>[
                      Container(
                        width: 90,
                        child:Text(productName,
                        style: TextStyle(
                        fontFamily: 'Calibri',
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                      )
                    ] 
                  ),
                  title: Text("RM$newPrice",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Calibri',
                      color: Colors.red[300],
                      fontWeight: FontWeight.bold)),
                  subtitle: Text("RM$oldPrice",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Calibri',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough)),
                )
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ]
                ),
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(5),   
                  child: Image.asset(productPicture,
                  fit: BoxFit.cover,),
                ),
              )),
          )
        ), 
      ),
    );
  }
}