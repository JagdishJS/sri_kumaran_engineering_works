import 'package:flutter/material.dart';

import '../library.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  OrderDetailScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(order.orderId)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contentView("Invoice Number:", '${order.orderId}'),
            contentView("Customer name:", '${order.customername}'),
            contentView("Order Status:", '${order.status}'),
            SizedBox(
              height: 20,
            ),
            contentView("Purchased Items:", ""),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: 
              order.products!.isEmpty ? 
              Center(child: Text("No Items"),) :
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: order.products!.length,
                  itemBuilder: (context, i) {
                    Products pro = order.products![i];
                    int? qty = pro.quantity;
                    String itemName = "${pro.name}";
                  return Container(
                      height: dh * 0.06,
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${qty}  X '),
                          Expanded(
                            child: SizedBox(
                              width: dw * .22,
                              child: Text(itemName,),
                            ),
                          ),
                          Text(
                              '₹${'100.00'}',),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
            height: dh * .01,
          ),

         Container(
            height: dh * .05,
            padding: EdgeInsets.symmetric(horizontal: dw * .008),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 244, 244),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Qty : ${order.quantity}',
                    ),
                Text(
                    'Tax : ${"100.00"}'),
                Text(
                    'Discount : ${'10%'}'),
              ],
            ),
          ),

        SizedBox(
            height: dh * .01,
          ),
          
          Container(
            // color: Colors.red,
            child: contentView("Total :",
                "₹${order.price.toStringAsFixed(2)}"),
          ),
          
          ],
        ),
      ),
    );
  }

  Widget contentView(detail, name) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$detail  ',
          ),
          Text(
            '$name',
          )
        ],
      ),
    );
  }
}
