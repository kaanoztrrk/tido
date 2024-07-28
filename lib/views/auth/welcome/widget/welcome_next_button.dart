import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/utils/Constant/text_strings.dart';

import '../../../../blocs/main_bloc/main_bloc.dart';
import '../../../../blocs/main_bloc/main_event.dart';
import '../../../../blocs/main_bloc/main_state.dart';
import '../../../../common/widget/button/primary_button.dart';

class WelcomeNextButton extends StatelessWidget {
  const WelcomeNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      right: 20,
      left: 20,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return ViPrimaryButton(
            text: state.currentPageIndex == 2 ? ViTexts.done : ViTexts.next,
            onTap: () {
              if (state.currentPageIndex == 2) {
                // Perform Done action
                context.read<MainBloc>().add(CompleteOnBoarding(context));
              } else {
                context.read<MainBloc>().add(NextPage(context));
              }
            },
          );
        },
      ),
    );
  }
}
