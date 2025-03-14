import 'package:flutter/material.dart';

import '../library.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return GetBuilder<OrdersController>(
        init: OrdersController(),
        builder: (ordersController) {
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
                  title: Text('Orders'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          ordersController
                              .exportOurOrdersToExcel(ordersController.orders);
                        },
                        icon: Icon(Icons.download_for_offline_rounded)),
                    IconButton(
                        onPressed: () {},
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
                        ordersController.orders.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: ordersController.orders.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed('orderDetail',
                                          arguments:
                                              ordersController.orders[index]);
                                    },
                                    child: ordersWidget(
                                        ordersController.orders[index]),
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

  Card ordersWidget(OurOrders order) {
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
                  order.orderId,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: dh * 0.01,
                ),
                Text(
                  "Quantity: ${order.quantity}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: dh * 0.01,
                ),
                Text(
                  "Price: ₹${order.price}",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            Column(
              children: [
                Text(order.status,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: order.status == "Completed"
                              ? Colors.green
                              : order.status == "Shipped"
                                  ? Colors.blue
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
