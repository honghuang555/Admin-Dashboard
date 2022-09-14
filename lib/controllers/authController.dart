import 'package:admin/controllers/clientController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/models/user.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:cloud_functions/cloud_functions.dart';

// Fix for null safety
// https://stackoverflow.com/questions/68125824/flutter-getx-initial-value-of-obs-variable-set-to-null

class AuthController extends GetxController {

  RxString currEnv = "".obs;

  AuthController(String env) {
    currEnv.value = env;
    print('currEnv.value: '+currEnv.value);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  User? get user => firebaseUser.value;
  Rxn<AppUser> currentUser = Rxn<AppUser>();
  AppUser? get currUser => currentUser.value;

  //variables to track UI state
  RxBool isLoading = false.obs;
  //flag to check if user is signing out, if so, then reset all user variables
  bool isSigningOut = false;

  RxList<AdminMenuItem> sideBarItems = [
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
  ].obs;

  @override
  void onInit() async {
    print('Hello');
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, handleAuthChanged);
  }

  Future<void> handleAuthChanged(User? firebaseUser) async {
    print('firbase user: '+ firebaseUser!.uid);

    if (!isSigningOut) {
      //initialise user upon sign up/sign in
      DocumentSnapshot doc =
      await _firestore.collection('User').doc(firebaseUser.uid).get();
      if (doc.exists) {
        currentUser.value = AppUser.fromFirebase(doc.data(), doc.id);
      }
    }

    //initialise controllers based on user types
    if (currUser != null) {

      print('I am an admin, placing UserController, TeamController, VendorController');
      Get.lazyPut(() => ClientController());

    }
  }

  void login(String email, String password) async {
    isSigningOut = false;
    isLoading.value = true;
    print('Log in!!!!!');
    try {

      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      firebaseUser.value = user.user;
      print('firbase user: '+ firebaseUser.value!.uid);

      //check if account has not been activated yet
      DocumentSnapshot doc =
      await _firestore.collection('User').where('email',isEqualTo: email).get().then((value) {
        return value.docs.first;
      });
      AppUser temp = AppUser.fromFirebase(doc.data(), doc.id);

      if (temp.userType != UserType.pending &&
          temp.userType != UserType.denied) {

        currentUser.value=temp;
//        await RememberUser(globals.username,globals.usertype,globals.userid,currentUser.value.userTimezone);
        // if user is an approved user
        Get.offAllNamed('/');
      } else {
        //not approved -> bring to pending page
        //Get.off(PendingApprovalPage());
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        triggerSnack('Error while logging in', 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        triggerSnack(
            'Error while logging in', 'Wrong password provided for that user.');
      }
    }
  }

 void logout() async {
   isSigningOut = true;
   //reset current user
   currentUser.value = null;
   if(sideBarItems.length==4){
     sideBarItems.removeLast();
     print('remove application settings from side bar');
   }
   await _auth.signOut().then((value) => Get.offAllNamed('/'));
 }

  //check if the user is approved
  bool isApproved() {
    if (currUser != null && user != null) {
      String? text = currUser?.userType.toString();
      print('currUser?.userType: ' + text!);
    }

    if (currUser?.userType != UserType.pending && user != null) return true;
    return false;
  }

  void triggerSnack(String title, String message) {
    Get.snackbar(title, message,
        icon: Icon(
          Icons.dangerous,
          color: Colors.white,
          size: 30,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}
