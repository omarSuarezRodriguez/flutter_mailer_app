import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final _textController = TextEditingController();
  final _textCorreoElectronico = TextEditingController();
  final _textNumeroCelular = TextEditingController();
  final _textTituloMensaje = TextEditingController();
  final _textMensaje = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Mailer"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Correo del destinatario',
                      ),
                      controller: _textCorreoElectronico,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please, type text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _text = value!;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Celular del destinatario',
                      ),
                      controller: _textNumeroCelular,
                      // maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please, type text';
                        }
                        if (value.length < 6) {
                          return 'Must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _text = value!;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Título del mensaje',
                      ),
                      controller: _textTituloMensaje,
                      // maxLength: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please, type text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _text = value!;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Mensaje',
                      ),
                      controller: _textMensaje,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please, type text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _text = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text('Enviar Correo'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              String correoElec =
                                  _textCorreoElectronico.text.toString();
                              String tituloMensaje =
                                  _textTituloMensaje.text.toString();
                              String mensajeBody = _textMensaje.text.toString();

                              String email = Uri.encodeComponent(correoElec);
                              String subject =
                                  Uri.encodeComponent(tituloMensaje);
                              String body = Uri.encodeComponent(mensajeBody);
                              // print(subject); //output: Hello%20Flutter
                              Uri mail = Uri.parse(
                                  "mailto:$email?subject=$subject&body=$body");
                              if (await launchUrl(mail)) {
                                //email app opened
                              } else {
                                //email app is not opened
                              }
                            }
                          },
                        ),
                        ElevatedButton(
                          child: Text('Enviar Whatsapp'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              String numeroCelular =
                                  '57' + _textNumeroCelular.text.toString();
                              String tituloMensaje =
                                  _textTituloMensaje.text.toString() + '\n\n';
                              String mensajeBody = _textMensaje.text.toString();

                              await launch(
                                  "https://wa.me/${numeroCelular}?text=${tituloMensaje + mensajeBody}");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
