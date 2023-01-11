import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/menu_item_bloc/menu_item_bloc.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';

import '../../../data/models/menu_item.dart' as mi;
import '../../../buisness_logic/menu_bloc/menu_bloc_bloc.dart';
import '../../../data/repositories/menu/menu.dart';
import '../../config/colors/colors.dart';
import '../general/action_button.dart';
import 'widgets/app_bar.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final allItemsBloc = context.read<MenuBloc>();
    return Scaffold(
      // appBar: const MAppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
              ),
              Row(
                children: <Widget>[
                  ActionButton(
                    icon: const Icon(
                      FlutterRemix.add_line,
                      size: 18,
                    ),
                    height: 30,
                    onPressed: () {
                      menuItemDialog(
                        item: mi.MenuItem.empty(),
                        context: context,
                        onSuccessGlobalBloc: () {
                          allItemsBloc.add(MenuItemsRequested());
                        },
                        operation: MenuItemOperation.add,
                      );
                    },
                    text: "Add",
                  ),
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              BlocBuilder<MenuBloc, MenuBlocState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (state.menuItems != null) {
                    return Column(
                      children: List.generate(
                        state.menuItems!.length,
                        (index) {
                          final current = state.menuItems![index];
                          return GestureDetector(
                              onTap: () {
                                menuItemDialog(
                                  item: current,
                                  context: context,
                                  onSuccessGlobalBloc: () {
                                    allItemsBloc.add(MenuItemsRequested());
                                  },
                                  operation: MenuItemOperation.update,
                                );
                              },
                              child: Text(current.title));
                        },
                      ),
                    );
                  } else {
                    return const Text("no data");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum MenuItemOperation { update, add }

Future menuItemDialog({
  required BuildContext context,
  required void Function() onSuccessGlobalBloc,
  required MenuItemOperation operation,
  required mi.MenuItem item,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return BlocProvider<MenuItemBloc>(
        create: (context) => MenuItemBloc(
          item: item,
          menuRepository: MenuRepository(),
        ),
        child: Builder(builder: (context) {
          final itemBloc = context.read<MenuItemBloc>();

          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              if (operation == MenuItemOperation.update)
                TextButton(
                  onPressed: () {
                    print(item.title);
                    print(item.id);

                    itemBloc.add(
                      MenuItemDeleted(
                        itemId: item.id,
                        onSuccess: () {
                          onSuccessGlobalBloc();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Deleted"),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        onError: (er) {},
                      ),
                    );
                  },
                  child: Text("delete"),
                ),
              TextButton(
                onPressed: () {
                  itemBloc.add(
                    operation == MenuItemOperation.add
                        ? MenuItemAdded(
                            onSuccess: () {
                              onSuccessGlobalBloc();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added"),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            onError: (er) {},
                          )
                        : MenuItemUpdated(
                            itemId: item.id,
                            onSuccess: () {
                              onSuccessGlobalBloc();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("updated"),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            onError: (er) {},
                          ),
                  );
                },
                child: Text("ok"),
              ),
            ],
            title: const Text("Add"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DataField(
                    hint: "title",
                    controller: itemBloc.titleController,
                  ),
                  DataField(
                    hint: "icon",
                    controller: itemBloc.iconController,
                  ),
                  DataField(
                    hint: "link",
                    controller: itemBloc.linkController,
                  ),
                ],
              ),
            ),
          );
        }),
      );
    },
  );
}
