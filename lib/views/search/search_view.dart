import 'package:TiDo/common/widget/admob_banner/adMob_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/home_bloc/home_event.dart';
import '../../blocs/home_bloc/home_state.dart';
import '../common/empty_screen/empty_screen.dart';
import '../../common/styles/container_style.dart';
import '../../common/widget/appbar/appbar.dart';
import '../../common/widget/task_tile/calender_task_tile.dart';
import '../../core/l10n/l10n.dart';
import '../../core/locator/locator.dart';
import '../../data/services/date_formetter_service.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/image_strings.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return BlocProvider.value(
      value: getIt<HomeBloc>(),
      child: Scaffold(
        appBar: ViAppBar(
          showBackArrow: true,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.tasksearch_title),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: ViSizes.defaultSpace / 2),
          child: Column(
            children: [
              ViContainer(
                margin:
                    const EdgeInsets.symmetric(vertical: ViSizes.defaultSpace),
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
                    hintText: AppLocalizations.of(context)!.search_title,
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
                      return Stack(
                        children: [
                          ViEmptyScreen(
                              size:
                                  ViDeviceUtils.getScreenHeigth(context) * 0.15,
                              color: AppColors.darkerGrey,
                              title:
                                  AppLocalizations.of(context)!.no_seach_found,
                              subTitle: AppLocalizations.of(context)!
                                  .no_search_subTitle,
                              image: ViImages.empty_screen_no_result),
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(ViSizes.defaultSpace),
                              child: AdMobBanner(),
                            ),
                          )
                        ],
                      );
                    } else {
                      return ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          var task = state.searchResults[index];

                          return CalenderTaskTile(
                            title: task.title,
                            dateText: task.formattedTaskTime(
                                DateFormatterService(context)),
                            timerText: task
                                .formattedDate(DateFormatterService(context)),
                            task: task,
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
