import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodstreet/ui/screens/add_screen.dart';
import 'package:foodstreet/ui/screens/detail_screen.dart';
import 'package:foodstreet/core/models/foods_mdl.dart';
import 'package:foodstreet/core/services/foods_services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Food Street"),
        leading: Icon(Icons.fastfood, color: Colors.white),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddScreen(),
                  )),
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // bagian untuk itemnya
          Text(
            "Daftar Makanan dan Minuman",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ListFood(),
        ],
      ),
    );
  }
}

class ListFood extends StatefulWidget {
  @override
  _ListFoodState createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  // instance data foods
  List<FoodModel> foods;

  // function load data
  void loadData() async {
    var _foods = await FoodsServices.getAll();
    setState(() {
      foods = _foods;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (foods == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent,
        ),
      );
    }
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          // menambahakan itme list
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 1,
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        foodModel: foods[index],
                      ),
                    )),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // bagian ini tambah image, title dan descripsi
                      Container(
                        width: 64,
                        height: 64,
                        child: Image.memory(
                          base64Decode(foods[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // memberi jarak
                      SizedBox(
                        width: 10,
                      ),
                      // bagian title dan descripsi
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            foods[index].title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // descripsion
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              foods[index].desc,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Rp ${foods[index].price.toString()}",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
