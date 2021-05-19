import 'package:flutter/material.dart';
import 'product_details_screen.dart';

class BestSellingCakes extends StatefulWidget {

  @override
  _BestSellingCakesState createState() => _BestSellingCakesState();
}

class _BestSellingCakesState extends State<BestSellingCakes> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 210,
      child: ListView(
        scrollDirection:Axis.horizontal,
        children:<Widget>[
          TestCakeList(
            productPicture: "assets/images/product1.jpg",
            productName: "Chinese Birthday Cake",
            oldPrice: 119,
            newPrice: 89,
          ),
          TestCakeList(
            productPicture: "assets/images/product2.jpg",
            productName: "Birthday Cake 1",
            oldPrice: 109,
            newPrice: 89,
          ),
          TestCakeList(
            productPicture: "assets/images/product3.jpg",
            productName: "Birthday Cake 2",
            oldPrice: 129,
            newPrice: 99,
          ),
          TestCakeList(
            productPicture: "assets/images/product4.jpg",
            productName: "Birthday Cake 3",
            oldPrice: 139,
            newPrice: 99,
          ),
          TestCakeList(
            productPicture: "assets/images/product5.jpg",
            productName: "Happy Mother Day Cake",
            oldPrice: 119,
            newPrice: 89,
          ),
        ]
      ),
    );
  }
}

class TestCakeList extends StatelessWidget {

  final productName;
  final productPicture;
  final oldPrice;
  final newPrice;

  const TestCakeList({Key key, this.productName, this.productPicture, this.oldPrice, this.newPrice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
      child: Container(
          width: 150,
          child: InkWell(
            highlightColor: Colors.grey,
            onTap: (){
              Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>ProductDetailsScreen(
                      product_name: productName,
                      product_picture: productPicture,
                      product_old_price: oldPrice,
                      product_new_price: newPrice,
                    ))
              );
            },
            child:Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(5),
              ),
              width: 150,
              child: ListTile(
                title: Image.asset(productPicture),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      children:<TextSpan>[
                        TextSpan(text:productName,style: Theme.of(context).textTheme.bodyText2),
                        TextSpan(text:"\nRM$newPrice",style:Theme.of(context).appBarTheme.textTheme.headline2),
                        TextSpan(text:"\t\t\tRM$oldPrice",style: Theme.of(context).appBarTheme.textTheme.headline3),
                      ]
                  )),
                ),
              ),
            ),
          ),
      ),
          
    );
  }
}