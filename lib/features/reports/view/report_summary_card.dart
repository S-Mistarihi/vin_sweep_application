import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/controller/buy_report_controller.dart';

class ReportSummaryCard extends StatelessWidget {
  const ReportSummaryCard({super.key, required this.controller});

  final BuyReportController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors().baseColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors().cardPlanBorder, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Vehicle'),
                const SizedBox(height: 2),
                _value(controller.vehicleName),
                const SizedBox(height: 14),
                _label('VIN'),
                const SizedBox(height: 2),
                _value(controller.vin),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  controller.priceLabel,
                  style: TextStyle(
                    color: AppColors().accentColor,
                    fontSize: controller.usesPackage ? 24 : 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (controller.pricing.value != null)
                  Text(
                    controller.pricing.value!.planLabel,
                    style: TextStyle(
                      color: AppColors().textFieldLabelColor,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: TextStyle(
      color: AppColors().cardUpgradeLabelText,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _value(String text) => Text(
    text,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      color: AppColors().accentColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  );
}
