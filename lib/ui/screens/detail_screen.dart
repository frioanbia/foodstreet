import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodstreet/core/models/foods_mdl.dart';
import 'package:foodstreet/core/services/foods_services.dart';
import 'package:foodstreet/ui/screens/update_screen.dart';

class DetailScreen extends StatelessWidget {
  FoodModel foodModel;
  DetailScreen({this.foodModel});

  void deleteFood(BuildContext context) async {
    await FoodsServices.delete(foodModel);
    Fluttertoast.showToast(
      msg: "Berhasil Menghapus Makanan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 2,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 17.0,
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", (Route<dynamic> routes) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(foodModel.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateScreen(foodModel: foodModel),
                  )),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => deleteFood(context),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: DetailBody(
        foodModel: foodModel,
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  FoodModel foodModel;
  DetailBody({this.foodModel});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // bagian untuk load gambar
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                child: Image.memory(
                  base64Decode(foodModel.image),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 15,
                child: Container(
                  width: 300,
                  color: Colors.black38,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        foodModel.title,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        "Harga: Rp ${foodModel.price}",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.assessment, size: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Description",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    foodModel.fulldesc,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
