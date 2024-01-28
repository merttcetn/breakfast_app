import 'package:breakfast_app/models/category_model.dart';
import 'package:breakfast_app/models/diet_model.dart';
import 'package:breakfast_app/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popular_diets = [];

  void getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popular_diets = PopularDietsModel.getPopularDiets();
  }

/*
  @override
  void initState() {
    _getCategories();
  }
*/

  @override
  Widget build(BuildContext context) {
    getInitialInfo(); // * render the initial info

    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(children: [
        _searchField(),
        SizedBox(height: 40),
        _categoriesSection(),
        SizedBox(height: 40),
        _dietSection(),
        SizedBox(
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.separated(
              itemCount: popular_diets.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 25,
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        popular_diets[index].iconPath,
                        width: 65,
                        height: 65,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popular_diets[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                          Text(
                            popular_diets[index].level +
                                ' | ' +
                                popular_diets[index].duration +
                                ' | ' +
                                popular_diets[index].calorie,
                            style: const TextStyle(
                                color: Color(0xff7B6F72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: popular_diets[index].boxIsSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: popular_diets[index].boxIsSelected
                          ? [
                              BoxShadow(
                                  color:
                                      const Color(0xff1D1617).withOpacity(0.07),
                                  offset: const Offset(0, 10),
                                  blurRadius: 40,
                                  spreadRadius: 0)
                            ]
                          : []),
                );
              },
            )
          ],
        ),
        SizedBox(
          height: 40,
        )
      ]),
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Recommendation\nfor Diet",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                  width: 210,
                  decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(diets[index].iconPath),
                        Column(
                          children: [
                            Text(
                              diets[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16),
                            ),
                            Text(
                              diets[index].level +
                                  ' | ' +
                                  diets[index].duration +
                                  ' | ' +
                                  diets[index].calorie,
                              style: const TextStyle(
                                  color: Color(0xff7B6F72),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Container(
                          height: 45,
                          width: 130,
                          child: Center(
                            child: Text(
                              'View',
                              style: TextStyle(
                                  color: diets[index].viewIsSelected
                                      ? Colors.white
                                      : const Color(0xffC58BF2),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                diets[index].viewIsSelected
                                    ? const Color(0xff9DCEFF)
                                    : Colors.transparent,
                                diets[index].viewIsSelected
                                    ? const Color(0xff92A3FD)
                                    : Colors.transparent
                              ]),
                              borderRadius: BorderRadius.circular(50)),
                        )
                      ]));
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 25,
            ),
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 120,
          child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => SizedBox(
                    width: 25,
                  ),
              itemBuilder: (context, index) {
                return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          ),
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ));
              }),
        )
      ],
    );
  }

  Container _searchField() {
    return Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Color(0xff1D1617).withOpacity(0.11),
              blurRadius: 40,
              spreadRadius: 0.0)
        ]),
        child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search \"Pancake\"',
              hintStyle: TextStyle(color: Color(0xffDDDADA), fontSize: 16),
              prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset('assets/icon/Search.svg')),
              suffixIcon: Container(
                  width: 100,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VerticalDivider(
                          color: Color(0xffDDDADA),
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/icon/Filter.svg'),
                        ),
                      ],
                    ),
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Breakfast',
        style: TextStyle(
            color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icon/Arrow - Left 2.svg',
          height: 20,
          width: 20,
        ),
        decoration: BoxDecoration(
          color: Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              width: 37,
              child: SvgPicture.asset(
                'assets/icon/dots.svg',
                height: 5,
                width: 5,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(5),
              ),
            ))
      ],
    );
  }
}
