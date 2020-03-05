import 'package:flutter/material.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/models/cart_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 211, 85, 17),
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
