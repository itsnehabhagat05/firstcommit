
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/drawer.dart';
import 'package:flutter_catalog/widgets/item_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    
    super.initState();
    loadData();
  }

  loadData()async{
    await Future.delayed(Duration(seconds: 2));
    final catalogJson= await rootBundle.loadString("assets/files/catalog.json");
    // print(catalogJson);
    final decodedData = jsonDecode(catalogJson);
    final productsData =  decodedData["products"];
    CatalogModel.items = List.from(productsData).map<Item>((item)=>Item.fromMap(item)).toList();
    setState(() {
      
    });
  }



  @override
  Widget build(BuildContext context) {
    // int days = 30;
    // String name = "codepur";
    // final dummyList = List.generate(12, (index) => CatalogModel.items[0]);

    return Scaffold(  
      appBar: AppBar(
        
        title: Text("Catalog App",
        ),
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty) 
        ? GridView.builder(
          gridDelegate: 
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            ),
 
          itemBuilder: (context, index) {
            final item = CatalogModel.items[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: GridTile(
                header: Container(child: Text(item.name,style: TextStyle(
                  color: Colors.white
                ),),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                
                ),
                child: Image.network(
                  item.image,
                  
                  ),
                footer: Text(item.price.toString()),
                
                
              )
              );
            },
          itemCount: CatalogModel.items.length,
          ):
        Center(
          child: CircularProgressIndicator(),
        )
        ,
      ) ,
        // body:Center(
        //   child:Container(
        //     child: Text("Hello world - Welcome"), 
        //   ),    
        // ),
        drawer: MyDrawer(),
      );
  }
}