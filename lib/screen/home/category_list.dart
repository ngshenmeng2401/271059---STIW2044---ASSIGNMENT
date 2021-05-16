import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 130,
      child: ListView(
        scrollDirection:Axis.horizontal,
        children:<Widget>[
          Category(
            image_location:'assets/images/birthday-cake.png',
            image_caption: 'Cake',
            press: (){
            },
          ),
          Category(
            image_location:'assets/images/bento-cake.png',
            image_caption: 'Bento Cake',
            press: (){},
          ),
          Category(
            image_location:'assets/images/cupcake.png',
            image_caption: 'Cup Cake',
            press: (){},
          ),
          Category(
            image_location:'assets/images/egg-tart.png',
            image_caption: 'Tart',
            press: (){},
          ),
          Category(
            image_location:'assets/images/puff.png',
            image_caption: 'Cream Puff',
            press: (){},
          ),
        ]
      ),
    );
  }
}

class Category extends StatelessWidget {

  final String image_location, image_caption;
  final VoidCallback press; 

  const Category({Key key, this.image_location, this.image_caption , this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(6.5, 10, 6.5, 10),
      child: InkWell(
        highlightColor: Colors.grey,
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
                  BoxShadow(
                    color:Colors.grey[600],
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1, 1),
                  ),
                ]),
          width: 90,
          child: ListTile(
            title: Image.asset(image_location,width: 90,height: 70,),
            subtitle: Text(image_caption,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,),
          ),
        ),
      ),
    );
  }
}