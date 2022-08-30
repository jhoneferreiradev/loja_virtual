import 'package:flutter/material.dart';
import 'package:loja_virtual/domain/user.dart';
import 'package:loja_virtual/service/user_service.dart';
import 'package:provider/provider.dart';

import '../helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserService>(builder: (_, userService, __) {
              return ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: emailController,
                    enabled: !userService.loading,
                    decoration: const InputDecoration(
                        label: Text("E-mail"),
                        suffixIcon:
                            Icon(Icons.email_sharp, color: Colors.blueGrey)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      return (emailValid(email ?? ''))
                          ? null
                          : "Informe um e-mail válido";
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passController,
                    enabled: !userService.loading,
                    decoration: const InputDecoration(
                        label: Text("Senha"),
                        suffixIcon:
                            Icon(Icons.key_sharp, color: Colors.blueGrey)),
                    obscureText: true,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty)
                        return "Informe sua senha";
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: userService.loading ? null : () {},
                      child: const Text("Esqueci minha senha"),
                      style: TextButton.styleFrom(primary: primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: userService.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userService.signIn(
                                      user: User(emailController.text,
                                          passController.text),
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Falha ao entrar. $e"),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      },
                                      onSuccess: () {
                                        //TODO Fechar tela de login
                                      });
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        child: userService.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(primaryColor))
                            : const Text(
                                "Entrar",
                                style: TextStyle(fontSize: 18),
                              ),
                      )),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
