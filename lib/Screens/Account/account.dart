import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:nfc_iesb/main.dart';

class Account extends StatefulWidget {
  final int index;

  Account({Key key, @required this.index}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo;
  IosDeviceInfo iosInfo;

  TextEditingController deviceController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(235, 235, 235, .6),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 320,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20
                ),
                // color: Colors.black,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 15),
                      spreadRadius: -10,
                      blurRadius: 10.0,
                      color: Colors.black12
                    )
                  ]
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(147, 42, 30, .3),
                            blurRadius: 9,
                            spreadRadius: -20,
                            offset: Offset(0, 45),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(237, 33, 57, 1),
                            Color.fromRGBO(147, 42, 30, 1)
                          ]
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),

                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 90,
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  color: Colors.white
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                  child: Image.asset(users.getUser(widget.index).getImage(),
                                    fit: BoxFit.cover,
                                  )
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  textWidget(users.getUser(widget.index).getNome().toUpperCase(), null, 14.0),
                                  textWidget(users.getUser(widget.index).getCurso().toUpperCase(), 12, 14.0),
                                  textWidget(users.getUser(widget.index).getMatricula().toString(), 12, 14.0),
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        textWidgetBottom('assets/images/like.png', 'Curtir'),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 12
                                          ),
                                        ),
                                        textWidgetBottom('assets/images/comment.png', 'Comentar'),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 12
                                          ),
                                        ),
                                        textWidgetBottom('assets/images/share.png', 'Compartilhar'),
                                      ],
                                    ),
                                    
                                    Image.asset('assets/images/logo-invert.png'),
                                  ],
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 25),
                      spreadRadius: -10,
                      blurRadius: 8.0,
                      color: Colors.black12
                    )
                  ]
                ),
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  top: 30
                ),
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: 12,
                  right: 12
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20
                        ),
                        child: Text('Dispositivo associado',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Nunito'
                          ),
                        ),
                      ),
                    ),
                    Container (
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: EdgeInsets.only(
                        // top: 4, 
                        left: 16, 
                        right: 16, 
                        // bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: deviceController,
                        enabled: users.getUser(widget.index).getDevice() != '' ? false : true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusColor: Colors.red,
                          border: InputBorder.none,
                          icon: Icon(Icons.nfc,
                            color: Color.fromRGBO(237, 33, 57, 1),
                          ),
                          hintText: users.getUser(widget.index).getDevice() != '' ? users.getUser(widget.index).getDevice() : 'Nenhum dispositivo'
                        ),
                      ),
                    ),
                    Padding(
                padding: EdgeInsets.only(
                  top: 40
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 103,
                    width: 103,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      ),
                    ),

                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(
                                  bottom: 12
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: users.getUser(widget.index).getDevice() != '' ? Color.fromRGBO(240, 81, 105, .2) : Colors.black26,
                                ),
                                child: Icon(Icons.delete,
                                  size: 40,
                                  color: users.getUser(widget.index).getDevice() != '' ? 
                                                  Color.fromRGBO(196, 0, 29, 1) : Colors.black26,
                                ),
                              ),
                              Text('LIMPAR'.toUpperCase(),
                                style: TextStyle(
                                  color: users.getUser(widget.index).getDevice() != '' ? 
                                                  Colors.black : Colors.black26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 10
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          if(users.getUser(widget.index).getDevice().length != 0) {
                            setState(() {
                              users.getUser(widget.index).removeItemListId();
                              print(users.getUser(widget.index).getListId());
                              users.getUser(widget.index).setDevice('');
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 103,
                    width: 103,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      ),
                    ),

                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.only(
                                  bottom: 12
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: deviceController.text.length > 0 ? Color.fromRGBO(100, 181, 246, .3) : Colors.black26,
                                ),
                                child: Icon(Icons.add_circle,
                                  size: 40,
                                  color: deviceController.text.length > 0 ? Color.fromRGBO(54, 99, 135, 1) : Colors.black45,
                                ),
                              ),
                              Text('SALVAR',
                                style: TextStyle(
                                  color: deviceController.text.length > 0 ? Colors.black : Colors.black26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {

                          // if (Platform.isAndroid) {
                          //   androidInfo = await deviceInfo.androidInfo;
                          // } else if (Platform.isIOS) {
                          //   iosInfo = await deviceInfo.iosInfo;
                          // }

                          setState(() {
                            // users.getUser(widget.index).addListId(androidInfo.androidId.toString());
                            if(deviceController.text.length > 0) {
                              users.getUser(widget.index).addListId(deviceController.text);
                              // users.getUser(widget.index).setDevice('${androidInfo.brand.toUpperCase()} - ${androidInfo.model}');
                              users.getUser(widget.index).setDevice('Samsung - G965F');
                              deviceController.text = '';
                            }
                          });

                        },
                      ),
                    ),
                  ),
                ],
              ),
                  ],
                ),
              ),

              Container(
                height: 70,
                width: 70,
                margin: EdgeInsets.only(
                  top: 32
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
                      child: Icon(Icons.exit_to_app,
                        size: 36,
                        color: Colors.white,
                      )
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textWidget(text, padding, size) {

    return Container(
      padding: EdgeInsets.only(
        top: padding != null ? 12 : 0
      ),
      child: (
        Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
            fontFamily: 'Nunito'
          ),
        )
      ),
    );
  }

  Widget textWidgetBottom(img, text) {
    return (
      Row(
        children: <Widget>[
          Image.asset(img,
            width: 15,
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8
            ),
          ),
          Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Nunito'
            ),
          )
        ],
      )
    );
  }
}