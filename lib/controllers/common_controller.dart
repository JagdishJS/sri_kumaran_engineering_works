import "../library.dart";

class CommonController extends GetxController {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  RxList<String> equipments = [
    "Welding Machine",
    "Drill Press",
    "Circular Saw",
    "Angle Grinder",
    "Lathe Machine",
  ].obs;

  // RxList<Order> orders = <Order>[].obs;

  RxList<Order> orders = [
    Order(
        name: "Welding Machine", quantity: 2, price: 350.0, status: "Pending"),
    Order(name: "Drill Press", quantity: 1, price: 500.0, status: "Completed"),
    Order(name: "Circular Saw", quantity: 3, price: 150.0, status: "Shipped"),
    Order(name: "Angle Grinder", quantity: 5, price: 75.0, status: "Pending"),
    Order(
        name: "Lathe Machine", quantity: 1, price: 2000.0, status: "Completed"),
  ].obs;
}

class Order {
  final String name;
  final int quantity;
  final double price;
  final String status;

  Order(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.status});
}
