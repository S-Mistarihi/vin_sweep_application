import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/ui/custom_text_field.dart';

/// search bar + filter button
/// common between [Home] & [ScanHistory]
class ScanSearchBar extends StatefulWidget {
  const ScanSearchBar({super.key, this.onFilterTap});

  final VoidCallback? onFilterTap;

  @override
  State<ScanSearchBar> createState() => _ScanSearchBarState();
}

class _ScanSearchBarState extends State<ScanSearchBar> {
  final HomeController c = Get.find();
  late final TextEditingController text;

  @override
  void initState() {
    super.initState();
    text = TextEditingController(text: c.query.value);
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
          child: CustomTextField().buildCustomTextField(
            controller: text,
            onChanged: (v) => c.query.value = v,
            hintText: S.of(context).searchLabel,
            iconNameAsset: AppAssets().searchIcon,
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onFilterTap ?? c.openFilter,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors().switcherBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.tune, color: AppColors().firstHeaderShadowColor),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Obx(
                    () => c.hasActiveFilter
                        ? Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: AppColors().cardPopularBack,
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
