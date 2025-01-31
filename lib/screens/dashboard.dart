import 'package:sri_kumaran_engineering_works/screens/orders.dart';

import '../library.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _pages = [
    HomePage(),
    OrdersPage(),
  ];

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
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Theme.of(context).iconTheme.color,
                    size: dh * .04,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
            ),
            drawer: Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: celodon),
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      width: dw,
                      height: dh * .4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: dh * .1,
                              width: dw * .2,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    filterQuality: FilterQuality.medium,
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/app_logo/skew_logo.png")),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('Sri Kumaran\nEngineering Works',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home_rounded,
                        color: Theme.of(context)
                            .iconTheme
                            .color), // You can change the color
                    title: Text('Home',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => _onDrawerItemTapped(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.engineering_rounded,
                        color: Theme.of(context)
                            .iconTheme
                            .color), // You can change the color
                    title: Text('Equipments',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => _onDrawerItemTapped(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.shopify_rounded,
                        color: Theme.of(context)
                            .iconTheme
                            .color), // You can change the color
                    title: Text('Orders',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => _onDrawerItemTapped(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.inventory_outlined,
                        color: Theme.of(context)
                            .iconTheme
                            .color), // You can change the color
                    title: Text('Sample Invoice',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => _onDrawerItemTapped(0),
                  ),
                   ListTile(
                    leading: Icon(Icons.contact_support_rounded,
                        color: Theme.of(context)
                            .iconTheme
                            .color), // You can change the color
                    title: Text('Profile',
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => _onDrawerItemTapped(0),
                  ),
                ],
              ),
            ),
            body: _pages[_selectedIndex],
          );
        });
  }
}
