import './../library.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy loads the controller when it is first accessed.
    Get.lazyPut<CommonController>(() => CommonController(), fenix: true);
    Get.lazyPut<EquipmentsController>(() => EquipmentsController(),
        fenix: true);
    Get.lazyPut<OrdersController>(() => OrdersController(), fenix: true);
    Get.lazyPut<StorageController>(() => StorageController(), fenix: true);
  }
}
