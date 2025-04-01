import 'package:flutter/material.dart';

import '../../../../common/widget/appbar/appbar.dart';
import '../../../../core/l10n/l10n.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.password),
      ),
    );
  }
}
