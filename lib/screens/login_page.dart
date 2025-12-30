import 'package:canteen/screens/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  }); // read more about this. When removed, it throws a warning.

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String storedUsername = "cwper";
  final String storedPassword = "cwper";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Whenever image is added, add the asset to pubspec.yaml
      //   leading: Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: Image.asset(
      //       'assets/indian-railways-logo.png', // your left logo
      //       fit: BoxFit.contain,
      //     ),
      //   ),

      //   title: Text("CARRIAGE WORKS, PERAMBUR"),
      //   backgroundColor: Colors.blue[500],
      //   centerTitle: true,
      //   elevation: 4,
      // ),
      backgroundColor: Colors.blue[100],

      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login-logo-blue-train.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.blue.withValues(alpha: 0.25),
                  BlendMode.srcOver,
                ),
              ),
            ),

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO
                    // Image.asset('assets/login-page-ir-logo.png', height: 200),
                    // SizedBox(height: 120),
                    SizedBox(height: 40),
                    SvgPicture.asset(
                      'assets/login-page-ir-logo.svg',
                      height: 200,
                      colorFilter: const ColorFilter.mode(
                        Color.fromARGB(
                          255,
                          19,
                          128,
                          216,
                        ), // 👈 change logo color here
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 50),

                    // APP NAME
                    Text(
                      'WELCOME TO CARRIAGE WORKS CANTEEN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 35, // 🔼 big title
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 19, 128, 216),
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Username field - OLD STYLE
                    // TextField(
                    //   controller: usernameController,
                    //   decoration: InputDecoration(
                    //     labelText: "Username",
                    //     border: OutlineInputBorder(),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //   ),
                    // ),
                    TextField(
                      controller: usernameController,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Type your username',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(128, 0, 0, 0),
                          fontSize: 14,
                        ),

                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 19, 128, 216),
                            width: 2,
                          ),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Password field - OLD STYLE
                    // TextField(
                    //   controller: passwordController,
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     labelText: "Password",
                    //     border: OutlineInputBorder(),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //   ),
                    // ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Type your password',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(128, 0, 0, 0),
                          fontSize: 14,
                        ),

                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 19, 128, 216),
                            width: 2,
                          ),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // print("Username: ${usernameController.text}");
                          // print("Password: ${passwordController.text}");

                          // Add login validation or navigate to next page
                          String enteredUsername = usernameController.text
                              .trim();
                          String enteredPassword = passwordController.text
                              .trim();

                          // validating username
                          if (enteredUsername != storedUsername) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("INVALID USERNAME!!!"),
                                content: Text(
                                  "The username you entered is incorrect.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          // validating password
                          if (enteredPassword != storedPassword) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Invalid Password"),
                                content: Text(
                                  "The password you entered is incorrect.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          // both credentials matched
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Login Successful"),
                              content: Text("Welcome!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // close dialog

                                    // Navigate to next screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MenuPage(userName: enteredUsername),
                                      ),
                                    );
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text("Login", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
