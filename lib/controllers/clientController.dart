import 'package:admin/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final clients = <Client>[].obs;
  RxBool isLoading = false.obs;
  TextEditingController clientName = TextEditingController();
  TextEditingController clientPhone=TextEditingController();
  Rxn<Client> selectedClient = Rxn<Client>();

  Stream<List<Client>> listClients() {
    Stream<QuerySnapshot> stream = _firestore.collection('Client').snapshots();
    return stream.map((qShot) => qShot.docs
        .map((doc) => Client.fromFirebase(doc.data(), doc.id))
        .toList());
  }

  RxString errorMsg = ''.obs;

  void reset() {
    selectedClient.value = null;

  }

  @override
  void onInit() {
    clients.bindStream(listClients());
    print('get stream of clients');
    super.onInit();
  }

  List<Client> sortedClients() {
     clients.value.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
     return clients.value;
  }

  //get dropdown formatted list of clients
  List<String> clientsList() {
    List<String> list = [];
    clients.value.forEach((client) {
      list.add(client.name);
    });
    return list;
  }

  Future<void> createClient() async {
    errorMsg.value = '';
    isLoading.value = true;
    if (clientName.text != ''&& clientPhone.text!='') {
      List<String> cList = clientsList();
      //lowercase every name
      for(int i=0; i< cList.length; i++){
        cList[i] = cList[i].toLowerCase();
      }
      if(!cList.contains(clientName.text.toLowerCase())){
        await _firestore
            .collection('Clients')
            .add(Client(id:'',name: clientName.text,phone: clientPhone.text).toFirebaseMap());
        clientName.text = '';
        clientPhone.text='';
        Get.back();
      } else {
        print('duplicate client!');
        errorMsg.value = 'Duplicate client being added!';
      }
    } 
    isLoading.value = false;
  }

  // void openDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           elevation: 0,
  //           child: Container(
  //             padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
  //             height: 200,
  //             width: 200,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 Obx(
  //                   () => TextDropdownFormField(
  //                     controller: selectedClientController,
  //                     options: clientsList(),
  //                     decoration: InputDecoration(
  //                         labelStyle: TextStyle(color: Colors.black),
  //                         focusedBorder: OutlineInputBorder(),
  //                         border: OutlineInputBorder(),
  //                         suffixIcon: Icon(Icons.arrow_drop_down),
  //                         labelText: "Select a Client"),
  //                     onChanged: (dynamic str) {
  //                       selectedClient.value = clients.value.firstWhere((client) => client.name == str);
  //                       Get.back();
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 CustomButton(
  //                     text: 'Create New Client',
  //                     onPressed: () {
  //                       openAddClientDialog(context);
  //                     })
  //               ],
  //             ),
  //           ),
  //         );
  //       }).then((value) => {});
  // }

  // void openAddClientDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           elevation: 0,
  //           child: Container(
  //             padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
  //             height: 220,
  //             width: 200,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text('Create a client'),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 CustomTextField(
  //                   label: 'Client Name',
  //                   textEditingController: clientName,
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 Obx(() => 
  //                   errorMsg.value == '' ? Container() : Text(errorMsg.value),
  //                 ),
  //                 Obx(() => CustomButton(
  //                       isLoading: isLoading.value,
  //                       text: 'Create Client',
  //                       onPressed: createClient,
  //                     )),
  //               ],
  //             ),
  //           ),
  //         );
  //       }).then((value) => {});
  // }
}
