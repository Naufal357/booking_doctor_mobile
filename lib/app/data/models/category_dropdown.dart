import 'package:pesandokter/app/data/models/category_model.dart';

class CategoryDropdown {
  CategoryModel? category;
  String? id;

  CategoryDropdown({this.id, this.category});

  CategoryDropdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}
