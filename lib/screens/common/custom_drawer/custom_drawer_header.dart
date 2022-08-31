import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/service/user_service.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Consumer<UserService>(builder: (_, userService, __) {
      return Container(
        padding: EdgeInsets.fromLTRB(32, 24, 16, 8),
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Loja Virtual",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            Text(
              "Olá, ${userService.localUser?.fullName ?? ''}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            GestureDetector(
              onTap: () {
                userService.isLoggedIn
                    ? userService.signOut(onSuccess: () {})
                    : null;

                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.route_name);
              },
              child: Text(
                userService.isLoggedIn ? "Sair" : "Entre ou cadastre-se >",
                style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }
}
