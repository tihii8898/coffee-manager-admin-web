import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoginMode = true;
  var _enterdEmail = '';
  var _enterdPassword = '';
  var _enteredUserName = '';
  var _isAuthenticating = false;
  bool _obscurePasswordState = true;

  String? _passwordVadilator(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

    if (value.isEmpty) {
      return 'Please enter password!';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must follow rules: \n * Should contain at least 1 upper case\n * Should contain at least 1 lower case\n * Should contain at least 1 digit\n * Should contain at least 1 special character\n * At least 6 charaters in lengh';
      }
      return null;
    }
  }

  void _userFormSubmitHandler() async {
    var validationState = _formKey.currentState!.validate();
    if (!validationState) {
      return;
    }
    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLoginMode) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: _enterdEmail, password: _enterdPassword);
      } else {
        final userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: _enterdEmail, password: _enterdPassword);

        await _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'username': _enteredUserName,
          'email': _enterdEmail,
          'password': _enterdPassword,
          'createdAt': DateTime.now(),
        });
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('ERROR $e');
    }
    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: Colors.grey,
                                          ),
                                      labelText: 'Email',
                                      suffixText: '@gmail.com',
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          value.trim().length < 3) {
                                        return 'Email must at least 3 character!';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) =>
                                        _enterdEmail = '$newValue@gmail.com',
                                  ),
                                  if (!_isLoginMode)
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        labelText: 'Username',
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().length < 3) {
                                          return 'Username must be at least 3 characters';
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) =>
                                          _enteredUserName = newValue!,
                                    ),
                                  TextFormField(
                                    obscureText: _obscurePasswordState,
                                    decoration: InputDecoration(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: Colors.grey,
                                          ),
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: _obscurePasswordState
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onPressed: () => setState(() {
                                          _obscurePasswordState =
                                              !_obscurePasswordState;
                                        }),
                                      ),
                                    ),
                                    validator: (value) =>
                                        _passwordVadilator(value!),
                                    onSaved: (newValue) =>
                                        _enterdPassword = newValue!,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            _isAuthenticating
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                    onPressed: _userFormSubmitHandler,
                                    child: Text(
                                      _isLoginMode ? 'Login' : 'Sign up',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isLoginMode
                                      ? 'Don\' have account yet ?'
                                      : 'Already have an account ?',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                MaterialButton(
                                  hoverColor: Colors.transparent,
                                  textColor:
                                      Theme.of(context).colorScheme.primary,
                                  onPressed: () => setState(
                                    () {
                                      _isLoginMode = !_isLoginMode;
                                    },
                                  ),
                                  child:
                                      Text(_isLoginMode ? 'Sign up' : 'Login'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
