import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paainet/features/Data/Auth/auth_service.dart';
import 'package:paainet/utils/themeData/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorText;
  bool _isPasswordVisible = false;
  bool _isLoading = false; // 👈 spinner flag

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await AuthService().supabase.auth.signInWithPassword(
            email: email,
            password: password,
          );

      final user = response.user;
      if (user != null) {
        return null; // success
      } else {
        return 'User is null';
      }
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Unexpected error: $e';
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
                  style: GoogleFonts.lato(
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
                  style: GoogleFonts.sora(
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
                      const SizedBox(height: 18),
                      if (_errorText != null) ...[
                        Text(
                          _errorText!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              setState(() {
                                _errorText = "Fields can't be empty";
                              });
                              return;
                            }

                            setState(() {
                              _isLoading = true;
                              _errorText = null;
                            });

                            final errorMessage = await signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            if (errorMessage == null) {
                              context.goNamed('home');
                            } else {
                              setState(() {
                                _errorText = errorMessage;
                              });
                            }

                            setState(() {
                              _isLoading = false;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.button,
                            foregroundColor: AppColors.buttonText,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            side: BorderSide.none,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.text,
                                  ),
                                )
                              : Text(
                                  "Login",
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
                    "Don't have an account?",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.goNamed('signup');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.button,
                      textStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text("Sign Up"),
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
