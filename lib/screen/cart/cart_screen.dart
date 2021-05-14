import 'package:flutter/material.dart';
import 'package:little_cake_story/model/best_selling_product.dart';
import 'package:little_cake_story/model/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final cartList = [
    Cart(code: "CKRV01",name: "Chinese Birthday Cake",image:"assets/images/product1.jpg",oldPrice: 119,newPrice: 89,quantity: 1),
    Cart(code: "CKRV02",name: "Birthday Cake",image:"assets/images/product2.jpg",oldPrice: 109,newPrice: 89,quantity: 1),
    Cart(code: "CKRV03",name: "Birthday Cake",image:"assets/images/product3.jpg",oldPrice: 129,newPrice: 99,quantity: 1),
    Cart(code: "CKRV04",name: "Birthday Cake",image:"assets/images/product4.jpg",oldPrice: 139,newPrice: 99,quantity: 1),
    Cart(code: "CKRV05",name: "Happy Mother Day Cake",image:"assets/images/product5.jpg",oldPrice: 119,newPrice: 89,quantity: 1),
  ];

  BestSellingProduct product = BestSellingProduct(
      code: "CKRV01",
      name: "Chinese Birthday Cake",
      image: "assets/images/product1.jpg",
      rating: 4.5,
      oldprice: 119,
      newprice: 89);

  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'LITTLE CAKE STORY',
            style: TextStyle(fontFamily: 'Arial'),
          ),
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).hoverColor,
          child: Row(
            children: [
              Expanded(
                child: Text("Total :\t RM99.99",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              Expanded(
                child: MaterialButton(
                    color: Colors.red[200],
                    onPressed: () {},
                    child: Text(
                      "Pay",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Calibri'),
                    )),
              )
            ],
          ),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Container(
                  width: 400,
                  height: 130,
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[600],
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(1, 1),
                        ),
                      ]),
                  child: Row(children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(cartList[index].image),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left:10),
                                width: 200,
                                child: Text(
                                  cartList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[200],
                                    size: 25,
                                  ),
                                  onPressed: (){})
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 125, 0),
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                    text: "RM " +
                                        cartList[index].newPrice.round().toString(),
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  TextSpan(
                                      text: "\t\t\t\tRM ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: product.oldprice.round().toString(),
                                      style: Theme.of(context)
                                          .appBarTheme
                                          .textTheme
                                          .headline3)
                                ])),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.fromLTRB(10, 0, 90, 0),
                                  child: Text("★\t\t" + product.rating.toString(),
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 16))),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(children: [
                                    IconButton(
                                        icon: Icon(Icons.remove_circle_outline),
                                        onPressed:() {
                                          setState(() {
                                            if(cartList[index].quantity>0){
                                            cartList[index].quantity--;
                                            }
                                          });
                                        }),
                                    Text("${cartList[index].quantity}"),
                                    IconButton(
                                        icon: Icon(Icons.add_circle_outline),
                                        onPressed: (){
                                          setState(() {
                                            if(cartList[index].quantity<=4){
                                            cartList[index].quantity++;
                                            }
                                          });
                                        }),
                                  ]))
                            ],
                          ),
                        ])
                  ]),
                ),
              );
          },
        )));
  }
}
