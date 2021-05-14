import 'package:flutter/material.dart';
import 'package:flutter/src/material/expansion_panel.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  List <ItemList> _data = generateItems(10);

  Widget _buildListPanel(){
    return ExpansionPanelList(
      expansionCallback: (int index,bool isExpanded){
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel> ((ItemList item){
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded){
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandValue),
            subtitle: Text("delete"),
            trailing: Icon(Icons.delete),
            onTap: (){
              setState(() {
                _data.removeWhere((currentItem) => item == currentItem);
              });
            },
          ),
          isExpanded: item.isExpanded,
        );
      }).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("FAQ",style: TextStyle(fontFamily: 'Arial')),
      ),
      body: SingleChildScrollView(
        child: Container(
          // child: _buildListPanel()
        ),
      ),
    );
  }
}

class ItemList{

  String expandValue,headerValue;
  bool isExpanded;

  ItemList({this.expandValue,this.headerValue,this.isExpanded});
}

List<ItemList> generateItems(int numberOfItems){
  return List.generate(numberOfItems, (index){
    return ItemList(
      headerValue: 'Panel $index',
      expandValue: 'This is item number $index'
    );
  });
}
