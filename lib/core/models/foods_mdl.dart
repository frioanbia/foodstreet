class FoodModel {
  final String id;
  final String title;
  final String desc;
  final String fulldesc;
  final int price;
  final String image;

  FoodModel(
      {this.id, this.title, this.desc, this.fulldesc, this.price, this.image});

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'].toString(),
      title: map['title'].toString(),
      desc: map['desc'].toString(),
      fulldesc: map['fulldesc'].toString(),
      price: int.parse(map['price'].toString()),
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['desc'] = desc;
    map['fulldesc'] = fulldesc;
    map['price'] = price;
    map['image'] = image;
    return map;
  }
}
