import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yacine_tv/logic/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:yacine_tv/presentation/config/colors.dart';

import '../../../../logic/settings_cubit/settings_cubit.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationCubit bloc = context.read<BottomNavigationCubit>();
    final settingsCubit = context.read<SettingsCubit>();

    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (BuildContext context, int state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: MainColors.white,
              unselectedItemColor: MainColors.white.withOpacity(0.65),
              iconSize: 27.5,
              selectedFontSize: 11.5,
              unselectedFontSize: 11,
              type: BottomNavigationBarType.fixed,
              onTap: (itemIndex) {
                bloc.selectScreenAt(itemIndex);
              },
              currentIndex: state,
              items: bloc.items.map(
                (item) {
                  return BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Icon(item.icon),
                    ),
                    label: item.name,
                  );
                },
              ).toList(),
            ),
            BlocSelector<SettingsCubit, SettingsState, bool>(
              selector: (state) => state.adLoaded,
              builder: (context, adLoaded) {
                if (adLoaded) {
                  return SafeArea(
                    child: SizedBox(
                      width: settingsCubit.bannerAd!.size.width.toDouble(),
                      height: settingsCubit.bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: settingsCubit.bannerAd!),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
