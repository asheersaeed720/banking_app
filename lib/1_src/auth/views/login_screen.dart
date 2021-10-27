import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/auth/views/signup_screen.dart';
import 'package:banking_app/utils/input_decoration.dart';
import 'package:banking_app/widgets/custom_async_btn.dart';
import 'package:banking_app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyLogin,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 150,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      _buildEmailTextField(),
                      const SizedBox(height: 18.0),
                      _buildPasswordTextField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 14.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return _authController.disableWhileLoad
                              ? const LoadingWidget()
                              : CustomAsyncBtn(
                                  btntxt: 'Login',
                                  onPress: () async {
                                    if (_formKeyLogin.currentState!.validate()) {
                                      _formKeyLogin.currentState!.save();
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      await _authController.logInUser();
                                    }
                                  },
                                );
                        },
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(SignUpScreen.routeName),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Register',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 14.0,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      onChanged: (value) {
        _authController.userModel.email = value.trim();
      },
      validator: (value) {
        bool isValidEmail =
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch('$value');
        if (value!.isEmpty) {
          return 'Required';
        } else if (!isValidEmail) {
          return 'Invalid Email';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(
        context,
        labelText: 'Email',
        preffixIcon: const Icon(Icons.email),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return GetBuilder<AuthController>(
      builder: (_) {
        return TextFormField(
          onChanged: (value) {
            _authController.userModel.password = value.trim();
          },
          obscureText: _authController.obscureText,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required';
            } else if (_authController.userModel.password.length < 6) {
              return 'Too short';
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          decoration: buildPasswordInputDecoration(
            context,
            labelText: 'Password',
            suffixIcon: GestureDetector(
              onTap: () {
                _authController.obscureText = !_authController.obscureText;
              },
              child: Icon(
                _authController.obscureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        );
      },
    );
  }
}
