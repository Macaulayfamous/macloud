// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uber_app/controllers/auth_controller.dart';
// import 'package:uber_app/views/screens/auth/login_screen.dart';

// class ServiceRegisterScreen extends StatefulWidget {
//   @override
//   State<ServiceRegisterScreen> createState() => _ServiceRegisterScreenState();
// }

// class _ServiceRegisterScreenState extends State<ServiceRegisterScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
//   final AuthController _authController = AuthController();

//   Uint8List? _image;
//   bool _isLoading = false;

//   late String firstName;

//   late String lastName;

//   late String email;

//   late String password;

//   selectGalleryImage() async {
//     Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

//     setState(() {
//       _image = im;
//     });
//   }

//   registerUser() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String res = await _authController.createUser(
//       firstName,
//       lastName,
//       email,
//       password,
//       _image,
//     );
//     setState(() {
//       _isLoading = false;
//     });

//     if (res == 'success') {
//       Get.to(LoginScreen());
//       Get.snackbar(
//         'Success',
//         'Congratulations Account has been Created For You',
//         colorText: Colors.white,
//         backgroundColor: Colors.pink,
//         margin: EdgeInsets.all(15),
//         icon: Icon(
//           Icons.message,
//           color: Colors.white,
//         ),
//       );

//       setState(() {
//         _isLoading = false;
//       });
//     } else {
//       Get.snackbar(
//         'Error Ocurred',
//         res.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.white,
//         backgroundColor: Colors.red,
//         margin: EdgeInsets.all(15),
//         icon: Icon(
//           Icons.message,
//           color: Colors.white,
//         ),
//       );
//     }
//   }

//   bool saveMe = false;

//   void toggleSaveMe() {
//     setState(() {
//       saveMe = !saveMe;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 495;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double fem = screenWidth / baseWidth;
//     double ffem = fem * 0.97;
//     double textSize = 17 * ffem;
//     double textFieldFontSize = 16 * ffem;
//     double buttonFontSize = 20 * ffem;
//     double screenHeight = MediaQuery.of(context).size.height;

//     // Define different padding values based on screen height
//     double bottomPadding;

//     if (screenHeight < 592) {
//       // For screens shorter than 592 logical pixels (approximately 6.7 inches)
//       bottomPadding = screenHeight * 0.1; // Adjust this value as needed
//     } else {
//       // For larger screens, use a different padding
//       bottomPadding = screenHeight * 0.20; // You can adjust this value too
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         child: Container(
//           width: double.infinity,
//           child: Container(
//             padding:
//                 EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, bottomPadding),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Color(0xFFFF4081),
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage('assets/images/doorpng2.png'),
//               ),
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.fromLTRB(
//                         25 * fem, 66 * fem, 19 * fem, 57.5 * fem),
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.fromLTRB(
//                               102 * fem, 0 * fem, 86.56 * fem, 78 * fem),
//                           width: double.infinity,
//                           child: Center(
//                             child: SizedBox(
//                               width: 262.44 * fem,
//                               height: 151 * fem,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(7 * fem),
//                                 child: Image.asset(
//                                   'assets/images/login-png-2-1.png',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 0 * fem, 14 * fem),
//                           width: double.infinity,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 25 * fem),
//                                 width: double.infinity,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.fromLTRB(
//                                           0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                       child: Text(
//                                         'Full Name',
//                                         style: TextStyle(
//                                           fontSize: textSize,
//                                           fontWeight: FontWeight.w500,
//                                           color: Color(0xffffffff),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(10 * fem),
//                                         color: Color(0xfff2f2f2),
//                                       ),
//                                       child: TextFormField(
                                       
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter your full name';
//                                           }
//                                           return null;
//                                         },
//                                         decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           focusedBorder: InputBorder.none,
//                                           enabledBorder: InputBorder.none,
//                                           errorBorder: InputBorder.none,
//                                           disabledBorder: InputBorder.none,
//                                           contentPadding: EdgeInsets.fromLTRB(
//                                               20 * fem,
//                                               18 * fem,
//                                               25.58 * fem,
//                                               18 * fem),
//                                           hintText: 'Input your full name',
//                                           hintStyle: TextStyle(
//                                               color: Color(0xffbcbcbc)),
//                                         ),
//                                         style: TextStyle(
//                                           fontSize: textFieldFontSize,
//                                           fontWeight: FontWeight.w400,
//                                           color: Color(0xff000000),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // Display error message
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 1 * fem, 11 * fem),
//                           width: 450 * fem,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                 child: Text(
//                                   'Email Address',
//                                   style: TextStyle(
//                                     fontSize: textSize,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xffffffff),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10 * fem),
//                                   color: Color(0xfff2f2f2),
//                                 ),
//                                 child: TextFormField(
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter your email address';
//                                     } else if (!value.contains('@')) {
//                                       return 'Please enter a valid email address';
//                                     }
//                                     return null;
//                                   },
//                                   maxLines: null,
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     errorBorder: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     contentPadding: EdgeInsets.fromLTRB(
//                                         20 * fem,
//                                         18 * fem,
//                                         25.58 * fem,
//                                         18 * fem),
//                                     hintText: 'Input your email@hmail.com',
//                                     hintStyle:
//                                         TextStyle(color: Color(0xffbcbcbc)),
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: textFieldFontSize,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff000000),
//                                   ),
//                                 ),
//                               ),
//                               // Display error message
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 1 * fem, 11 * fem),
//                           width: 450 * fem,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 0 * fem, 5 * fem),
//                                 child: Text(
//                                   'Your password',
//                                   style: TextStyle(
//                                     fontSize: textSize,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xffffffff),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10 * fem),
//                                   color: Color(0xfff2f2f2),
//                                 ),
//                                 child: TextFormField(
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter your password';
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     errorBorder: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     contentPadding: EdgeInsets.fromLTRB(
//                                         20 * fem,
//                                         18 * fem,
//                                         24.6 * fem,
//                                         18 * fem),
//                                     hintText: 'Input your password',
//                                     hintStyle:
//                                         TextStyle(color: Color(0xffbcbcbc)),
//                                   ),
//                                   style: TextStyle(
//                                     fontSize: textFieldFontSize,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff000000),
//                                   ),
//                                 ),
//                               ),
//                               // Display error message
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(
//                               0 * fem, 0 * fem, 3 * fem, 24 * fem),
//                           width: double.infinity,
//                           height: 24 * fem,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     0 * fem, 0 * fem, 151 * fem, 0 * fem),
//                                 height: double.infinity,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           saveMe = !saveMe; // Toggle the state
//                                         });
//                                       },
//                                       child: Container(
//                                         margin: EdgeInsets.fromLTRB(0 * fem,
//                                             0 * fem, 10 * fem, 0 * fem),
//                                         width: 36 * fem,
//                                         height: 20 * fem,
//                                         child: saveMe
//                                             ? Icon(
//                                                 Icons.check_box,
//                                                 color: Color(0xffffffff),
//                                               )
//                                             : Icon(
//                                                 Icons.check_box_outline_blank,
//                                                 color: Color(0xffffffff),
//                                               ),
//                                       ),
//                                     ),
//                                     InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           saveMe = !saveMe; // Toggle the state
//                                         });
//                                       },
//                                       child: Text(
//                                         'Save me',
//                                         style: TextStyle(
//                                           fontSize: textSize,
//                                           fontWeight: saveMe
//                                               ? FontWeight.bold
//                                               : FontWeight
//                                                   .w300, // Change font weight based on state
//                                           color: Color(0xffffffff),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 'Forgot your password?',
//                                 textAlign: TextAlign.right,
//                                 style: TextStyle(
//                                   fontSize: textSize,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(
//                               3 * fem, 0 * fem, 4 * fem, 24 * fem),
//                           child: TextButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 registerUser();
//                               }
//                             },
//                             style: TextButton.styleFrom(
//                               padding: EdgeInsets.zero,
//                             ),
//                             child: Container(
//                               width: double.infinity,
//                               height: 60 * fem,
//                               decoration: BoxDecoration(
//                                 color: Color(0xffffffff),
//                                 borderRadius: BorderRadius.circular(10 * fem),
//                               ),
//                               child: Center(
//                                 child: _isLoading
//                                     ? Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: SpinKitFadingCircle(
//                                           color: Colors.pink,
//                                           size: 50.0,
//                                         ),
//                                       )
//                                     : Text(
//                                         'Register',
//                                         style: TextStyle(
//                                           fontSize: buttonFontSize,
//                                           fontWeight: FontWeight.w500,
//                                           color: Color(0xff000000),
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
