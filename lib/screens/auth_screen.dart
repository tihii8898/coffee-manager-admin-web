import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  var _enterdEmail = '';
  var _enterdPassword = '';
  var _isAuthenticating = false;
  bool _obscurePasswordState = true;

  void _userLogin() async {
    _formKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });

      await _firebaseAuth.signInWithEmailAndPassword(
          email: _enterdEmail, password: _enterdPassword);
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
                              autovalidateMode: AutovalidateMode.always,
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
                                      labelText: 'Username using email',
                                      suffixText: '@gmail.com',
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          value.trim().length < 3) {
                                        return 'Username must at least 3 character!';
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) =>
                                        _enterdEmail = '$newValue@gmail.com',
                                  ),
                                  const SizedBox(
                                    height: 15,
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
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty ||
                                          value.trim().length < 6) {
                                        return 'Password must at least 6 character!';
                                      }
                                      return null;
                                    },
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
                                    onPressed: _userLogin,
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                    ),
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
