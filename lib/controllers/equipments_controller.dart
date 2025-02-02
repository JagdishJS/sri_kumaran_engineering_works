import "dart:io";
import "package:excel/excel.dart";
import "../library.dart";

class EquipmentsController extends GetxController {
  RxList<Equipments> equipments = [
    Equipments(
        name: "Welding Machine",
        type: "Machine Tool",
        model: "LT100",
        price: 50.00,
        discount: 0.0,
        wholesalePrice: 50.00,
        currentStock: 5,
        status: "Available",
        description: "",
        uid: "EQP_001"),
    Equipments(
        name: "Drill Press",
        type: "Machine Tool",
        model: "LT101",
        price: 50.00,
        discount: 0.0,
        wholesalePrice: 50.00,
        currentStock: 5,
        status: "Available",
        description: "",
        uid: "EQP_002"),
    Equipments(
        name: "Circular Saw",
        type: "Machine Tool",
        model: "LT102",
        price: 50.00,
        discount: 0.0,
        wholesalePrice: 50.00,
        currentStock: 5,
        status: "Available",
        description: "",
        uid: "EQP_003"),
    Equipments(
        name: "Angle Grinder",
        type: "Machine Tool",
        model: "LT103",
        price: 50.00,
        discount: 0.0,
        wholesalePrice: 50.00,
        currentStock: 5,
        status: "Available",
        description: "",
        uid: "EQP_004"),
    Equipments(
        name: "Lathe Machine",
        type: "Machine Tool",
        model: "LT104",
        price: 50.00,
        discount: 0.0,
        wholesalePrice: 50.00,
        currentStock: 5,
        status: "Available",
        description: "",
        uid: "EQP_005"),
  ].obs;

  Future<String> getAppDownloadPath(String fileName) async {
    Directory? appDirectory = await getExternalStorageDirectory();
    String path = "${appDirectory!.path}/$fileName.xlsx";
    return path;
  }

  void exportEquipmentsToExcel(List<Equipments> equipments) async {
    var excel = Excel.createExcel();
    var sheet = excel['Equipments'];
    // Add Headers
    sheet.appendRow([
      TextCellValue("UID"),
      TextCellValue("Name"),
      TextCellValue("Current Stock"),
      TextCellValue("Price"),
      TextCellValue("Status"),
    ]);
    // Add Equipment Data
    for (var equipment in equipments) {
      sheet.appendRow([
        TextCellValue(equipment.uid!),
        TextCellValue(equipment.name!),
        TextCellValue(equipment.currentStock.toString()),
        TextCellValue(equipment.price.toString()),
        TextCellValue(equipment.status!)
      ]);
    }
    // Get Documents Directory
    String path = await getAppDownloadPath("Equipments");
    File file = File(path);
    excel.delete('Sheet1');
    await file.writeAsBytes(excel.encode()!);
    OpenFile.open(path);
  }

  Rx<Equipments> equipment = Equipments().obs;

  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController currentStockController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.text = equipment.value.name ?? '';
    typeController.text = equipment.value.type ?? '';
    modelController.text = equipment.value.model ?? '';
    priceController.text = equipment.value.price?.toString() ?? '';
    discountController.text = equipment.value.discount?.toString() ?? '';
    currentStockController.text =
        equipment.value.currentStock?.toString() ?? '';
    statusController.text = equipment.value.status ?? '';
    descriptionController.text = equipment.value.description ?? '';
  }

  void setEquipments(Equipments equipments) {
    equipment.value = equipments;
  }

  void toggleEditing() {
    isEditing = !isEditing;
    update();
  }

  void saveEquipment() {
    // equipment.value.name = nameController.text;
    // equipment.value.type = typeController.text;
    // equipment.value.model = modelController.text;
    // equipment.value.price = double.parse(priceController.text);
    // equipment.value.discount = double.parse(discountController.text);
    // equipment.value.currentStock = int.parse(currentStockController.text);
    // equipment.value.status = statusController.text;
    // equipment.value.description = descriptionController.text;
    isEditing = false;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    typeController.dispose();
    modelController.dispose();
    priceController.dispose();
    discountController.dispose();
    currentStockController.dispose();
    statusController.dispose();
    descriptionController.dispose();
  }
}

class Equipments {
  String? name;
  String? type;
  String? model;
  double? price;
  double? discount;
  double? wholesalePrice;
  int? currentStock;
  String? status;
  String? description;
  String? uid;

  Equipments({
    this.name,
    this.type,
    this.model,
    this.price,
    this.discount,
    this.wholesalePrice,
    this.currentStock,
    this.status,
    this.description,
    this.uid,
  });
}
