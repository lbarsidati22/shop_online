
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'prudactCount': prudactCount,
      'bgColor': bgColor.value,
      'textColor': textColor.value,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      prudactCount: map['prudactCount']?.toInt() ?? 0,
      bgColor: Color(map['bgColor']),
      textColor: Color(map['textColor']),
    );
  }
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
