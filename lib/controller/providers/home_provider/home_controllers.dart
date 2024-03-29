import 'dart:developer';
import 'package:evo_mart/model/home/carousel_model.dart';
import 'package:evo_mart/model/home/category_model.dart';
import 'package:evo_mart/model/home/product_model.dart';
import 'package:evo_mart/services/home_services/carousel_service.dart';
import 'package:evo_mart/services/home_services/category_service.dart';
import 'package:evo_mart/services/home_services/product_services.dart';
import 'package:evo_mart/view/product_screen/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(context) {
    getCategory(context);
    getCarousel(context);
    getProduct(context);
  }
  List<CategoryModel> categoryList = [];
  List<CarousalModel> carousalList = [];
  List<ProductModel> productList = [];
  List<ProductModel> dataFound = [];

  CategoryModel? model;
  int activeIndex = 0;
  bool isSelected = false;
  bool isLoading = false;
  CategoryServices category = CategoryServices();
  CarousalService carousal = CarousalService();
  ProductServices product = ProductServices();

  void getCategory(context) async {
    isLoading = true;
    notifyListeners();
    await category.categoryUsers(context).then(
      (value) {
        if (value != null) {
          categoryList = value;
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          return null;
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void getCarousel(context) async {
    isLoading = true;
    notifyListeners();
    await carousal.homeCarousel(context).then((value) {
      if (value != null) {
        log('carousal no null');
        carousalList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  void getProduct(context) async {
    isLoading = true;
    notifyListeners();
    await product.homeProducts(context).then((value) {
      if (value != null) {
        productList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  void smoothIndicator(index) {
    activeIndex = index;
    notifyListeners();
  }

  ProductModel findById(String id) {
    return productList.firstWhere((element) => element.id == id);
  }

  void toProductScreen(context, index) {
    Navigator.of(context)
        .pushNamed(ProductView.routeName, arguments: productList[index].id);
  }

  List<ProductModel> findByCategoryId(String categoryId) {
    return productList
        .where((element) => element.category.contains(categoryId))
        .toList();
  }

  CategoryModel findByName(String id) {
    return categoryList.firstWhere((element) => element.id == id);
  }

  void fromCategoryToProductView(context, index, provider) {
    Navigator.of(context)
        .pushNamed(ProductView.routeName, arguments: provider[index].id);
    notifyListeners();
  }

//badge
  void search(String keyboard) {
    List<ProductModel> results = [];
    if (keyboard.isEmpty) {
      results = productList;
    } else {
      results = productList
          .where(
            (element) => element.name.toLowerCase().contains(
                  keyboard.toLowerCase(),
                ),
          )
          .toList();
    }

    dataFound = results;
    notifyListeners();
  }
}
