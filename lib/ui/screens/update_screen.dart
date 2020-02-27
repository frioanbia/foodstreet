import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodstreet/core/models/foods_mdl.dart';
import 'package:foodstreet/core/services/foods_services.dart';
import 'package:foodstreet/ui/widgets/custom_textfield.dart';

class UpdateScreen extends StatelessWidget {
  FoodModel foodModel;
  UpdateScreen({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Update Food"),
      ),
      body: UpdateFood(
        foodModel: foodModel,
      ),
    );
  }
}

class UpdateFood extends StatefulWidget {
  FoodModel foodModel;
  UpdateFood({this.foodModel});
  @override
  _UpdateFoodState createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  File image;
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var fulldescController = TextEditingController();
  var priceController = TextEditingController();

  void imagePick() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        image = _image;
      });
    }
  }

  void updateMakanan() async {
    if (titleController.text.isNotEmpty ||
        descController.text.isNotEmpty ||
        fulldescController.text.isNotEmpty ||
        priceController.text.isNotEmpty) {
      FoodModel foodModel = FoodModel(
        title: titleController.text,
        desc: descController.text,
        fulldesc: fulldescController.text,
        price: int.parse(priceController.text),
        image: image != null
            ? base64Encode(image.readAsBytesSync())
            : widget.foodModel.image,
      );
      var result = await FoodsServices.update(foodModel, widget.foodModel.id);
      // jika isntert sukses
      if (result) {
        Fluttertoast.showToast(
          msg: "Berhasil Mengupdate Makanan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/home", (Route<dynamic> routes) => false);
        });
      } else {
        Fluttertoast.showToast(
          msg: "Gagal Mengupdate Makanan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Silahkan Isi Semua Kolom",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void loadFood() {
    setState(() {
      titleController.text = widget.foodModel.title;
      descController.text = widget.foodModel.desc;
      fulldescController.text = widget.foodModel.fulldesc;
      priceController.text = widget.foodModel.price.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadFood();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              child: InkWell(
                onTap: () => imagePick(),
                child: image == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        color: Colors.greenAccent,
                        size: 100,
                      )
                    : Image.file(
                        image,
                        width: 100,
                        height: 100,
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: titleController,
            hint: "Nama Makanan",
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: descController,
            hint: "Deskripsi",
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: fulldescController,
            hint: "Full Deskripsi",
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: priceController,
            hint: "Harga",
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () => updateMakanan(),
              color: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Update Makanan",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
