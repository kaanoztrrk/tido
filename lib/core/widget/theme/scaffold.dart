import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../blocs/theme_bloc/theme_state.dart';
import '../../locator/locator.dart';

class ViScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ViScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            endDrawer: endDrawer,
            floatingActionButtonLocation: floatingActionButtonLocation,
            body: Stack(
              children: [
                // Arka plan resmi
                if (state.backgroundImage != null)
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(state.backgroundImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // İçerik
                body,
              ],
            ),
          );
        },
      ),
    );
  }
}
