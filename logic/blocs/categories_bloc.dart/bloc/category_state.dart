part of 'category_bloc.dart';

class CategoryState {
  List<Category> revenueCategories;
  List<Category> expensesCategories;

  CategoryState(this.revenueCategories, this.expensesCategories);

  CategoryState copyWith(
      {List<Category>? revenueCategories, List<Category>? expensesCategories}) {
    return CategoryState(
      revenueCategories ?? this.revenueCategories,
      expensesCategories ?? this.expensesCategories,
    );
  }
}

class CategoryInitial extends CategoryState {
  CategoryInitial() : super([], []);
}
