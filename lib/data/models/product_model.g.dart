// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  thumbnail: json['thumbnail'] as String?,
  handle: json['handle'] as String,
  metaTitle: json['metaTitle'] as String?,
  metaDescription: json['metaDescription'] as String?,
  status: json['status'] as String,
  brandId: json['brandId'] as String?,
  visibility: json['visibility'] as String,
  reviewsCount: (json['reviewsCount'] as num).toInt(),
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  ordersCount: (json['ordersCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  publishedAt: json['publishedAt'] == null
      ? null
      : DateTime.parse(json['publishedAt'] as String),
  productImages: (json['productImages'] as List<dynamic>)
      .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
      .toList(),
  variants: (json['variants'] as List<dynamic>)
      .map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
      .toList(),
  productCategories: (json['productCategories'] as List<dynamic>)
      .map((e) => ProductCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
  productCollections: json['productCollections'] as List<dynamic>,
  tags: (json['tags'] as List<dynamic>)
      .map((e) => ProductTag.fromJson(e as Map<String, dynamic>))
      .toList(),
  priceStart: (json['priceStart'] as num?)?.toDouble(),
  priceEnd: (json['priceEnd'] as num?)?.toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
  weight: json['weight'] as String?,
  height: json['height'] as String?,
  width: json['width'] as String?,
  length: json['length'] as String?,
  hsCode: json['hs_code'] as String?,
  originCountry: json['origin_country'] as String?,
  midCode: json['mid_code'] as String?,
  material: json['material'] as String?,
  createdById: json['createdById'] as String?,
  productAttributeGroupId: json['productAttributeGroupId'] as String?,
  deletedAt: json['deletedAt'] as String?,
  brand: json['brand'] == null
      ? null
      : ProductBrand.fromJson(json['brand'] as Map<String, dynamic>),
  tabs: (json['tabs'] as List<dynamic>?)
      ?.map((e) => ProductTab.fromJson(e as Map<String, dynamic>))
      .toList(),
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => ProductOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  productAttributeGroup: json['productAttributeGroup'] as Map<String, dynamic>?,
  productValuesForAttribute:
      (json['productValuesForAttribute'] as List<dynamic>?)
          ?.map(
            (e) => ProductAttributeValue.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  count: json['_count'] as Map<String, dynamic>?,
  breadCrumbs: json['breadCrumbs'] as List<dynamic>?,
  reviews: json['reviews'] as List<dynamic>?,
  prices: json['prices'] as List<dynamic>?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'description': instance.description,
  'thumbnail': instance.thumbnail,
  'handle': instance.handle,
  'metaTitle': instance.metaTitle,
  'metaDescription': instance.metaDescription,
  'status': instance.status,
  'brandId': instance.brandId,
  'visibility': instance.visibility,
  'reviewsCount': instance.reviewsCount,
  'averageRating': instance.averageRating,
  'ordersCount': instance.ordersCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'productImages': instance.productImages.map((e) => e.toJson()).toList(),
  'variants': instance.variants.map((e) => e.toJson()).toList(),
  'productCategories': instance.productCategories
      .map((e) => e.toJson())
      .toList(),
  'productCollections': instance.productCollections,
  'tags': instance.tags.map((e) => e.toJson()).toList(),
  'priceStart': instance.priceStart,
  'priceEnd': instance.priceEnd,
  'metadata': instance.metadata,
  'weight': instance.weight,
  'height': instance.height,
  'width': instance.width,
  'length': instance.length,
  'hs_code': instance.hsCode,
  'origin_country': instance.originCountry,
  'mid_code': instance.midCode,
  'material': instance.material,
  'createdById': instance.createdById,
  'productAttributeGroupId': instance.productAttributeGroupId,
  'deletedAt': instance.deletedAt,
  'brand': instance.brand?.toJson(),
  'tabs': instance.tabs?.map((e) => e.toJson()).toList(),
  'options': instance.options?.map((e) => e.toJson()).toList(),
  'productAttributeGroup': instance.productAttributeGroup,
  'productValuesForAttribute': instance.productValuesForAttribute
      ?.map((e) => e.toJson())
      .toList(),
  '_count': instance.count,
  'breadCrumbs': instance.breadCrumbs,
  'reviews': instance.reviews,
  'prices': instance.prices,
};

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
  id: json['id'] as String,
  productId: json['productId'] as String?,
  order: (json['order'] as num?)?.toInt(),
  image: json['image'] as String,
  productVariantId: json['productVariantId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'order': instance.order,
      'image': instance.image,
      'productVariantId': instance.productVariantId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    ProductVariant(
      id: json['id'] as String,
      productId: json['productId'] as String?,
      sku: json['sku'] as String?,
      barcode: json['barcode'] as String?,
      price: json['price'] as num,
      specialPrice: json['specialPrice'] as num?,
      specialPriceStartDate: json['specialPriceStartDate'] == null
          ? null
          : DateTime.parse(json['specialPriceStartDate'] as String),
      specialPriceEndDate: json['specialPriceEndDate'] == null
          ? null
          : DateTime.parse(json['specialPriceEndDate'] as String),
      title: json['title'] as String?,
      thumbnail: json['thumbnail'] as String?,
      inventoryQuantity: (json['inventoryQuantity'] as num).toInt(),
      manageInventory: json['manageInventory'] as bool?,
      allowBackOrder: json['allowBackOrder'] as bool?,
      variantRank: (json['variantRank'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => VariantImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      optionValues: (json['optionValues'] as List<dynamic>?)
          ?.map((e) => OptionValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalPrice: json['originalPrice'] as num,
      currentPrice: json['currentPrice'] as num,
      prices: json['prices'] as List<dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      deletedAt: json['deletedAt'] as String?,
      createdById: json['createdById'] as String?,
      ean: json['ean'] as String?,
      height: json['height'] as String?,
      hsCode: json['hsCode'] as String?,
      length: json['length'] as String?,
      material: json['material'] as String?,
      midCode: json['midCode'] as String?,
      originCountry: json['originCountry'] as String?,
      upc: json['upc'] as String?,
      weight: json['weight'] as String?,
      width: json['width'] as String?,
      gtin: json['gtin'] as String?,
      easyecomId: json['easyecomId'] as String?,
      easyecomSku: json['easyecomSku'] as String?,
      salePrices: json['salePrices'] as Map<String, dynamic>?,
      specialPriceActive: json['specialPriceActive'] as num?,
    );

Map<String, dynamic> _$ProductVariantToJson(
  ProductVariant instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'sku': instance.sku,
  'barcode': instance.barcode,
  'price': instance.price,
  'specialPrice': instance.specialPrice,
  'specialPriceStartDate': instance.specialPriceStartDate?.toIso8601String(),
  'specialPriceEndDate': instance.specialPriceEndDate?.toIso8601String(),
  'title': instance.title,
  'thumbnail': instance.thumbnail,
  'inventoryQuantity': instance.inventoryQuantity,
  'manageInventory': instance.manageInventory,
  'allowBackOrder': instance.allowBackOrder,
  'variantRank': instance.variantRank,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'images': instance.images?.map((e) => e.toJson()).toList(),
  'optionValues': instance.optionValues?.map((e) => e.toJson()).toList(),
  'originalPrice': instance.originalPrice,
  'currentPrice': instance.currentPrice,
  'prices': instance.prices,
  'metadata': instance.metadata,
  'deletedAt': instance.deletedAt,
  'createdById': instance.createdById,
  'ean': instance.ean,
  'height': instance.height,
  'hsCode': instance.hsCode,
  'length': instance.length,
  'material': instance.material,
  'midCode': instance.midCode,
  'originCountry': instance.originCountry,
  'upc': instance.upc,
  'weight': instance.weight,
  'width': instance.width,
  'gtin': instance.gtin,
  'easyecomId': instance.easyecomId,
  'easyecomSku': instance.easyecomSku,
  'salePrices': instance.salePrices,
  'specialPriceActive': instance.specialPriceActive,
};

VariantImage _$VariantImageFromJson(Map<String, dynamic> json) => VariantImage(
  id: json['id'] as String,
  productId: json['productId'] as String?,
  order: (json['order'] as num).toInt(),
  image: json['image'] as String,
  productVariantId: json['productVariantId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$VariantImageToJson(VariantImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'order': instance.order,
      'image': instance.image,
      'productVariantId': instance.productVariantId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

OptionValue _$OptionValueFromJson(Map<String, dynamic> json) => OptionValue(
  id: json['id'] as String,
  optionId: json['optionId'] as String,
  value: json['value'] as String,
  variantId: json['variantId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] as String?,
  createdById: json['createdById'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  productOption: json['productOption'] == null
      ? null
      : ProductOption.fromJson(json['productOption'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OptionValueToJson(OptionValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'optionId': instance.optionId,
      'value': instance.value,
      'variantId': instance.variantId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'createdById': instance.createdById,
      'metadata': instance.metadata,
      'productOption': instance.productOption?.toJson(),
    };

ProductOption _$ProductOptionFromJson(Map<String, dynamic> json) =>
    ProductOption(
      id: json['id'] as String,
      productId: json['productId'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] as String?,
      createdById: json['createdById'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => OptionValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductOptionToJson(ProductOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'createdById': instance.createdById,
      'metadata': instance.metadata,
      'values': instance.values?.map((e) => e.toJson()).toList(),
    };

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{'category': instance.category.toJson()};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  handle: json['handle'] as String,
  parent: json['parent'] == null
      ? null
      : Category.fromJson(json['parent'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'handle': instance.handle,
  'parent': instance.parent?.toJson(),
};

ProductBrand _$ProductBrandFromJson(Map<String, dynamic> json) => ProductBrand(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  handle: json['handle'] as String,
  image: json['image'] as String?,
  status: json['status'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdById: json['createdById'] as String?,
);

Map<String, dynamic> _$ProductBrandToJson(ProductBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'handle': instance.handle,
      'image': instance.image,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'metadata': instance.metadata,
      'createdById': instance.createdById,
    };

ProductTab _$ProductTabFromJson(Map<String, dynamic> json) => ProductTab(
  id: json['id'] as String,
  productId: json['productId'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  position: (json['position'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ProductTabToJson(ProductTab instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'title': instance.title,
      'content': instance.content,
      'position': instance.position,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt,
      'metadata': instance.metadata,
    };

ProductTag _$ProductTagFromJson(Map<String, dynamic> json) => ProductTag(
  id: json['id'] as String?,
  productId: json['productId'] as String?,
  tagId: json['tagId'] as String?,
  tag: Tag.fromJson(json['tag'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductTagToJson(ProductTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'tagId': instance.tagId,
      'tag': instance.tag.toJson(),
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
  id: json['id'] as String,
  title: json['title'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] as String?,
  createdById: json['createdById'] as String?,
);

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt,
  'createdById': instance.createdById,
};

ProductAttributeValue _$ProductAttributeValueFromJson(
  Map<String, dynamic> json,
) => ProductAttributeValue(
  value: json['value'] as String?,
  productAttribute: ProductAttribute.fromJson(
    json['productAttribute'] as Map<String, dynamic>,
  ),
  productAttributeValue: AttributeValue.fromJson(
    json['productAttributeValue'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ProductAttributeValueToJson(
  ProductAttributeValue instance,
) => <String, dynamic>{
  'value': instance.value,
  'productAttribute': instance.productAttribute.toJson(),
  'productAttributeValue': instance.productAttributeValue.toJson(),
};

ProductAttribute _$ProductAttributeFromJson(Map<String, dynamic> json) =>
    ProductAttribute(
      code: json['code'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProductAttributeToJson(ProductAttribute instance) =>
    <String, dynamic>{'code': instance.code, 'title': instance.title};

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) =>
    AttributeValue(value: json['value'] as String);

Map<String, dynamic> _$AttributeValueToJson(AttributeValue instance) =>
    <String, dynamic>{'value': instance.value};
