part of 'category_bloc.dart';

sealed class CategoryEvent {}

class GetCategories extends CategoryEvent {}

class InitializeDefaultCategories extends CategoryEvent{}

class AddCategory extends CategoryEvent {
  final String table;
  final String category;

  AddCategory({required this.table, required this.category});
}

class DeleteCategory extends CategoryEvent {
  final String table;
  final int id;
  DeleteCategory({required this.table, required this.id});
}

class UpdateCategory extends CategoryEvent {
  final String table;
  final int id;
  final String name;

  UpdateCategory({required this.table, required this.id, required this.name});
}
