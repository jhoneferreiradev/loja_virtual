import 'package:flutter/material.dart';
import 'package:loja_virtual/domain/local_user.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/service/user_service.dart';
import 'package:provider/provider.dart';

import '../base_screen.dart';
import '../helpers/validators.dart';

class SignUpScreen extends StatelessWidget {
  static const String route_name = '/signup';

  LocalUser user = LocalUser();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserService>(builder: (_, userService, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    enabled: !userService.loading,
                    decoration: const InputDecoration(
                        label: Text("Nome completo"),
                        suffixIcon:
                            Icon(Icons.person_pin, color: Colors.blueGrey)),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    onSaved: (fullName) => user.fullName = fullName!,
                    validator: (fullName) {
                      if (fullName == null || fullName.isEmpty) {
                        return "Informe seu nome";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userService.loading,
                    decoration: const InputDecoration(
                        label: Text("E-mail"),
                        suffixIcon:
                            Icon(Icons.email_sharp, color: Colors.blueGrey)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    onSaved: (email) => user.email = email!,
                    validator: (email) {
                      return (emailValid(email ?? ''))
                          ? null
                          : "Informe um e-mail válido";
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userService.loading,
                    decoration: const InputDecoration(
                        label: Text("Senha"),
                        suffixIcon:
                            Icon(Icons.key_sharp, color: Colors.blueGrey)),
                    obscureText: true,
                    onSaved: (pass) => user.password = pass!,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty) {
                        return "Informe sua senha";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    enabled: !userService.loading,
                    decoration: const InputDecoration(
                        label: Text("Repita a senha"),
                        suffixIcon:
                            Icon(Icons.key_sharp, color: Colors.blueGrey)),
                    obscureText: true,
                    onSaved: (pass) => user.confirmPassowrd = pass!,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty) {
                        return "Informe a confirmação da senha";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      onPressed: userService.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                if (user.password.toString() !=
                                    user.confirmPassowrd.toString()) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Falha ao se cadastrar. Senhas digitadas não coincidem."),
                                    backgroundColor: Colors.redAccent,
                                  ));
                                  return;
                                }

                                userService.signUp(
                                    localUser: user,
                                    onFail: (e) {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Falha ao finalizar cadastro. $e"),
                                        backgroundColor: Colors.redAccent,
                                      ));
                                    },
                                    onSuccess: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              BaseScreen.route_name);
                                    });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      child: userService.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(primaryColor))
                          : const Text(
                              "Finalizar cadastro",
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.route_name);
                      },
                      child: const Text("Já tenho conta"),
                      style: TextButton.styleFrom(
                          foregroundColor: primaryColor),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
