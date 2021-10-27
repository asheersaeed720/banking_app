class DiscountModel {
  final String restaurantName;
  final String discount;
  final String cardType;

  DiscountModel({
    this.restaurantName = '',
    this.discount = '',
    this.cardType = '',
  });

  DiscountModel.fromJson(Map<String, Object?> json)
      : this(
          restaurantName: json['restaurant_name']! as String,
          discount: json['discount']! as String,
          cardType: json['card_type']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'restaurant_name': restaurantName,
      'discount': discount,
      'card_type': cardType,
    };
  }
}
