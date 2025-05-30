import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/features/Data/Auth/auth_service.dart';
import 'package:paainet/utils/themeData/const.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  String _errorMessage = "";
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final result = await AuthService().signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      username: _usernameController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (result == null) {
      if (context.mounted) context.go('/home');
    } else {
      setState(() {
        _errorMessage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  style: GoogleFonts.sora(
                    fontSize: 70,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                  children: const [
                    TextSpan(
                        text: "P", style: TextStyle(color: AppColors.text)),
                    TextSpan(
                        text: "a", style: TextStyle(color: AppColors.text)),
                    TextSpan(text: "a", style: TextStyle(color: Colors.blue)),
                    TextSpan(text: "i", style: TextStyle(color: Colors.red)),
                    TextSpan(
                        text: "Net", style: TextStyle(color: AppColors.text)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  style: GoogleFonts.lato(
                    fontSize: screenWidth < 600 ? 12 : 20,
                    wordSpacing: 5,
                  ),
                  children: const [
                    TextSpan(
                        text: "Own",
                        style:
                            TextStyle(color: Color.fromARGB(255, 171, 20, 20))),
                    TextSpan(text: " "),
                    TextSpan(
                        text: "freedom", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth > 600 ? 480 : screenWidth * 0.95,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.button.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(30, 0, 0, 0),
                        blurRadius: 30,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      TextField(
                        controller: _usernameController,
                        style: const TextStyle(color: AppColors.text),
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: AppColors.text),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(color: AppColors.text),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: AppColors.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_usernameController.text.isEmpty ||
                                      _emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    setState(() {
                                      _errorMessage = "Fields can't be empty";
                                    });
                                  } else {
                                    _handleSignUp();
                                  }
                                },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            foregroundColor: AppColors.buttonText,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: AppColors.buttonText,
                                )
                              : Text(
                                  "Sign Up",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.goNamed('login');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.button,
                      textStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
