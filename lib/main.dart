import 'package:admin/instanceBinding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/authController.dart';
import 'homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    const int _themeBlackPrimaryValue = 0xFF06145A;
  const MaterialColor themeBlack = MaterialColor(
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
  
  const Color themeTextPrimary = Colors.white;
  runApp(GetMaterialApp(
        initialBinding: InstanceBinding(),
        initialRoute: '/homepage',
        getPages: [
          GetPage(
              name: '/homepage', page: () => Homepage(),
          )
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: themeBlack,
        primaryIconTheme: IconThemeData(
          color: themeTextPrimary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SideMenue();
  }
}


// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // List<homepage.JobList> _rows=[];

//   AuthController authController = Get.find();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   FocusNode emailFocusNode = new FocusNode();
//   FocusNode passwordFocusNode = new FocusNode();
//   bool _obscureText = true;

//   late String errorText;

//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
    
//     //print (globals.appbarheight);
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: Container(
//           height: height,
//           width: width,
//           child: SingleChildScrollView(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                     flex: 4,
//                     child: Container(
//                       height: height,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("images/login_background.png"),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     )),
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 50,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             height: 80,
//                             width: 230,
//                             child: Image(
//                                 width: 230,
//                                 height: 80,
//                                 fit: BoxFit.fill,
//                                 image: AssetImage('images/DMS_logo_login.png')),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left:10),
//                             child: SizedBox(
//                               height: 80,
//                               width: 50,
//                               child: Image(
//                                   width: 50,
//                                   height: 80,
//                                   fit: BoxFit.fill,
//                                   image: AssetImage('images/icon_login.png')),
//                             ),
//                             ),
//                           SizedBox(
//                             width: 18,
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 80,
//                       ),
//                       Container(
//                           width: width*5 / 9,
//                           padding: EdgeInsets.all(10),
//                           child: Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "DIVING PORTAL QUOTE COMPARISON",
//                                 style: TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   fontFamily: 'Inter'
//                                 ),
//                               ))),
//                       SizedBox(
//                         height: 80,
//                       ),
//                       Container(
//                         width: width / 4,
//                         padding: EdgeInsets.all(10),
//                         child: TextField(
//                           focusNode: emailFocusNode,
//                           keyboardType: TextInputType.emailAddress,
//                           controller: emailController,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black, width: 1)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Colors.black, width: 1),
//                               ),
//                               labelText: 'Email Address',
//                               labelStyle: TextStyle(
//                                   color: emailFocusNode.hasFocus
//                                       ? Colors.grey
//                                       : Colors.grey),
//                               prefixIcon: Icon(
//                                 Icons.email,
//                                 color: Colors.grey,
//                               ),
//                               fillColor: Colors.white,
//                               filled: true),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: width / 4,
//                         padding: EdgeInsets.all(10),
//                         child: TextField(
//                           focusNode: passwordFocusNode,
//                           //keyboardType: TextInputType.emailAddress,
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             errorText: this.errorText,
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: Colors.black, width: 1)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: Colors.black, width: 1),
//                             ),
//                             labelText: 'Password',
//                             labelStyle: TextStyle(
//                                 color: passwordFocusNode.hasFocus
//                                     ? Colors.grey
//                                     : Colors.grey),
//                             prefixIcon: Icon(
//                               Icons.lock,
//                               color: Colors.grey,
//                             ),
//                             filled: true,
//                             suffixIcon: IconButton(
//                               onPressed: _toggle,
//                               icon: _obscureText
//                                   ? Icon(
//                                       Icons.visibility_off,
//                                       color: Colors.grey,
//                                     )
//                                   : Icon(Icons.visibility,
//                                       color: Colors.grey),
//                             ),
//                           ),
//                           obscureText: _obscureText,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Container(
//                         width: width / 4,
//                         child: Align(alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding:EdgeInsets.only(left:10),
//                             child: TextButton(
//                               onPressed: null,
//                               child: Text('Forget Password',style: TextStyle(color: Colors.black54,decoration: TextDecoration.underline,),),
//                             ),
//                           ),
//                         )
//                       ),
//                       SizedBox(height: 60.0),
//                       Container(
//                         width: width / 4,
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 12.0),
//                               child: Container(
//                                 width: 180,
//                                 height: 50,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     if (isValidField(emailController.text) &&
//                                         isValidField(
//                                             passwordController.text)) {
//                                       authController.login(
//                                           emailController.text,
//                                           passwordController.text);
//                                     } else {
//                                       authController.triggerSnack('Error!',
//                                           'Please fill in all fields!');
//                                     }
//                                   },
//                                   child: Text('Login',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontFamily: 'Montserrat',
//                                       )),
//                                   style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Colors.black)),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
                
//               ],
//             ),
//           ),
//         ));
//   }

//   bool isValidField(String x) {
//     if (x.length > 0) return true;
//     return false;
//   }
// }

