import 'package:flutter/material.dart';
import 'package:shop_online/utils/app_colors.dart';

class CategoryModel {
  final String id;
  final String name;
  final int prudactCount;
  final Color bgColor;
  final Color textColor;
  CategoryModel({
    required this.id,
    this.textColor = AppColors.white,
    required this.name,
    required this.prudactCount,
    this.bgColor = AppColors.prymaryColor,
  });
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'New Arrivals',
    prudactCount: 208,
    bgColor: AppColors.grey,
    textColor: AppColors.black,
  ),
  CategoryModel(
    id: '2',
    name: 'Clothes',
    prudactCount: 358,
    bgColor: AppColors.green,
    textColor: AppColors.white,
  ),
  CategoryModel(
    id: '3',
    name: 'Bags',
    prudactCount: 160,
    bgColor: AppColors.black,
    textColor: AppColors.white,
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    prudactCount: 230,
    bgColor: AppColors.grey,
    textColor: AppColors.black,
  ),
  CategoryModel(
    id: '5',
    name: 'Electronics',
    prudactCount: 101,
    bgColor: AppColors.blue,
    textColor: AppColors.white,
  ),
];
