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
    return GetBuilder<CommonController>(
        init: CommonController(),
        builder: (commonController) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text('Orders'),
              actions: [
                IconButton(
                    onPressed: () {
                      commonController
                          .exportOrdersToExcel(commonController.orders);
                    },
                    icon: Icon(Icons.upload_file))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("Orders",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .displayLarge!
                    //             .copyWith(fontWeight: FontWeight.bold)),
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: Text("See All",
                    //           style: Theme.of(context).textTheme.displayMedium),
                    //     ),
                    //   ],
                    // ),
                    commonController.orders.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: commonController.orders.length,
                            itemBuilder: (context, index) {
                              return ordersWidget(
                                  commonController.orders[index]);
                            },
                          )
                        : Center(
                            child:
                                Image.asset('assets/app_logo/order_empty.png'),
                          ),
                    SizedBox(
                      height: dh * 0.1,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Card ordersWidget(Order order) {
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
                  order.name,
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
