import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// TODO item category
@freezed
sealed class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required int colorIndex,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

/// Default categories
class DefaultCategories {
  static const personal = Category(
    id: 'personal',
    name: 'Personal',
    colorIndex: 0,
  );

  static const work = Category(
    id: 'work',
    name: 'Work',
    colorIndex: 1,
  );

  static const shopping = Category(
    id: 'shopping',
    name: 'Shopping',
    colorIndex: 2,
  );

  static const health = Category(
    id: 'health',
    name: 'Health',
    colorIndex: 3,
  );

  static const List<Category> all = [
    personal,
    work,
    shopping,
    health,
  ];
}
