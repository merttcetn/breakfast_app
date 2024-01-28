import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel(
      // * Constructor of the model
      {required this.name,
      required this.iconPath,
      required this.boxColor});

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
        name: 'Salad',
        iconPath: 'assets/icon/plate.svg',
        boxColor: Color(0xff92A3FD)));

    categories.add(CategoryModel(
        name: 'Cake',
        iconPath: 'assets/icon/pancakes.svg',
        boxColor: Color.fromARGB(255, 146, 253, 167)));

    categories.add(CategoryModel(
        name: 'Pie',
        iconPath: 'assets/icon/pie.svg',
        boxColor: Color.fromARGB(255, 253, 146, 183)));

    return categories;
  }
}
