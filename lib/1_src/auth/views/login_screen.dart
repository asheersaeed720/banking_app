import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/auth/views/signup_screen.dart';
import 'package:banking_app/utils/app_theme.dart';
import 'package:banking_app/utils/input_decoration.dart';
import 'package:banking_app/widgets/custom_async_btn.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomRight,
            image: AssetImage("assets/images/login_screen_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKeyLogin,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to our app!',
                      style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Nice to see you again.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 42.0),
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
                    const SizedBox(height: 16.0),
                    GetBuilder<AuthController>(
                      builder: (_) {
                        return CustomAsyncBtn(
                          btntxt: 'Login',
                          onPress: _authController.disableWhileLoad
                              ? null
                              : () async {
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
                    const SizedBox(height: 18.0),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: AppTheme.buttonColor),
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(SignUpScreen.routeName),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
