class CategoryModel {
  String? categoryName;
  String? categoryImage;

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    CategoryModel categoryModel = new CategoryModel();
    categoryModel.categoryName = "Business";
    categoryModel.categoryImage = "Assets/Images/business.jpg";
    categories.add(categoryModel);

    categoryModel = new CategoryModel();
    categoryModel.categoryName = "Entertainment";
    categoryModel.categoryImage = "Assets/Images/entertainment.jpg";
    categories.add(categoryModel);

    categoryModel = new CategoryModel();
    categoryModel.categoryName = "General";
    categoryModel.categoryImage = "Assets/Images/general.jpg";
    categories.add(categoryModel);

    categoryModel = new CategoryModel();
    categoryModel.categoryName = "Health";
    categoryModel.categoryImage = "Assets/Images/health.jpg";
    categories.add(categoryModel);

    categoryModel = new CategoryModel();
    categoryModel.categoryName = "Sports";
    categoryModel.categoryImage = "Assets/Images/sports.jpg";
    categories.add(categoryModel);

    return categories;
  }
}

class ShowCategoryModel {
  final String? author;
  final String? title;
  final String? desc;
  final String? url;
  final String? imageUrl;
  final String? content;

  ShowCategoryModel(
      {required this.author,
      required this.title,
      required this.desc,
      required this.url,
      required this.imageUrl,
      required this.content});
}
