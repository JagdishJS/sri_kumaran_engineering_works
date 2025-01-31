import '../library.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return GetBuilder<CommonController>(
        init: CommonController(),
        builder: (commonController) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: dh * .1,
                      width: dw,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "assets/app_logo/sri_text_copy.png")),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Equipments",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {},
                          child: Text("See All",
                              style: Theme.of(context).textTheme.displayMedium),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dh * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: commonController.equipments.length,
                        itemBuilder: (context, index) {
                          return equipmentsWidget(
                              commonController.equipments[index]);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Orders",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {},
                          child: Text("See All",
                              style: Theme.of(context).textTheme.displayMedium),
                        ),
                      ],
                    ),
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.offAllNamed("sampleInvoice");
              },
              foregroundColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: celodon,
              child: Icon(Icons.add_circle_outline_outlined),
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          );
        });
  }

  Container equipmentsWidget(equipment) {
    double dh = MediaQuery.of(context).size.height;
    double dw = MediaQuery.of(context).size.width;
    return Container(
      height: dh * 0.02,
      width: dw * 0.4,
      margin: EdgeInsets.all(dw * 0.02),
      padding: EdgeInsets.symmetric(vertical: dh * 0.01, horizontal: dw * 0.02),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).cardColor,
              offset: Offset(1, 0),
              blurRadius: 5,
              spreadRadius: 0.2),
        ],
      ),
      child: Center(
        child: Text(equipment,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayLarge),
      ),
    );
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
