import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:lojavirtual/models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _adressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nome completo',
                  ),
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Nome inválido';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@')) {
                      return 'E-mail inválido';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return 'Senha inválida';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _adressController,
                  decoration: InputDecoration(
                    hintText: 'Endereço',
                  ),
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Endereço inválido';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'adress': _adressController.text
                        };

                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSucess: _onSucess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Usuário criado com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Falha ao criar o usuário.'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
