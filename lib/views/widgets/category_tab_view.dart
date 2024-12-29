import 'package:flutter/material.dart';
import 'package:shop_online/models/category_model.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyCategories.length,
        itemBuilder: (context, index) {
          final categories = dummyCategories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () {},
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: categories.bgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        categories.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: categories.textColor,
                            ),
                      ),
                      Text(
                        '${categories.prudactCount} Prudacts',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: categories.textColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
