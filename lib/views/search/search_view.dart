import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tido/blocs/home_bloc/home_bloc.dart';
import 'package:tido/common/widget/Text/title.dart';
import 'package:tido/core/locator/locator.dart';
import 'package:tido/utils/Constant/image_strings.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../../common/empty_screen/empty_screen.dart';
import '../../common/styles/container_style.dart';
import '../../common/widget/appbar/appbar.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: Scaffold(
        appBar: const ViAppBar(
          showBackArrow: true,
          centerTitle: true,
          title: Text("To-Do Task Search"),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: ViSizes.defaultSpace / 2),
          child: Column(
            children: [
              ViContainer(
                padding: const EdgeInsets.only(left: 5, top: 10),
                height: 65,
                decoration: BoxDecoration(
                  color: dark ? AppColors.black : AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  onChanged: (query) {
                    // SearchTasksEvent'i tetikleyin
                    BlocProvider.of<HomeBloc>(context)
                        .add(SearchTasksEvent(query));
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: "Search",
                    hintStyle: dark
                        ? ViTextTheme.darkTextTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.normal)
                        : ViTextTheme.ligthTextTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.searchResults.isEmpty) {
                      return ListView.builder(
                        itemCount: state.allTasksList.length,
                        itemBuilder: (context, index) {
                          var task = state.allTasksList[index];

                          return ViContainer(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: ViSizes.defaultSpace),
                            padding: EdgeInsets.all(ViSizes.defaultSpace),
                            height: 120,
                            borderRadius: BorderRadius.circular(30),
                            child: Text(
                              task.title,
                              style: dark
                                  ? ViTextTheme.darkTextTheme.headlineMedium
                                      ?.copyWith(color: AppColors.white)
                                  : ViTextTheme.ligthTextTheme.headlineMedium
                                      ?.copyWith(color: AppColors.white),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          var task = state.searchResults[index];

                          return ViContainer(
                            height: 80,
                            bgColor: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30),
                            child: ListTile(
                              title: Text(
                                task.title,
                                style: dark
                                    ? ViTextTheme.darkTextTheme.headlineMedium
                                        ?.copyWith(color: AppColors.white)
                                    : ViTextTheme.ligthTextTheme.headlineMedium
                                        ?.copyWith(color: AppColors.white),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
