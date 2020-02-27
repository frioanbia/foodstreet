import 'package:foodstreet/core/database/foods_db.dart';
import 'package:foodstreet/core/models/foods_mdl.dart';

class FoodsServices {
  static FoodsDB _foodsDB;
  static Future<List<FoodModel>> getAll() async {
    _foodsDB = FoodsDB();

    var _result = await _foodsDB.getAll();
    var data = new List<FoodModel>();
    _result.forEach((foods) {
      data.add(FoodModel.fromMap(foods));
    });
    return data;
  }

  static Future<bool> create(FoodModel foodModel) async {
    _foodsDB = FoodsDB();
    var _result = await _foodsDB.create(foodModel);
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> update(FoodModel foodModel, String id) async {
    _foodsDB = FoodsDB();
    var _result = await _foodsDB.update(foodModel, int.parse(id));
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> delete(FoodModel foodModel) async {
    _foodsDB = FoodsDB();
    var _result = await _foodsDB.delete(foodModel.id);
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }
}
