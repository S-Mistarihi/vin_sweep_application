import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/FAB/controller/fab_controller.dart';
import 'package:vin_sweep_application/features/home/FAB/model/fab_model.dart';
import 'package:vin_sweep_application/features/home/FAB/sub_action_button.dart';

class FabMenuView extends StatelessWidget {
  const FabMenuView({
    super.key,
    required this.actions,
    required this.mainClosedAsset,
    required this.mainOpenAsset,
    this.mainButtonWidth = 210,
    this.mainButtonBottom = -32,
    this.rowBottom = 120,
    this.subButtonSize = 146,
    this.subButtonSpacing = 0,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.76,
    required this.openMainButtonBackgroundColor,
    this.openMainButtonSize = 160,
  });

  final List<FabModel> actions;
  final String mainClosedAsset;
  final String mainOpenAsset;
  final double mainButtonWidth;
  final double mainButtonBottom;
  final double rowBottom;
  final double subButtonSize;
  final double subButtonSpacing;
  final Color overlayColor;
  final double overlayOpacity;

  final Color openMainButtonBackgroundColor;
  final double openMainButtonSize;

  FabController get controller => Get.find<FabController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.speedDialNotifier,
      builder: (context, isOpen, _) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            IgnorePointer(
              ignoring: !isOpen,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: isOpen ? 1 : 0,
                child: GestureDetector(
                  onTap: controller.close,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: overlayColor.withOpacity(overlayOpacity),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: rowBottom,
              child: IgnorePointer(
                ignoring: !isOpen,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 220),
                  opacity: isOpen ? 1 : 0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutBack,
                    scale: isOpen ? 1 : 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < actions.length; i++) ...[
                          if (i != 0) SizedBox(width: subButtonSpacing),
                          SubActionButton(
                            action: actions[i],
                            size: subButtonSize,
                            onPressed: () {
                              controller.close();
                              actions[i].onTap();
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: isOpen ? 12 : mainButtonBottom,
              child: GestureDetector(
                onTap: controller.toggle,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  ),
                  child: isOpen
                      ? Container(
                          key: const ValueKey('open'),
                          width: openMainButtonSize,
                          height: openMainButtonSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: openMainButtonBackgroundColor,
                          ),
                          child: SvgPicture.asset(
                            mainOpenAsset,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SvgPicture.asset(
                          mainClosedAsset,
                          key: const ValueKey('closed'),
                          width: mainButtonWidth,
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
