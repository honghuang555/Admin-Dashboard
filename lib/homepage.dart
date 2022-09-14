import 'package:admin/controllers/clientController.dart';
import 'package:admin/widget/customButton.dart';
import 'package:admin/widget/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:fluro/fluro.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ClientController clientController=Get.find();
  @override
  Widget build(BuildContext context) {
       var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height
     - AppBar().preferredSize.height;
    return MyScaffold(
        route: '/homepage',
        body: Column(

          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.only(left: 50,top: 10),
              child: Container(
                height: 50,
                width: 200,
                child: CustomTextField(onChanged: (value) {
                  clientController.searchText.value=value;
                },
                label: 'Search by Name',
                
                ),
              ),
              ),
              ),
              Align(alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(left:50.0,top: 10),
                  child: CustomButton(
                    icon:Icon(Icons.add),
                    text: 'Add New Client',
                    onPressed: () async{
                      clientController.openAddClientDialog(context);
                  }),
                ),
              ),
            ],
          ), 
           Obx(() => 
            Container(
                height: height-60,
                width: width-36,
                child: Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18),
                  child: HorizontalDataTable(
                    leftHandSideColumnWidth: (width-36) / 4,
                    rightHandSideColumnWidth: (width-36) * 3 / 4,
                    isFixedHeader: true,
                    headerWidgets: _getTitleWidget(context),
                    leftSideItemBuilder: _generateFirstColumnRow,
                    rightSideItemBuilder: _generateRightHandSideColumnRow,
                    itemCount: clientController.filterClient().length,
                    rowSeparatorWidget: const Divider(
                      color: Colors.black54,
                      height: 1.0,
                      thickness: 0.0,
                    ),
                    leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                    rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                    enablePullToRefresh: false,
                  ),
                )
            )
            )
          ],
        ),
    );}


  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
        var width = MediaQuery.of(context).size.width;
    return Obx(()=>Row(
      children: <Widget>[
         Container(
          child: Text(clientController.filterClient()[index].phone),
          width: (width-36)/4,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
         Container(
          child: Text(clientController.filterClient()[index].package.length.toString()),
          width: (width-36)/4,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    ));
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() => Container(
        child: Text(clientController.filterClient()[index].name),
        width: (width-36)/4,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
      )
    ); 
  }

  List<Widget> _getTitleWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return [
      SizedBox(
        width: (width-36)/4,
        child: _getTitleItemWidget('Client Name',(width-36)/4),
      ),
      SizedBox(width: (width-36)/4, child: _getTitleItemWidget('Contact Number',(width-36)/4)),
      SizedBox(width: (width-36)/4, child: _getTitleItemWidget('Package Used',(width-36)/4)),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: (width-36),
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }
}


class MyScaffold extends StatelessWidget {
  MyScaffold({
     Key? key,
    required this.route,
    required this.body,
  }) : super(key: key);

  final Widget body;
  final String route;


  List<AdminMenuItem> sideBarItems = [
    AdminMenuItem(
      title: 'Home',
      route: '/homepage',
      icon: Icons.home,
    ),
    AdminMenuItem(
      title: 'Client Management',
      icon: Icons.settings_applications,
      route:'/client'
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return  AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      ),
      sideBar:
      SideBar(
        backgroundColor: Color(0xFFEEEEEE),
        activeBackgroundColor: Colors.black26,
        borderColor: Color(0xFFE7E7E7),
        iconColor: Colors.black87,
        activeIconColor: Color(0xFF06145A),
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
        activeTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        items: sideBarItems ,
        selectedRoute: route,
        onSelected: (item) {
//          ReportController reportController = Get.find();
//          reportController.repoortNo.value = '';
//          print('selected menu item');
          if (item.route != null && item.route != route) {
            print( 'actions: onSelected(): title = ${item.title}, route = ${item.route}');
           Get.toNamed(item.route!);
           // Navigator.of(context).pushNamed(item.route);
          }
        },
      ),
      body: body,
    
    );
  }
}

final router = FluroRouter();

class Routes {
  static Handler _homepageHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return Homepage();
});

  static void configureRoutes(FluroRouter router) {
    router.define('/homepage', handler: _homepageHandler);
  }
}

class Application {
  static FluroRouter router=router;
}

class SideMenue extends StatefulWidget {
  @override
  _SideMenueState createState() => _SideMenueState();
}

class _SideMenueState extends State<SideMenue> {
  _SideMenueState() {
    // final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  static const MaterialColor themeBlack = MaterialColor(
    _themeBlackPrimaryValue,
    <int, Color>{
      50: Color(_themeBlackPrimaryValue),
      100: Color(_themeBlackPrimaryValue),
      200: Color(_themeBlackPrimaryValue),
      300: Color(_themeBlackPrimaryValue),
      400: Color(_themeBlackPrimaryValue),
      500: Color(_themeBlackPrimaryValue),
      600: Color(_themeBlackPrimaryValue),
      700: Color(_themeBlackPrimaryValue),
      800: Color(_themeBlackPrimaryValue),
      900: Color(_themeBlackPrimaryValue),
    },
  );
  static const int _themeBlackPrimaryValue = 0xFF06145A;
  static const Color themeTextPrimary = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Sample',
      theme: ThemeData(
        primarySwatch: themeBlack,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
        primaryTextTheme: Theme.of(context).textTheme.apply(
              bodyColor: themeTextPrimary,
            ),
        primaryIconTheme: IconThemeData(
          color: themeTextPrimary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}
