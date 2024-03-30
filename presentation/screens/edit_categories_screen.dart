import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/category.dart';
import 'package:mymib/logic/blocs/categories_bloc.dart/bloc/category_bloc.dart';
import 'package:mymib/presentation/widgets/fancy_rounded_button.dart';
import 'package:mymib/presentation/widgets/row_text_field.dart';

class EditCategoriesScreen extends StatefulWidget {
  final bool fromRevenues;
  const EditCategoriesScreen({super.key, required this.fromRevenues});

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  late TextEditingController categoryController;
  @override
  void initState() {
    categoryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editer les categories"),
        centerTitle: true,
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          var listToShow = widget.fromRevenues
              ? state.revenueCategories
              : state.expensesCategories;
          return SizedBox(
            height: size.height * 0.8,
            width: size.width,
            child: listToShow.isEmpty
                ? const Center(
                    child: Text("Cette catégorie est vide"),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final category = listToShow[index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        background: Container(
                          color: context.colorScheme.error,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          var delete = false;
                          if (direction == DismissDirection.endToStart) {
                            await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                  "Voulez - vous supprimer cette catégorie?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Non",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                              // color: context.colorScheme.error,

                                              ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      delete = true;
                                      context.read<CategoryBloc>().add(
                                            DeleteCategory(
                                              table: widget.fromRevenues
                                                  ? 'revenuecategories'
                                                  : 'expensecategories',
                                              id: category.id!,
                                            ),
                                          );
                                      // setState(() {});
                                      context
                                          .read<CategoryBloc>()
                                          .add(GetCategories());
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Oui",
                                      style:
                                          context.textTheme.bodyLarge?.copyWith(
                                        color: context.colorScheme.error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return delete;
                        },
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              categoryController.text = category.category;
                              addEditCategory(context, size, categoryController,
                                  true, category);
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 22,
                              color: context.colorScheme.outline,
                            ),
                          ),
                          title: Text(category.category),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                      );
                    },
                    itemCount: listToShow.length,
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          addEditCategory(
            context,
            size,
            categoryController,
            false,
            null,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<Object?> addEditCategory(BuildContext context, Size size,
      TextEditingController controller, bool edit, Category? category) {
    return showGeneralDialog(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween;
        tween = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
      barrierDismissible: true,
      barrierLabel: 'add or edit',
      context: context,
      pageBuilder: (context, _, __) {
        return Center(
          child: Container(
            height: size.height * 0.5,
            width: size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: context.colorScheme.background,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Center(
                child: SizedBox(
                  width: size.width * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RowTextField(
                        controller: categoryController,
                        text: 'Category',
                        hint: 'category',
                      ),
                      FancyRoundedButton(
                        onTap: () {
                          if (controller.text.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Categorie est vide'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            edit
                                ? context.read<CategoryBloc>().add(
                                      UpdateCategory(
                                        table: widget.fromRevenues
                                            ? 'revenuecategories'
                                            : 'expensecategories',
                                        id: category!.id!,
                                        name: controller.text,
                                      ),
                                    )
                                : context.read<CategoryBloc>().add(
                                      AddCategory(
                                        table: widget.fromRevenues
                                            ? 'revenuecategories'
                                            : 'expensecategories',
                                        category: controller.text,
                                      ),
                                    );
                            context.read<CategoryBloc>().add(GetCategories());
                            Navigator.of(context).pop();
                            // setState(() {});
                          }
                        },
                        text: 'Enregistrer',
                        color: context.colorScheme.primary,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      controller.clear();
      return null;
    });
  }
}
