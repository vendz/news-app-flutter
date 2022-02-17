import 'package:news_app/constants.dart';
import 'package:news_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = [];
  CategoryModel categoryModel;

  //1
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "All";
  categoryModel.imageAssetUrl = kAllImage;
  categoryModel.category = 'all';
  myCategories.add(categoryModel);

  //2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imageAssetUrl = kScienceImage;
  categoryModel.category = 'science';
  myCategories.add(categoryModel);

  //3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageAssetUrl = kTechnologyImage;
  categoryModel.category = 'technology';
  myCategories.add(categoryModel);

  //4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "India";
  categoryModel.imageAssetUrl = kIndiaImage;
  categoryModel.category = 'national';
  myCategories.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Automobile";
  categoryModel.imageAssetUrl = kAutomobileImage;
  categoryModel.category = 'automobile';
  myCategories.add(categoryModel);

  //6
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageAssetUrl = kEntertainmetImage;
  categoryModel.category = 'entertainment';
  myCategories.add(categoryModel);

  //7
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageAssetUrl = kSportsImage;
  categoryModel.category = 'sports';
  myCategories.add(categoryModel);

  //8
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "World";
  categoryModel.imageAssetUrl = kWorldImage;
  categoryModel.category = 'world';
  myCategories.add(categoryModel);

  //9
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Business";
  categoryModel.imageAssetUrl = kBusinessImage;
  categoryModel.category = 'business';
  myCategories.add(categoryModel);

  //10
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Politics";
  categoryModel.imageAssetUrl = kPoliticsImage;
  categoryModel.category = 'politics';
  myCategories.add(categoryModel);

  //11
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Startup";
  categoryModel.imageAssetUrl = kStartupImage;
  categoryModel.category = 'startup';
  myCategories.add(categoryModel);

  //12
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Something Different";
  categoryModel.imageAssetUrl = kDifferentImage;
  categoryModel.category = 'hatke';
  myCategories.add(categoryModel);

  //13
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Miscellaneous";
  categoryModel.imageAssetUrl = kMiscellaneousImage;
  categoryModel.category = 'miscellaneous';
  myCategories.add(categoryModel);

  return myCategories;
}
