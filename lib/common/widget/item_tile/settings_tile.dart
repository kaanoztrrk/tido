import 'package:flutter/material.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../styles/container_style.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ViContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: BorderRadius.circular(ViSizes.borderRadiusMd),
          bgColor: AppColors.darkerGrey.withValues(alpha: 0.2),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
