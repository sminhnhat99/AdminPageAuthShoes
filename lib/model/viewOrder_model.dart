class Order{
  List<ViewOrder> data;

  Order({this.data});

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(data: (json['data'] as List).map((i) => ViewOrder.fromJson(i)).toList());
  }
}

class ViewOrder {
  final String orderId;
  final int userId;
  final int totalPrice;
  final String orderDate;
  final String status;
  final String expireDate;

  ViewOrder({
    this.orderId,
    this.userId,
    this.totalPrice,
    this.orderDate,
    this.status,
    this.expireDate
  });

  factory ViewOrder.fromJson(Map<String, dynamic> json) {
    return ViewOrder(
      orderId: json['orderId'],
      userId: json['userId'],
      totalPrice: json['totalPrice'],
      orderDate: json['orderDate'],
      status: json['status'],
      expireDate: json['expireDate']
    );
  }
}