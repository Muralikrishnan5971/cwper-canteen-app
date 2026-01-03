import 'package:canteen/screens/menu_page.dart';
import 'package:canteen/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscurePassword = true;
  bool _imagePrecached = false;
  bool _loading = false;
  late final ImageProvider _bgImage;

  @override
  void initState() {
    super.initState();
    _bgImage = const AssetImage('assets/login-logo-blue-train.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_imagePrecached) {
      precacheImage(_bgImage, context);
      _imagePrecached = true;
    }
  }

  Future<void> _login() async {
    final email = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email and password required")),
      );
      return;
    }

    try {
      setState(() => _loading = true);

      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MenuPage(userName: user.email ?? "User"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";

      if (e.code == 'user-not-found') {
        message = "No user found for this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _bgImage,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.blue.withValues(alpha: 0.40),
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
                    const SizedBox(height: 40),

                    SvgPicture.asset(
                      'assets/login-page-ir-logo.svg',
                      height: 200,
                      colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 19, 128, 216),
                        BlendMode.srcIn,
                      ),
                    ),

                    const SizedBox(height: 50),

                    Text(
                      'WELCOME TO CARRIAGE WORKS CANTEEN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'DM_Sans',
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 19, 128, 216),
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 100),

                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _login,
                        child: _loading
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              )
                            : const Text("Login"),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                          child: const Text("Register now"),
                        ),
                      ],
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
