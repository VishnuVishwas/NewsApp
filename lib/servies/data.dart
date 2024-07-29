// data.dart
// for categories

import '../models/category_model.dart';

List<CategoryModel> getCategories() {
  // list to store all the categories
  List<CategoryModel> category = [];

  // object
  CategoryModel categoryModel = new CategoryModel();

  // business category
  categoryModel.categoryName = 'Business';
  categoryModel.image = 'images/business.jpg';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  // Entertainment
  categoryModel.categoryName = 'Entertainment';
  categoryModel.image = 'images/entertainment.jpg';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  // General
  categoryModel.categoryName = 'General';
  categoryModel.image = 'images/general.jpg';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  // Health
  categoryModel.categoryName = 'Health';
  categoryModel.image = 'images/health.jpg';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  // Sports
  categoryModel.categoryName = 'Sports';
  categoryModel.image = 'images/sports.jpg';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  // return
  return category;
}
