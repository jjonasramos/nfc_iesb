import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:nfc_iesb/Classes/User.dart';
import 'package:nfc_iesb/Screens/Account/account.dart';
import 'package:nfc_iesb/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool usuarioEncontrado;
  bool isRead;
  int currentUser;  

  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    usuarioEncontrado = false;
    isRead = false;
    currentUser = null;
    super.initState();
  }

  @override
  void dispose() {
    usuarioEncontrado = false;
    isRead = false;
    currentUser = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startNFC();
    
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          
          decoration: BoxDecoration(
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 42
                ),
                child: Image.asset('assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 20
                ),
                child: Image.asset('assets/images/nfc-logo.png',
                  width: 150,
                  height: 150,
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  colorBlendMode: BlendMode.modulate
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/1.5,
                child: Text('Aproxime sua carteira estudantil na parte traseira do seu celular',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: 'Nunito'
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 40
                ),
                child: Column(
                  children: <Widget>[
                    if(isRead && usuarioEncontrado) loginAluno(context)
                    else if(isRead && !usuarioEncontrado) Text('Usuário não encontrado!'.toUpperCase(),
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16,
                                                              fontFamily: 'Nunito'
                                                            ),
                                                          )
                  ],
                ),
              ),
            ],
          )
      ),
        ),
    );
  }

  Widget loginAluno(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            bottom: 32
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('E aí, ',
                style: TextStyle(
                  fontFamily: 'Nunito'
                ),
              ),
              Text(users.getUser(currentUser).getShortNome(),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Nunito'
                ),
              ),
            ],
          ),
        ),
        Container (
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: EdgeInsets.only(
            left: 20,
            right: 20
          ),
          padding: EdgeInsets.only(
            top: 4, 
            left: 16, 
            right: 16, 
            bottom: 4
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50)
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              focusColor: Colors.red,
              border: InputBorder.none,
              icon: Icon(Icons.vpn_key,
                color: Color.fromRGBO(237, 33, 57, 1),
              ),
              hintText: 'Senha (Aluno Online)'
            ),
          ),
        ),

        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 32,
            left: 20,
            right: 20
          ),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(237, 33, 57, 1),
                Color.fromRGBO(147, 42, 30, 1)
                
              ],
            ),

            borderRadius: BorderRadius.all(
              Radius.circular(50)
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),

          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Center(
                child: Text('Entrar'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito'
                    ),
                  ),
                ),
              onTap: () async {
                if(checkPassword(passwordController.text))
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Account(index: currentUser)));
                else
                  _showDialogPassword();
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showDialogPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Aviso',
            style: TextStyle(
              fontFamily: 'Nunito'
            ),
          ),
          content: Text('A senha digitada está incorreta. Tente novamente.',
            style: TextStyle(
              fontFamily: 'Nunito'
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Entendi!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        );
      }
    );
  }

  Future<void> startNFC() async {
    try { 
      FlutterNfcReader.read().then((response){
        setState(() {
          for(int i=0; i < users.getUsersSize(); i++) {
            for(int k=0; k < users.getUser(i).getListIdSize(); k++) {
              if(users.getUsers()[i].getListId()[k] == response.id) {
                usuarioEncontrado = true;
                currentUser = i;
                break;
              } else 
                usuarioEncontrado = false;
            }

            if(usuarioEncontrado) break;
          }

          isRead = true;
        });
      });
    } 
    on PlatformException {  }

  }

  bool checkPassword(String pw) {
    if(pw == users.getUser(currentUser).getSenha())
      return true;
    
    return false;
  }
}

