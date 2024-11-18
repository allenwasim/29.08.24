import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
      );

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      // Map JSON Record to the Model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}

class DummyData {
  /// Banners
  // static final List<BannerModel> banners = [
  //   BannerModel(imageURL: TImages.banner1, targetScreen: TRoutes.order, active: false),
  //   BannerModel(imageURL: TImages.banner2, targetScreen: TRoutes.cart, active: true),
  //   BannerModel(imageURL: TImages.banner3, targetScreen: TRoutes.favourites, active: true),
  //   BannerModel(imageURL: TImages.banner4, targetScreen: TRoutes.search, active: true),
  //   BannerModel(imageURL: TImages.banner5, targetScreen: TRoutes.settings, active: true),
  //   BannerModel(imageURL: TImages.banner6, targetScreen: TRoutes.userAddress, active: true),
  //   BannerModel(imageURL: TImages.banner8, targetScreen: TRoutes.checkout, active: false),
  // ];

  /// Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: TImages.shoeIcon, name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '2',
        image: TImages.furnitureIcon,
        name: 'Furniture',
        isFeatured: true),
    CategoryModel(
        id: '3',
        image: TImages.electronicsIcon,
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '4', image: TImages.clothIcon, name: 'Clothes', isFeatured: true),
    CategoryModel(
        id: '5', image: TImages.animalIcon, name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '6', image: TImages.toyIcon, name: 'Toys', isFeatured: true),
    CategoryModel(
        id: '7', image: TImages.shoeIcon, name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '8',
        image: TImages.cosmeticsIcon,
        name: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '9',
        image: TImages.jeweleryIcon,
        name: 'Jewelry',
        isFeatured: true),
  ];

  /// Subcategories
  static final List<CategoryModel> subcategories = [
    CategoryModel(
        id: '10',
        image: TImages.sportIcon,
        name: 'Track suits',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '11',
        image: TImages.sportIcon,
        name: 'Sports Equipment',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '12',
        image: TImages.furnitureIcon,
        name: 'Sofas',
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '13',
        image: TImages.furnitureIcon,
        name: 'Beds',
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '14',
        image: TImages.electronicsIcon,
        name: 'Smartphones',
        parentId: '3',
        isFeatured: false),
  ];
}
