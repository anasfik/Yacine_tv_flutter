import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:web_panel/buisness_logic/menu_item_bloc/menu_item_bloc.dart';
import 'package:web_panel/data/providers/l10n/en.dart';
import 'package:web_panel/presentation/screens/general/data_field.dart';
import 'package:web_panel/presentation/screens/general/margined_body.dart';
import 'package:web_panel/presentation/screens/general/screen_title.dart';
import '../../../data/models/menu_item.dart' as mi;
import '../../../buisness_logic/menu_bloc/menu_bloc_bloc.dart';
import '../../../data/repositories/menu/menu.dart';
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
      body: SingleChildScrollView(
        child: MarginedBodyForInputs(
          child: Column(
            children: <Widget>[
              ScreenTitle(
                title: title,
                addButtonText: L10n.newMenuItem,
                onAddButtonPressed: () {
                  menuItemDialog(
                    item: mi.MenuItem.empty(),
                    context: context,
                    onSuccessGlobalBloc: () {
                      allItemsBloc.add(MenuItemsRequested());
                    },
                    operation: MenuItemOperation.add,
                  );
                },
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

                              return Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Material(
                                  borderRadius: BorderRadius.circular(5),
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    mouseCursor: SystemMouseCursors.click,
                                    onHover: (a) {},
                                    onTap: () {
                                      menuItemDialog(
                                        item: current,
                                        context: context,
                                        onSuccessGlobalBloc: () {
                                          allItemsBloc
                                              .add(MenuItemsRequested());
                                        },
                                        operation: MenuItemOperation.update,
                                      );
                                    },
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      leading: Image.network(
                                        current.icon,
                                        width: 50,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            FlutterRemix.error_warning_fill,
                                          );
                                        },
                                      ),
                                      title: Text(current.title),
                                      trailing: Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                FlutterRemix.edit_2_line,
                                              ),
                                              onPressed: () {
                                                menuItemDialog(
                                                  item: current,
                                                  context: context,
                                                  onSuccessGlobalBloc: () {
                                                    allItemsBloc.add(
                                                        MenuItemsRequested());
                                                  },
                                                  operation:
                                                      MenuItemOperation.update,
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                FlutterRemix.delete_bin_2_line,
                                              ),
                                              onPressed: () {
                                                menuItemDialog(
                                                  item: current,
                                                  context: context,
                                                  onSuccessGlobalBloc: () {
                                                    allItemsBloc.add(
                                                        MenuItemsRequested());
                                                  },
                                                  operation:
                                                      MenuItemOperation.update,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
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
        ),
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
                child: const Text(L10n.cancel),
              ),
              if (operation == MenuItemOperation.update)
                TextButton(
                  onPressed: () {
                    itemBloc.add(
                      MenuItemDeleted(
                        itemId: item.id,
                        onSuccess: () {
                          onSuccessGlobalBloc();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(L10n.menuItemAddedError),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        onError: (er) {},
                      ),
                    );
                  },
                  child: const Text(L10n.delete),
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
                                  content: Text(L10n.menuItemAddedSuccess),
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
                                  content: Text(L10n.menuItemUpdatedSuccess),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            onError: (er) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(L10n.menuItemUpdatedError),
                                ),
                              );
                            },
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
