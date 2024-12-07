import 'dart:convert';

import 'package:crud/ui/screens/AddProduct.dart';
import 'package:flutter/material.dart';
import 'package:crud/ui/screens/AddProduct.dart';
import 'package:crud/ui/screens/TabItemBar.dart';
import 'package:http/http.dart';
import 'package:crud/models/Product.dart';

import '../widgets/ProductItem.dart';
import '../widgets/TabItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();


}

class HomePageState extends State<HomePage> {
  List<Product> productList = [];
  bool _getProductListInProgress = false;
  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'CRUD App ',
            style: TextStyle(fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,

            ),
          ),
          centerTitle: true,

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.only(bottom: 15),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.green.shade100,
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    TabItem(title: 'Iphone List ', count: 1),
                    TabItem(title: 'Android List', count: 2),
                    // TabItem(title: 'Deleted', count: 1),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:  TabBarView(
          children: [
            Visibility(
              visible: _getProductListInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ), child:  ListView.separated(
              itemCount: productList.length ,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: productList[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                  indent: 10,
                  endIndent: 10,
                );
              },
            ),

            ),
           const Center(child:
            const Text(
                'No found data ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),)
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, AddProduct.name);
            },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.lightGreen,
          child: const Icon(Icons.add),


        ),
      ),
    );
  }

  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://mdsakibulhasansanto.com/crud_display.json');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      print(decodedData['status']);
      for (Map<String, dynamic> p in decodedData['data']) {
        Product product = Product(
          id: p['_id'],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          quantity: p['Qty'],
          unitPrice: p['UnitPrice'],
          image: p['Img'],
          totalPrice: p['TotalPrice'],
          createdDate: p['CreatedDate'],
        );
        productList.add(product);
      }
      setState(() {});
    }
    _getProductListInProgress = false;
    setState(() {});
  }



}

