import 'package:flutter/material.dart';
import 'package:little_cake_story/model/faq_tile.dart';
import 'package:little_cake_story/data/faq_tile.dart';


class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("FAQ",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: ExpansionPanelList.radio(
              expansionCallback: (index, isExpanded) {
                final tile = advancedTiles[index];
                setState(() => tile.isExpanded = isExpanded);

              },
              children: advancedTiles
                  .map((tile) => ExpansionPanelRadio(
                        value: tile.title,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) => buildTile(tile),
                        body: Column(
                          children: tile.tiles.map(buildTile).toList(),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
    );
  }

  Widget buildTile(AdvancedTile tile) => ListTile(
        // leading: tile.icon != null ? Icon(tile.icon) : null,
        title: Text(tile.title,style: Theme.of(context).textTheme.bodyText1,),
      );
}

