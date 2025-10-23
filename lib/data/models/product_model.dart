import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final String? thumbnail;
  final String handle;
  final String? metaTitle;
  final String? metaDescription;
  final String status;
  final String? brandId;
  final String visibility;
  final int reviewsCount;
  final double? averageRating;
  final int ordersCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final List<ProductImage> productImages;
  final List<ProductVariant> variants;
  final List<ProductCategory> productCategories;
  final List<dynamic> productCollections;
  final List<ProductTag> tags;
  final double? priceStart;
  final double? priceEnd;
  final Map<String, dynamic>? metadata;

  // Additional fields from different endpoints
  final String? weight;
  final String? height;
  final String? width;
  final String? length;
  @JsonKey(name: 'hs_code')
  final String? hsCode;
  @JsonKey(name: 'origin_country')
  final String? originCountry;
  @JsonKey(name: 'mid_code')
  final String? midCode;
  final String? material;
  final String? createdById;
  final String? productAttributeGroupId;
  final String? deletedAt;

  // For product detail endpoint
  final ProductBrand? brand;
  final List<ProductTab>? tabs;
  final List<ProductOption>? options;
  final Map<String, dynamic>? productAttributeGroup;
  final List<ProductAttributeValue>? productValuesForAttribute;
  @JsonKey(name: '_count')
  final Map<String, dynamic>? count;
  final List<dynamic>? breadCrumbs;
  final List<dynamic>? reviews;
  final List<dynamic>? prices;

  Product({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.thumbnail,
    required this.handle,
    this.metaTitle,
    this.metaDescription,
    required this.status,
    this.brandId,
    required this.visibility,
    required this.reviewsCount,
    this.averageRating,
    required this.ordersCount,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt,
    required this.productImages,
    required this.variants,
    required this.productCategories,
    required this.productCollections,
    required this.tags,
    this.priceStart,
    this.priceEnd,
    this.metadata,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.hsCode,
    this.originCountry,
    this.midCode,
    this.material,
    this.createdById,
    this.productAttributeGroupId,
    this.deletedAt,
    this.brand,
    this.tabs,
    this.options,
    this.productAttributeGroup,
    this.productValuesForAttribute,
    this.count,
    this.breadCrumbs,
    this.reviews,
    this.prices,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Computed properties
  double get effectivePrice => priceStart ?? 0.0;

  double? get discountPrice {
    if (variants.isEmpty) return null;
    final firstVariant = variants.first;
    if (firstVariant.specialPrice != null) {
      return firstVariant.specialPrice!.toDouble();
    }
    return null;
  }

  int get discountPercentage {
    if (variants.isEmpty || variants.first.specialPrice == null) return 0;
    final original = variants.first.originalPrice.toDouble();
    final special = variants.first.specialPrice!.toDouble();
    if (original <= special) return 0;
    return ((original - special) / original * 100).round();
  }

  bool get hasDiscount {
    return variants.isNotEmpty && variants.first.specialPrice != null;
  }

  bool get isAvailable {
    return status == 'ACTIVE' &&
        variants.isNotEmpty &&
        variants.any(
          (v) =>
              v.inventoryQuantity > 0 ||
              (v.allowBackOrder ?? false) ||
              !(v.manageInventory ?? false),
        );
  }

  int get stock {
    if (variants.isEmpty) return 0;
    return variants.fold(0, (sum, v) => sum + v.inventoryQuantity);
  }

  List<String> get images {
    return productImages.map((e) => e.image).toList();
  }

  List<String>? get sizes {
    if (variants.isEmpty) return null;
    final sizeOptions = <String>{};
    for (var variant in variants) {
      for (var optionValue in variant.optionValues ?? []) {
        if (optionValue.productOption?.title.toLowerCase().contains('size') ??
            false) {
          sizeOptions.add(optionValue.value);
        }
      }
    }
    return sizeOptions.isEmpty ? null : sizeOptions.toList();
  }

  List<String>? get colors {
    if (variants.isEmpty) return null;
    final colorOptions = <String>{};
    for (var variant in variants) {
      for (var optionValue in variant.optionValues ?? []) {
        final title = optionValue.productOption?.title.toLowerCase();
        if (title != null &&
            (title.contains('color') || title.contains('colour'))) {
          colorOptions.add(optionValue.value);
        }
      }
    }
    return colorOptions.isEmpty ? null : colorOptions.toList();
  }

  String get name => title;
  String get categoryName =>
      productCategories.isNotEmpty ? productCategories.first.category.name : '';
  double get rating => averageRating ?? 0.0;
  int get reviewCount => reviewsCount;
  Map<String, dynamic>? get specifications => metadata;
}

@JsonSerializable(explicitToJson: true)
class ProductImage {
  final String id;
  final String? productId;
  final int? order;
  final String image;
  final String? productVariantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductImage({
    required this.id,
    this.productId,
    required this.order,
    required this.image,
    this.productVariantId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductVariant {
  final String id;
  final String? productId;
  final String? sku;
  final String? barcode;
  final num price;
  final num? specialPrice;
  final DateTime? specialPriceStartDate;
  final DateTime? specialPriceEndDate;
  final String? title;
  final String? thumbnail;
  final int inventoryQuantity;
  final bool? manageInventory;
  final bool? allowBackOrder;
  final int? variantRank;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<VariantImage>? images;
  final List<OptionValue>? optionValues;
  final num originalPrice;
  final num currentPrice;
  final List<dynamic>? prices;
  final Map<String, dynamic>? metadata;
  final String? deletedAt;
  final String? createdById;
  final String? ean;
  final String? height;
  final String? hsCode;
  final String? length;
  final String? material;
  final String? midCode;
  final String? originCountry;
  final String? upc;
  final String? weight;
  final String? width;
  final String? gtin;
  final String? easyecomId;
  final String? easyecomSku;
  final Map<String, dynamic>? salePrices;
  final num? specialPriceActive;

  ProductVariant({
    required this.id,
    required this.productId,
    this.sku,
    this.barcode,
    required this.price,
    this.specialPrice,
    this.specialPriceStartDate,
    this.specialPriceEndDate,
    this.title,
    this.thumbnail,
    required this.inventoryQuantity,
    required this.manageInventory,
    required this.allowBackOrder,
    required this.variantRank,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.optionValues,
    required this.originalPrice,
    required this.currentPrice,
    this.prices,
    this.metadata,
    this.deletedAt,
    this.createdById,
    this.ean,
    this.height,
    this.hsCode,
    this.length,
    this.material,
    this.midCode,
    this.originCountry,
    this.upc,
    this.weight,
    this.width,
    this.gtin,
    this.easyecomId,
    this.easyecomSku,
    this.salePrices,
    this.specialPriceActive,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);

  bool get availableForSale =>
      inventoryQuantity > 0 ||
      (allowBackOrder ?? false) ||
      !(manageInventory ?? false);
}

@JsonSerializable()
class VariantImage {
  final String id;
  final String? productId;
  final int order;
  final String image;
  final String? productVariantId;
  final DateTime createdAt;
  final DateTime updatedAt;

  VariantImage({
    required this.id,
    this.productId,
    required this.order,
    required this.image,
    this.productVariantId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VariantImage.fromJson(Map<String, dynamic> json) =>
      _$VariantImageFromJson(json);

  Map<String, dynamic> toJson() => _$VariantImageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OptionValue {
  final String id;
  final String optionId;
  final String value;
  final String? variantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final String? createdById;
  final Map<String, dynamic>? metadata;
  final ProductOption? productOption;

  OptionValue({
    required this.id,
    required this.optionId,
    required this.value,
    this.variantId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.createdById,
    this.metadata,
    this.productOption,
  });

  factory OptionValue.fromJson(Map<String, dynamic> json) =>
      _$OptionValueFromJson(json);

  Map<String, dynamic> toJson() => _$OptionValueToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductOption {
  final String id;
  final String productId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final String? createdById;
  final Map<String, dynamic>? metadata;
  final List<OptionValue>? values;

  ProductOption({
    required this.id,
    required this.productId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.createdById,
    this.metadata,
    this.values,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductCategory {
  final Category category;

  ProductCategory({required this.category});

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Category {
  final String id;
  final String name;
  final String handle;
  final Category? parent;

  Category({
    required this.id,
    required this.name,
    required this.handle,
    this.parent,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class ProductBrand {
  final String id;
  final String title;
  final String? description;
  final String handle;
  final String? image;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final Map<String, dynamic>? metadata;
  final String? createdById;

  ProductBrand({
    required this.id,
    required this.title,
    this.description,
    required this.handle,
    this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.createdById,
  });

  factory ProductBrand.fromJson(Map<String, dynamic> json) =>
      _$ProductBrandFromJson(json);

  Map<String, dynamic> toJson() => _$ProductBrandToJson(this);
}

@JsonSerializable()
class ProductTab {
  final String id;
  final String productId;
  final String title;
  final String content;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final Map<String, dynamic>? metadata;

  ProductTab({
    required this.id,
    required this.productId,
    required this.title,
    required this.content,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory ProductTab.fromJson(Map<String, dynamic> json) =>
      _$ProductTabFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTabToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductTag {
  final String? id;
  final String? productId;
  final String? tagId;
  final Tag tag;

  ProductTag({
    required this.id,
    required this.productId,
    required this.tagId,
    required this.tag,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) =>
      _$ProductTagFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTagToJson(this);
}

@JsonSerializable()
class Tag {
  final String id;
  final String title;
  final String slug;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? createdById;

  Tag({
    required this.id,
    required this.title,
    required this.slug,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.createdById,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductAttributeValue {
  final String? value;
  final ProductAttribute productAttribute;
  final AttributeValue productAttributeValue;

  ProductAttributeValue({
    this.value,
    required this.productAttribute,
    required this.productAttributeValue,
  });

  factory ProductAttributeValue.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeValueFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeValueToJson(this);
}

@JsonSerializable()
class ProductAttribute {
  final String code;
  final String title;

  ProductAttribute({required this.code, required this.title});

  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeToJson(this);
}

@JsonSerializable()
class AttributeValue {
  final String value;

  AttributeValue({required this.value});

  factory AttributeValue.fromJson(Map<String, dynamic> json) =>
      _$AttributeValueFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeValueToJson(this);
}
