import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/show_splash.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showSplash = true; // for splash bool
  void _hideSplash() {
    // for splash methon
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      // for splash condition
      return ShowSplash(onSplashComplete: _hideSplash);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome back,  ${state.user.name}!')),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
              // const SnackBar(content: Text('Wrong password'))
            );
          }
        },

        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 8.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Text(
                            'ECOM',
                            style: GoogleFonts.caveatBrush(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 19),
                        const Center(
                          child: Text(
                            'Create your account',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF6F6F6F),
                          ),
                        ),
                      ),
                    ),
            
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'ex: jon.smith@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF6F6F6F),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '**********',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 30),
                    state is AuthLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                LoginRequested(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 160,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                            ),
                            child: const Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    const SizedBox(height: 50),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account"),
            
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RegisterPage.routName);
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(color: Colors.blue, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}





// center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                  // child: const Text(
                  //   'ECOM',
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.blue,
                  //     letterSpacing: 2,
                  //   ),
                  // ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'ECOMMERCE APP',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 const CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
                
//               ],
//             ),