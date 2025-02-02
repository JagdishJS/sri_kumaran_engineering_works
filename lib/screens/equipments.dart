import '../library.dart';

class EquipmentsListWidget extends StatefulWidget {
  const EquipmentsListWidget({super.key});

  @override
  State<EquipmentsListWidget> createState() => _EquipmentsListWidgetState();
}

class _EquipmentsListWidgetState extends State<EquipmentsListWidget> {
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
                if (didPop) {
                  Get.back();
                }
                return;
              },
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                  backgroundColor: celodon,
                  title: Text('Equipments'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          equipmentsController.exportEquipmentsToExcel(
                              equipmentsController.equipments);
                        },
                        icon: Icon(Icons.download_for_offline_rounded)),
                    IconButton(
                        onPressed: () {
                          Get.toNamed("addEquipmentsDetails");
                        },
                        icon: Icon(Icons.add_circle_outlined)),
                    SizedBox(width: dw * 0.05),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        equipmentsController.equipments.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount:
                                    equipmentsController.equipments.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed('equipmentsDetails',
                                          arguments: equipmentsController
                                              .equipments[index]);
                                    },
                                    child: equipmentsWidget(
                                        equipmentsController.equipments[index]),
                                  );
                                },
                              )
                            : Center(
                                child: Image.asset(
                                    'assets/app_logo/order_empty.png'),
                              ),
                        SizedBox(
                          height: dh * 0.1,
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Card equipmentsWidget(Equipments equipment) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.all(10),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(dh * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipment.name!,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: dh * 0.01,
                ),
                Text(
                  "UID: ${equipment.uid}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: dh * 0.01,
                ),
                Text(
                  "Current Stock: ${equipment.currentStock}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: dh * 0.01,
                ),
                Text(
                  "Price: ₹${equipment.price}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            Column(
              children: [
                Text(equipment.status!,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: equipment.status == "Available"
                              ? Colors.green
                              : Colors.orange,
                        )),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Action",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
