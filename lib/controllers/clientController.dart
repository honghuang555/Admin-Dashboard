import 'package:admin/models/client.dart';
import 'package:admin/models/package.dart';
import 'package:admin/widget/customButton.dart';
import 'package:admin/widget/customTextfield.dart';
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
  RxString searchText=''.obs;
  RxList<Package> clientPackage =<Package>[].obs;

  List<Client> filterClient(){
    List<Client> temp = [];
    temp = [...clients.value];
    if(searchText.value!=''){
      temp.removeWhere((element) => element.name.toLowerCase().contains(searchText.toLowerCase())==false);
    }

    return temp;
  }

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
            .collection('Client')
            .add(Client(id:'',name: clientName.text,phone: clientPhone.text,package: clientPackage).toFirebaseMap());
        clientName.text = '';
        clientPhone.text='';
        clientPackage.value=<Package>[];
        Get.back();
      } else {
        print('duplicate client!');
        errorMsg.value = 'Duplicate client being added!';
      }
    } 
    isLoading.value = false;
  }

  Future openAddClientDialog(BuildContext context) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
              height: 280,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create a client'),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      
                    },
                    label: 'Client Name',
                    textEditingController: clientName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      
                    },
                    label: 'Contact Number',
                    textEditingController: clientPhone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => 
                    errorMsg.value == '' ? Container() : Text(errorMsg.value),
                  ),
                  Obx(() => CustomButton(
                    icon: Icon(Icons.add),
                        isLoading: isLoading.value,
                        text: 'Create Client',
                        onPressed: createClient,
                      )),
                ],
              ),
            ),
          );
        }).then((value) => {});
  }


}
