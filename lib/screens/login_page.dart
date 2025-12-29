// import 'package:canteen/screens/menu_page.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({
//     super.key,
//   }); // read more about this. When removed, it throws a warning.

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final String storedUsername = "cwper";
//   final String storedPassword = "cwper";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Whenever image is added, add the asset to pubspec.yaml
//         leading: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Image.asset(
//             'assets/indian-railways-logo.png', // your left logo
//             fit: BoxFit.contain,
//           ),
//         ),

//         title: Text("CARRIAGE WORKS, PERAMBUR"),
//         backgroundColor: Colors.blue[500],
//         centerTitle: true,
//         elevation: 4,
//       ),
//       backgroundColor: Colors.blue[100],

//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Username field
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(
//                 labelText: "Username",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             SizedBox(height: 20),

//             // Password field
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             SizedBox(height: 30),

//             // Login button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // print("Username: ${usernameController.text}");
//                   // print("Password: ${passwordController.text}");

//                   // Add login validation or navigate to next page
//                   String enteredUsername = usernameController.text.trim();
//                   String enteredPassword = passwordController.text.trim();

//                   // validating username
//                   if (enteredUsername != storedUsername) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text("INVALID USERNAME!!!"),
//                         content: Text("The username you entered is incorrect."),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text("OK"),
//                           ),
//                         ],
//                       ),
//                     );
//                     return;
//                   }

//                   // validating password
//                   if (enteredPassword != storedPassword) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text("Invalid Password"),
//                         content: Text("The password you entered is incorrect."),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text("OK"),
//                           ),
//                         ],
//                       ),
//                     );
//                     return;
//                   }

//                   // both credentials matched
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text("Login Successful"),
//                       content: Text("Welcome!"),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context); // close dialog

//                             // Navigate to next screen
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     MenuPage(userName: enteredUsername),
//                               ),
//                             );
//                           },
//                           child: Text("OK"),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Text("Login", style: TextStyle(fontSize: 20)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
