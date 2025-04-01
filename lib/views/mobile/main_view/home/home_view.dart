import 'package:TiDo/views/mobile/main_view/home/widget/category_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../common/widget/appbar/home_appbar.dart';
import 'widget/home_header.dart';
import 'widget/home_task_stack.dart';

import '../../../../blocs/auth_blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../../../blocs/home_bloc/home_bloc.dart';
import '../../../../blocs/home_bloc/home_state.dart';
import '../../../../core/locator/locator.dart';
import '../../../../core/routes/routes.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../../../../utils/Constant/sizes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<HomeBloc>()),
        BlocProvider.value(value: getIt<SignInBloc>())
      ],
      child: SafeArea(
        child: Scaffold(
          //* Appbar
          appBar: ViHomeAppBar(
            createTaskButton: true,
            height: ViSizes.appBarHeigth * 1.5,
            leadingOnPressed: () => context.push(ViRoutes.create_task),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homestate) {
              List<TaskModel> tasksToShow = homestate.allTasksList;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Home Header
                  const HomeHeader(),
                  const SizedBox(height: ViSizes.spaceBtwItems),
                  //* Category
                  CategorySearch(
                    taskLength: '${homestate.allTasksList.length}',
                  ),
                  //* Task List
                  HomeStackListWidget(tasksToShow: tasksToShow),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
