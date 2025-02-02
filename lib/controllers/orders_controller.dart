import "dart:io";
import "package:excel/excel.dart";
import "../library.dart";

class OrdersController extends GetxController {
  RxList<OurOrders> orders = [
    OurOrders(
        orderId: 'SKEW001',
        customername: "Karthi",
        products: [
          Products(name: 'Welding Machine', quantity: 10, salesPrice: 2000.00),
          Products(name: 'Drill Press', quantity: 15, salesPrice: 1500.00),
          Products(name: 'Circular Saw', quantity: 5, salesPrice: 3700.00)
        ],
        quantity: 30,
        price: 7200.0,
        status: "Pending"),
    OurOrders(
        orderId: 'SKEW002',
        customername: "Aadhithya",
        products: [
          Products(name: 'Welding Machine', quantity: 10, salesPrice: 2000.00),
          Products(name: 'Drill Press', quantity: 15, salesPrice: 1500.00),
          Products(name: 'Circular Saw', quantity: 5, salesPrice: 3700.00)
        ],
        quantity: 1,
        price: 500.0,
        status: "Completed"),
    OurOrders(
        orderId: 'SKEW003',
        customername: "Janan",
        products: [
          Products(name: 'Welding Machine', quantity: 10, salesPrice: 2000.00),
          Products(name: 'Angle Grinder', quantity: 15, salesPrice: 1500.00),
          Products(name: 'Circular Saw', quantity: 5, salesPrice: 3700.00)
        ],
        quantity: 3,
        price: 150.0,
        status: "Shipped"),
    OurOrders(
        orderId: 'SKEW004',
        customername: "Yukesh",
        products: [
          Products(name: 'Lathe Machine', quantity: 10, salesPrice: 2000.00),
          Products(name: 'Drill Press', quantity: 15, salesPrice: 1500.00),
          Products(name: 'Angle Grinder', quantity: 5, salesPrice: 3700.00)
        ],
        quantity: 5,
        price: 75.0,
        status: "Pending"),
    OurOrders(
        orderId: 'SKEW005',
        customername: "Mithran",
        products: [
          Products(name: 'Welding Machine', quantity: 10, salesPrice: 2000.00),
          Products(name: 'Lathe Machine', quantity: 15, salesPrice: 1500.00),
          Products(name: 'CAngle Grinder', quantity: 5, salesPrice: 3700.00)
        ],
        quantity: 1,
        price: 2000.0,
        status: "Completed"),
  ].obs;

  Future<String> getAppDownloadPath(String fileName) async {
    Directory? appDirectory = await getExternalStorageDirectory();
    String path = "${appDirectory!.path}/$fileName.xlsx";
    return path;
  }

  void exportOurOrdersToExcel(List<OurOrders> orders) async {
    var excel = Excel.createExcel();
    var sheet = excel['Orders'];
    // Add Headers
    sheet.appendRow([
      TextCellValue("Product Name"),
      TextCellValue("Quantity"),
      TextCellValue("Price"),
      TextCellValue("Status"),
    ]);
    // Add OurOrders Data
    for (var order in orders) {
      sheet.appendRow([
        TextCellValue(order.customername),
        TextCellValue(order.quantity.toString()),
        TextCellValue(order.price.toString()),
        TextCellValue(order.status)
      ]);
    }
    // Get Documents Directory
    String path = await getAppDownloadPath("Orders");
    File file = File(path);
    excel.delete('Sheet1');
    await file.writeAsBytes(excel.encode()!);
    OpenFile.open(path);
  }
}

class OurOrders {
  final String orderId;
  final String customername;
  final int quantity;
  final double price;
  final String status;
  List<Products>? products;

  OurOrders(
      {required this.orderId,
      required this.customername,
      required this.quantity,
      required this.price,
      required this.status,
      this.products});
}

class Products {
  String? name;
  int? quantity;
  double? purchasePrice;
  double? salesPrice;
  double? wholesalePrice;
  int? currentStock;
  String? status;

  Products({
    this.name,
    this.quantity,
    this.purchasePrice,
    this.salesPrice,
    this.wholesalePrice,
    this.currentStock,
    this.status,
  });
}
