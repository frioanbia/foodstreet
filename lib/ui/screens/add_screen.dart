import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodstreet/core/models/foods_mdl.dart';
import 'package:foodstreet/core/services/foods_services.dart';
import 'package:foodstreet/ui/widgets/custom_textfield.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Add Food"),
      ),
      body: AddBody(),
    );
  }
}

class AddBody extends StatefulWidget {
  @override
  _AddBodyState createState() => _AddBodyState();
}

class _AddBodyState extends State<AddBody> {
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

  void addMakanan() async {
    if (titleController.text.isNotEmpty ||
        descController.text.isNotEmpty ||
        fulldescController.text.isNotEmpty ||
        priceController.text.isNotEmpty ||
        image != null) {
      FoodModel foodModel = FoodModel(
        title: titleController.text,
        desc: descController.text,
        fulldesc: fulldescController.text,
        price: int.parse(priceController.text),
        image: base64Encode(image.readAsBytesSync()),
      );
      var result = await FoodsServices.create(foodModel);

      // jika sukses insert
      if (result) {
        Fluttertoast.showToast(
          msg: "Berhasil Menambah Makanan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 17.0,
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/home", (Route<dynamic> routes) => false);
        });
      } else {
        Fluttertoast.showToast(
          msg: "Gagal Menambah Makanan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Silahkan Isi Semua Kolom",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 17.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              type: TextInputType.number,
              controller: priceController,
              hint: "Harga",
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () => addMakanan(),
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Tambah Makanan",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
