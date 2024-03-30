import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/data/models/category.dart';
import 'package:mymib/logic/services/categories_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesService categoriesService = CategoriesService();
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategories>((event, emit) async {
      final List<Map<String, dynamic>> revResponse =
          await categoriesService.getData('SELECT * FROM revenuecategories');
      final revenuesCategories =
          revResponse.map((category) => Category.fromJson(category)).toList();

      final List<Map<String, dynamic>> expResponse =
          await categoriesService.getData('SELECT * FROM expensecategories');
      final expensesCategories =
          expResponse.map((category) => Category.fromJson(category)).toList();
      log(revenuesCategories.toString());
      log(expensesCategories.toString());
      emit(state.copyWith(
          revenueCategories: revenuesCategories,
          expensesCategories: expensesCategories));
    });

    on<InitializeDefaultCategories>(
      (event, emit) async {
        List<Category> defaultRevenues = [
          Category(category: 'Freelance'),
          Category(category: 'Salaire'),
          Category(category: 'Autre'),
        ];
        List<Category> defaultExpenses = [
          Category(category: 'Transport'),
          Category(category: 'Santé'),
          Category(category: 'Autre'),
        ];
        for (var category in defaultRevenues) {
          await categoriesService.insertAutoData(
            'revenuecategories',
            category.toJson(),
          );
        }
        for (var category in defaultExpenses) {
          await categoriesService.insertAutoData(
            'expensecategories',
            category.toJson(),
          );
        }
      },
    );

    on<AddCategory>(
      (event, emit) async {
        final newCategory = Category(category: event.category);
        await categoriesService.insertAutoData(
            event.table, newCategory.toJson());
        add(GetCategories());
      },
    );
    on<UpdateCategory>(
      (event, emit) async {
        await categoriesService.updateDataAuto(
          event.table,
          {
            'category': event.name,
          },
          event.id,
        );
        add(GetCategories());
      },
    );
    on<DeleteCategory>(
      (event, emit) async {
        await categoriesService.deleteDataAuto(event.table, event.id);
        add(GetCategories());
      },
    );
  }
}
