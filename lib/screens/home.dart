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
            body: Padding(
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
                          image:
                              AssetImage("assets/app_logo/sri_text_copy.png")),
                    ),
                  ),
                  SizedBox(height: dh * 0.1)
                ],
              ),
            ),
          );
        });
  }
}
