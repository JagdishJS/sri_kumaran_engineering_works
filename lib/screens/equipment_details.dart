import '../library.dart';

class EquipmentDetailsPage extends StatefulWidget {
  const EquipmentDetailsPage({
    super.key,
  });

  @override
  _EquipmentDetailsPageState createState() => _EquipmentDetailsPageState();
}

class _EquipmentDetailsPageState extends State<EquipmentDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return GetBuilder<EquipmentsController>(
        init: EquipmentsController(),
        builder: (equipmentsController) {
          final equipment = Get.arguments;
          equipmentsController.equipment.value = equipment;
          return PopScope(
              canPop: true,
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (didPop && Get.isOverlaysOpen) {
                  Get.back();
                }
                return;
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: celodon,
                  title: Text('Equipment Details'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        equipmentsController.isEditing
                            ? Column(
                                children: [
                                  TextField(
                                    controller:
                                        equipmentsController.nameController,
                                    decoration:
                                        InputDecoration(labelText: 'Name'),
                                  ),
                                  TextField(
                                    controller:
                                        equipmentsController.typeController,
                                    decoration:
                                        InputDecoration(labelText: 'Type'),
                                  ),
                                  TextField(
                                    controller:
                                        equipmentsController.modelController,
                                    decoration:
                                        InputDecoration(labelText: 'Model'),
                                  ),
                                  TextField(
                                    controller:
                                        equipmentsController.priceController,
                                    decoration:
                                        InputDecoration(labelText: 'Price'),
                                  ),
                                  TextField(
                                    controller:
                                        equipmentsController.discountController,
                                    decoration:
                                        InputDecoration(labelText: 'Discount'),
                                  ),
                                  TextField(
                                    controller: equipmentsController
                                        .currentStockController,
                                    decoration: InputDecoration(
                                        labelText: 'Current Stock'),
                                  ),
                                  TextField(
                                    controller:
                                        equipmentsController.statusController,
                                    decoration:
                                        InputDecoration(labelText: 'Status'),
                                  ),
                                  TextField(
                                    controller: equipmentsController
                                        .descriptionController,
                                    decoration: InputDecoration(
                                        labelText: 'Description'),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed:
                                        equipmentsController.saveEquipment,
                                    child: Text('Save Changes'),
                                  ),
                                ],
                              )
                            : Container(
                                width: dw,
                                margin: EdgeInsets.all(dw * 0.01),
                                padding: EdgeInsets.symmetric(
                                    vertical: dh * 0.01, horizontal: dw * 0.02),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .cardColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(context).cardColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        width: dw,
                                        margin: EdgeInsets.all(dw * 0.01),
                                        padding: EdgeInsets.symmetric(
                                            vertical: dh * 0.01,
                                            horizontal: dw * 0.02),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .withValues(alpha: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Theme.of(context).cardColor,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Name: ${equipmentsController.equipment.value.name}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Type: ${equipmentsController.equipment.value.type}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Model: ${equipmentsController.equipment.value.model}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Price: ${equipmentsController.equipment.value.price}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Discount: ${equipmentsController.equipment.value.discount}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Current Stock: ${equipmentsController.equipment.value.currentStock}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Status: ${equipmentsController.equipment.value.status}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                            Text(
                                                'Description: ${equipmentsController.equipment.value.description}',
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(
                                              height: dh * 0.02,
                                            ),
                                          ],
                                        )),
                                    ElevatedButton(
                                      onPressed:
                                          equipmentsController.toggleEditing,
                                      child: Text(
                                        'Edit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

class AddEquipmentDetailsPage extends StatefulWidget {
  const AddEquipmentDetailsPage({
    super.key,
  });

  @override
  _AddEquipmentDetailsPageState createState() =>
      _AddEquipmentDetailsPageState();
}

class _AddEquipmentDetailsPageState extends State<AddEquipmentDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return GetBuilder<EquipmentsController>(
        init: EquipmentsController(),
        builder: (equipmentsController) {
          return PopScope(
              canPop: true,
              onPopInvokedWithResult: (bool didPop, Object? result) async {
                if (didPop && Get.isOverlaysOpen) {
                  Get.back();
                }
                return;
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: celodon,
                  title: Text('Equipment Details'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            TextField(
                              controller: equipmentsController.nameController,
                              decoration: InputDecoration(labelText: 'Name'),
                            ),
                            TextField(
                              controller: equipmentsController.typeController,
                              decoration: InputDecoration(labelText: 'Type'),
                            ),
                            TextField(
                              controller: equipmentsController.modelController,
                              decoration: InputDecoration(labelText: 'Model'),
                            ),
                            TextField(
                              controller: equipmentsController.priceController,
                              decoration: InputDecoration(labelText: 'Price'),
                            ),
                            TextField(
                              controller:
                                  equipmentsController.discountController,
                              decoration:
                                  InputDecoration(labelText: 'Discount'),
                            ),
                            TextField(
                              controller:
                                  equipmentsController.currentStockController,
                              decoration:
                                  InputDecoration(labelText: 'Current Stock'),
                            ),
                            TextField(
                              controller: equipmentsController.statusController,
                              decoration: InputDecoration(labelText: 'Status'),
                            ),
                            TextField(
                              controller:
                                  equipmentsController.descriptionController,
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: equipmentsController.saveEquipment,
                              child: Text('Save Equipment'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
