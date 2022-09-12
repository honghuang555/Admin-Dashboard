import 'package:admin/controllers/clientController.dart';
import 'package:admin/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
        route: '/',
        body: Column(

          children: [
          Align(alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left:50.0,top: 10),
              child: CustomButton(
                icon:Icon(Icons.add),
                text: 'Add New Client',
                onPressed: () {
                  // clientController.openAddClientDialog(context);
              }),
            ),
          ), 
           Obx(() => 
            Container(
                height: height * 0.95,
                width: width,
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: width / 10,
                  rightHandSideColumnWidth: width * 9 / 10,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(context),
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  itemCount: clientController.clients.value.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black54,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                  rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                  enablePullToRefresh: false,
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
          child: Text(clientController.sortedClients()[index].phone),
          width: width/9,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    ));
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() => Container(
        child: Text(clientController.sortedClients()[index].name),
        width: width / 10,
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
        width: width / 10,
        child: _getTitleItemWidget('Client Name', width / 10),
      ),
      SizedBox(width: width / 9, child: _getTitleItemWidget('Contact Number', width / 9)),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }
}

