import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var mylist = [
    {
      "Image":
      "https://cdn.pixabay.com/photo/2014/04/02/14/06/t-shirt-306168_1280.png",
      "Name": "Pullover",
      "originalPrice":51.0,
      "color": "Red",
      "size": "Medium",
      "count": 1,
      "price": 51.0,
    },
    {
      "Image":
      "https://cdn.pixabay.com/photo/2016/03/25/09/04/t-shirt-1278404_1280.jpg",
      "Name": "T-Shirt",
      "originalPrice": 30.0,
      "color": "Yellow",
      "size": "Large",
      "count": 1,
      "price": 30.0,
    },
    {
      "Image":
      "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg",
      "Name": "Sport Dress",
      "originalPrice": 43.0,
      "color": "Orange",
      "size": "Small",
      "count": 1,
      "price": 43.0,
    },
  ];

  num calculateTotalPrice() {
    num total = 0;
    mylist.forEach((item) {
      total += (item["price"] as num?) ?? 0;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Colors.white,
        leading: Icon(Icons.search, color: Colors.black,size: 30,),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return ShoppingCartItem(
                  item: mylist[index],
                  onIncrement: () {
                    setState(() {
                      mylist[index]["originalPrice"] =
                          (mylist[index]["originalPrice"] as num?) ?? 0;
                      mylist[index]["price"] =
                          ((mylist[index]["price"] as num?) ?? 0) +
                              ((mylist[index]["originalPrice"] as num?) ?? 0);

                      mylist[index]["count"] =
                          ((mylist[index]["count"] as int?) ?? 0) + 1;

                      if (mylist[index]["count"] == 5) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Item Added"),
                              content: Text(
                                  "You have added 5 ${mylist[index]["Name"]} to your bag!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      mylist[index]["count"] =
                      ((mylist[index]["count"] as int?) ?? 1) > 1
                          ? (mylist[index]["count"] as int) - 1
                          : 1;

                      num originalPrice =
                          (mylist[index]["originalPrice"] as num?) ?? 0;

                      num newPrice = ((mylist[index]["price"] as num?) ?? 0) -
                          originalPrice;

                      mylist[index]["price"] =
                      newPrice >= originalPrice ? newPrice : originalPrice;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Total amount:                                                      \$${calculateTotalPrice()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Congratulations! Your order has been placed."),
                  duration: Duration(seconds: 3), // Optional: Set the duration
                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "CHECK OUT",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  ShoppingCartItem({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(item["Image"] as String),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["Name"] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Color & Size: ${item["color"]} - ${item["size"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: onDecrement,
                            ),
                            Text("${item["count"] ?? 1}"),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: onIncrement,
                            ),
                          ],
                        ),
                        Text(
                          "\$${item["price"] ?? 0}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
