import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacine_tv/config/general.dart';
import 'package:yacine_tv/logic/settings_cubit/settings_cubit.dart';

import '../../../../logic/drawer_cubit/drawer_cubit_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: BlocBuilder<DrawerCubit, DrawerState>(
        builder: (context, state) {
          if (state is DrawerStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DrawerStateLoaded) {
            final drawerItems = state.drawerItems!;

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 22.5 + MediaQuery.of(context).padding.top,
                      bottom: 22.5,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: context
                          .read<SettingsCubit>()
                          .state
                          .settings!
                          .appLogoCover,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          Configs.menuImageCoverToShowWhenOriginalOneFails,
                          width: 175,
                          height: 75,
                        );
                      },
                      width: 175,
                      height: 75,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                    thickness: 1,
                  ),
                  // ignore: avoid-shrink-wrap-in-lists
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: drawerItems.length,
                    itemBuilder: (context, index) {
                      final item = drawerItems[index];
                      const iconWidth = 30.0;

                      return ListTile(
                        minLeadingWidth: iconWidth,
                        leading: CachedNetworkImage(
                          imageUrl: item.icon,
                          width: iconWidth,
                          height: iconWidth,
                          fadeInDuration: const Duration(milliseconds: 100),
                        ),
                        title: AutoSizeText(
                          item.title,
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        onTap: () {
                          context.read<DrawerCubit>().openLink(
                            item.link,
                            onError: (error) {
                              print("${item.link}, $error");
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            String error = state.error!;
            return Text(error);
          }
        },
      ),
    );
  }
}
