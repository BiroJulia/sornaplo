// import 'package:country_picker/country_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sornaplo/provider/auth_provider.dart';
// import 'package:sornaplo/reusable_widgets/reusable_widget.dart';
// import 'package:sornaplo/utils/colors_utils.dart';

// class PhoneSignIn extends StatefulWidget {
//   const PhoneSignIn({super.key});

//   @override
//   State<PhoneSignIn> createState() => _PhoneSignInState();
// }

// class _PhoneSignInState extends State<PhoneSignIn> {
//   final TextEditingController phoneNumberController = TextEditingController();

//   Country selectedCountry = Country(
//     phoneCode: "40",
//     countryCode: "RO",
//     e164Sc: 0,
//     geographic: true,
//     level: 1,
//     name: "Romania",
//     example: "Romania",
//     displayName: "Romania",
//     displayNameNoCountryCode: "RO",
//     e164Key: "",
//   );

//   @override
//   Widget build(BuildContext context) {
//     phoneNumberController.selection = TextSelection.fromPosition(
//       TextPosition(
//         offset: phoneNumberController.text.length,
//       ),
//     );
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           hexStringToColor("FAE96F"),
//           hexStringToColor("EC9D00"),
//           hexStringToColor("C96E12")
//         ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).size.height * 0.15, 20, 140),
//             child: Column(
//               children: <Widget>[
//                 logoWidget("assets/images/signup2.png"),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   "Enter your phone number",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "We will send a verification code",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),

//                 ///// phone number text style
//                 TextFormField(
//                   controller: phoneNumberController,
//                   cursorColor: Colors.white,
//                   style: TextStyle(
//                       color: Colors.white.withOpacity(1.0),
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                   onChanged: (value) {
//                     setState(() {
//                       phoneNumberController.text = value;
//                     });
//                   },
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     // labelText: "Enter phone number",
//                     hintText: "Enter phone number",
//                     hintStyle: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                       color: Colors.white70,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: Colors.white38),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.black12),
//                     ),

//                     ///// phone number's box style

//                     labelStyle: TextStyle(color: Colors.white.withOpacity(1.0)),
//                     filled: true,
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                     fillColor: Colors.white.withOpacity(0.3),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                       borderSide:
//                           const BorderSide(width: 0, style: BorderStyle.none),
//                     ),

//                     ////Country icon style
//                     prefixIcon: Container(
//                       padding: const EdgeInsets.fromLTRB(15, 12, 10, 10),
//                       child: InkWell(
//                         onTap: () {
//                           showCountryPicker(
//                               context: context,
//                               countryListTheme: const CountryListThemeData(
//                                 bottomSheetHeight: 600,
//                               ),
//                               onSelect: (value) {
//                                 setState(() {
//                                   selectedCountry = value;
//                                 });
//                               });
//                         },
//                         child: Text(
//                           "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     suffixIcon: phoneNumberController.text.length > 9
//                         ? Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.greenAccent,
//                             ),
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 20),
//                             child: const Icon(
//                               Icons.done,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           )
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 const SizedBox(
//                   width: double.infinity,
//                   height: 10,
//                 ),
//                 // reusableButton(context, "   Login   ", () {}),
//                 CustomButton(
//                     text: "   Login   ", onPressed: () => sendPhoneNumber()),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void sendPhoneNumber() {
//     final ap = Provider.of<AuthProvider>(context, listen: false);
//     String phoneNumber = phoneNumberController.text.trim();
//     ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
//   }
// }
