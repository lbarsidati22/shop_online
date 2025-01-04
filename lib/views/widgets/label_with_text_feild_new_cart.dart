import 'package:flutter/material.dart';

import 'package:shop_online/utils/app_colors.dart';

class LabelWithTextFeildNewCart extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  const LabelWithTextFeildNewCart({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
  });

  @override
  State<LabelWithTextFeildNewCart> createState() =>
      _LabelWithTextFeildNewCartState();
}

class _LabelWithTextFeildNewCartState extends State<LabelWithTextFeildNewCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: (value) => value == null || value.isEmpty
              ? '${widget.label} Cannot Be Empty'
              : null,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
              color: AppColors.grey,
            ),
            hintText: widget.hintText,
            fillColor: AppColors.grey2,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.red),
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
