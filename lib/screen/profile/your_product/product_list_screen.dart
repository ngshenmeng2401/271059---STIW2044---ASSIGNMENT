import 'package:flutter/material.dart';
import 'package:little_cake_story/screen/profile/your_product/cup_cake_list.dart';
import 'package:little_cake_story/screen/profile/your_product/puffs_list.dart';
import 'package:little_cake_story/screen/profile/your_product/tarts_list.dart';
import 'cake_list.dart';
import 'bento_cake_list.dart';

class ProductDashboardScreen extends StatefulWidget {
  @override
  _ProductDashboardScreenState createState() => _ProductDashboardScreenState();
}

class _ProductDashboardScreenState extends State<ProductDashboardScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text('Your Products',style: TextStyle(fontFamily: 'Arial')),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children:<Widget> [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>CakeListScreen())
                  );
                },
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: Offset(1, 2),
                      )
                    ]
                  ),
                  child: Card(
                    child:Column(
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Image.asset("assets/images/birthday-cake.png",
                          width: 80,
                          height: 80,),
                        ),
                        Text("Cake",style: TextStyle(fontSize: 20,fontFamily: 'Calibri',fontWeight: FontWeight.bold),),
                      ]
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>BentoCakeListScreen())
                  );
                },
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: Offset(1, 2),
                      )
                    ]
                  ),
                  child: Card(
                    child:Column(
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Image.asset("assets/images/bento-cake.png",
                          width: 80,
                          height: 80,),
                        ),
                        Text("Bento Cake",style: TextStyle(fontSize: 20,fontFamily: 'Calibri',fontWeight: FontWeight.bold),),
                      ]
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>CupCakeListScreen())
                  );
                },
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: Offset(1, 2),
                      )
                    ]
                  ),
                  child: Card(
                    child:Column(
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Image.asset("assets/images/cupcake.png",
                          width: 80,
                          height: 80,),
                        ),
                        Text("Cup Cake",style: TextStyle(fontSize: 20,fontFamily: 'Calibri',fontWeight: FontWeight.bold),),
                      ]
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>TartsListScreen())
                  );
                },
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: Offset(1, 2),
                      )
                    ]
                  ),
                  child: Card(
                    child:Column(
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Image.asset("assets/images/egg-tart.png",
                          width: 80,
                          height: 80,),
                        ),
                        Text("Tart",style: TextStyle(fontSize: 20,fontFamily: 'Calibri',fontWeight: FontWeight.bold),),
                      ]
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>PuffsListScreen())
                  );
                },
                child: Container(
                  height: 250,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    boxShadow:[
                      BoxShadow(
                        color:Colors.grey[600],
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: Offset(1, 2),
                      )
                    ]
                  ),
                  child: Card(
                    child:Column(
                      children:<Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Image.asset("assets/images/puff.png",
                          width: 80,
                          height: 80,),
                        ),
                        Text("Cream Puff",style: TextStyle(fontSize: 20,fontFamily: 'Calibri',fontWeight: FontWeight.bold),),
                      ]
                    )
                  ),
                ),
              ),
            ],),
        ),
      )
    );
  }
}

