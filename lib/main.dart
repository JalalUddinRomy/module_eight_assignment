import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          child: ProductList()),
    );
  }

}
class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductState();

  }

}
class ProductState extends State<ProductList>{
  List<int> clickCounts = List.filled(20, 0);
  Set<int> selectedProducts = {};
  List<String> products = [
    "Shirt", "Pant", "Panjabi", "Banana", "Watch",
    "Iphone", "Apple", "Cap", "Lungi", "Orange",
    "Grape", "Mango", "Tomato", "Shari", "T-Shirt",
    "Television", "Laptop", "Oppo", "Samsung", "Realme",
  ];
  List<int> price=[
    10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context,index){
            final count = clickCounts[index];
            return Container(
              height: 70,
              child: ListTile(
                leading: Column(
                  children: [
                    Text("${products[index]}"),
                    Text("\$${price[index]}")

                  ],
                ),
                trailing: Column(
                  children: [
                    Text("Count $count "),
                    Container(
                        height: 35,
                        child: ElevatedButton(onPressed:(){
                          if (!selectedProducts.contains(index)) {
                            selectedProducts.add(index);
                          }
                          clickCounts[index]++;

                          setState(() {
                            if(count>=5){
                              showDialog(
                                  barrierDismissible: false,
                                  context: context, builder: (context){
                                return AlertDialog(
                                  title: Text("Congratulation!"),
                                  content: Text("You Have Bought $count  ${products[index]}"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("ok"))
                                  ],
                                );
                              });
                            }
                          });
                        }, child: Text("Buy Now"))),
                  ],
                ),

              ),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return Cart(itemselect: selectedProducts.length);
        }));

      },
        child: Icon(Icons.add_shopping_cart),),
    );
  }

}
class Cart extends StatelessWidget{
  final int itemselect;
  const Cart({super.key,required this.itemselect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          centerTitle: true,
        ),
        body: Center(child: Text("You have selected $itemselect items!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
    );
  }

}

