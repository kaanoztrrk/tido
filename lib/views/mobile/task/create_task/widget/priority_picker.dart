import 'package:TiDo/common/styles/container_style.dart';
import 'package:TiDo/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/Constant/colors.dart';
import '../../../../../utils/Constant/sizes.dart';

class ViPriorityPicker extends StatefulWidget {
  final String initialPriority;
  final ValueChanged<String> onPrioritySelected;

  const ViPriorityPicker({
    Key? key,
    required this.initialPriority,
    required this.onPrioritySelected,
  }) : super(key: key);

  @override
  _ViPriorityPickerState createState() => _ViPriorityPickerState();
}

class _ViPriorityPickerState extends State<ViPriorityPicker> {
  late String selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.initialPriority;
  }

  void _showPriorityPicker(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(ViSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLocalizations.of(context)!.low,
              AppLocalizations.of(context)!.medium,
              AppLocalizations.of(context)!.high
            ].map((priority) {
              return ListTile(
                title: Text(priority.toUpperCase(),
                    style: TextStyle(
                        color: selectedPriority == priority
                            ? AppColors.primary
                            : AppColors.secondaryText,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  setState(() {
                    selectedPriority = priority;
                  });
                  widget.onPrioritySelected(priority);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViContainer(
      margin: EdgeInsets.only(top: ViSizes.spaceBtwItems),
      borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg),
      child: ListTile(
        title: Text(AppLocalizations.of(context)!.priority,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(selectedPriority.toUpperCase(),
            style: const TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold)),
        onTap: () => _showPriorityPicker(context),
      ),
    );
  }
}
