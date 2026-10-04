import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';

class SearchFilterBar extends StatefulWidget {
  const SearchFilterBar({super.key, required this.query, this.onFilterTap});

  final RxString query;

  final VoidCallback? onFilterTap;

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  late final TextEditingController text;

  @override
  void initState() {
    super.initState();
    text = TextEditingController(text: widget.query.value);
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: text,
            onChanged: (v) => widget.query.value = v,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            style: TextStyle(color: AppColors().accentColor, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: AppColors().textFieldLabelColor,
                fontSize: 14,
              ),
              filled: true,
              fillColor: AppColors().switcherBackgroundColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(AppAssets().searchIcon),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onFilterTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors().switcherBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.tune, color: AppColors().buttonWithBackground),
          ),
        ),
      ],
    );
  }
}
