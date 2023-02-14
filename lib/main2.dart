import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String _appBarTitle = 'My App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoShield App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CryptoShield App'),
        ),
        body: const AppBody(),
      ),
    );
  }
}

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final _textController = TextEditingController();
  final _textKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _text = '';

  @override
  Widget build(BuildContext context) {
    Future<void> _alertDialog(String texto, String titulo) async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(texto),
              title: Text(titulo),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Okay');
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          })) {
        case 'Okay':
          // _showSnackBar('Thanks!', 'Yes');
          break;
        case 'No':
          // _showSnackBar('Oh! No... Try to provide you best', 'No');
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Text to encrypt',
              ),
              controller: _textController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please, type text';
                }
                // if (value.length < 6) {
                //   return 'Tiene que tener al menos 6 caracteres';
                // }
                return null;
              },
              onSaved: (value) {
                _text = value!;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '6 character password',
              ),
              controller: _textKeyController,
              maxLength: 6,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Encrypt'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // _encriptarTexto(
                      //     _textController.text, _textKeyController.text);
                    }
                  },
                ),
                ElevatedButton(
                  child: Text('Decrypt'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // _desencriptarTexto(
                      // _textController.text, _textKeyController.text);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            IconButton(
              onPressed: () {
                _alertDialog(
                    "This app uses AES-256 encryption, the strongest encryption algorithm available and approved by the National Security Agency (NSA) for protecting classified information. \n\nAES-256 provides the best encryption for text, ensuring that sensitive information remains secure.",
                    "CryptoShield App");
              },
              icon: Icon(Icons.help),
            ),
            IconButton(
              onPressed: () {
                _alertDialog(
                    "If you want to make the password more complex than just 6 characters, you can modify the code here:\n\n\n https://github.com/omarSuarezRodriguez/flutter_encrypt_aes256_app",
                    "Download code");
              },
              icon: Icon(Icons.code),
            ),
          ],
        ),
      ),
    );
  }

  // void _encriptarTexto(String texto, String keySTR) {
  //   try {
  //     // String keySTR = "1234567890123456"; //16 byte
  //     String ivSTR = "1234567890123456";
  //     final key = enc.Key.fromUtf8(keySTR + "1234567890");
  //     final iv = enc.IV.fromUtf8(ivSTR);
  //     final encrypter =
  //         Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

  //     // final encrypter = Encrypter(AES(key));
  //     final encrypted = encrypter.encrypt(texto, iv: iv);
  //     // _textController.text = encrypted.toString();
  //     _textController.text = encrypted.base64;
  //   } catch (e) {
  //     _textController.text = 'Error to encrypt';
  //   }
  // }

  // void _desencriptarTexto(String encryptedText, String keySTR) {
  //   try {
  //     // String keySTR = "1234567890123456"; //16 byte
  //     String ivSTR = "1234567890123456";
  //     final key = enc.Key.fromUtf8(keySTR + "1234567890");
  //     final iv = enc.IV.fromUtf8(ivSTR);
  //     // final key = enc.Key.fromLength(32);
  //     // final key = enc.Key.fromUtf8('polka123');
  //     // final iv = IV.fromLength(16);
  //     final encrypter =
  //         Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  //     // final encrypter = Encrypter(AES(key));
  //     final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
  //     _textController.text = decrypted;
  //   } catch (e) {
  //     _textController.text = 'Error to decrypt';
  //   }
  // }
}




// import 'package:encrypt/encrypt.dart';
// import 'package:flutter/material.dart';
// import 'package:encrypt/encrypt.dart' as enc;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Texto Encriptado',
//       home: EncriptadoHome(),
//     );
//   }
// }

// class EncriptadoHome extends StatefulWidget {
//   const EncriptadoHome({super.key});

//   @override
//   _EncriptadoHomeState createState() => _EncriptadoHomeState();
// }

// class _EncriptadoHomeState extends State<EncriptadoHome> {
//   final _textController = TextEditingController();
//   final _textKeyController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _textKeyController.text = '1234567890123456';
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Texto Encriptado'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   decoration:
//                       const InputDecoration(hintText: 'Texto a encriptar'),
//                   controller: _textController,
//                   maxLines: null,
                  
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       hintText: 'Escriba una clave de 6 digitos'),
//                   maxLength: 6,
//                   controller: _textKeyController,
//                   maxLines: null,
//                 ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     TextButton(
                //       child: Text('Encriptar'),
                //       onPressed: () {
                //         if (_formKey.currentState!.validate()) {
                //           _encriptarTexto(
                //               _textController.text, _textKeyController.text);
                //         }
                //       },
                //     ),
                //     TextButton(
                //       child: Text('Desencriptar'),
                //       onPressed: () {
                //         if (_formKey.currentState!.validate()) {
                //           _desencriptarTexto(
                //               _textController.text, _textKeyController.text);
                //         }
                //       },
                //     ),
                //   ],
                // ),
            //   ],
            // ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _encriptarTexto(String texto, String keySTR) {
//     try {
//       // String keySTR = "1234567890123456"; //16 byte
//       String ivSTR = "1234567890123456";
//       final key = enc.Key.fromUtf8(keySTR + "1234567890");
//       final iv = enc.IV.fromUtf8(ivSTR);
//       // final key = enc.Key.fromUtf8('polka123');
//       // // final key = enc.Key.fromLength(32);
//       // final iv = IV.fromLength(16);
//       final encrypter =
//           Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

//       // final encrypter = Encrypter(AES(key));
//       final encrypted = encrypter.encrypt(texto, iv: iv);
//       _textController.text = encrypted.base64;
//     } catch (e) {
//       _textController.text = 'Error al encriptar el texto';
//     }
//   }

//   void _desencriptarTexto(String encryptedText, String keySTR) {
//     try {
//       // String keySTR = "1234567890123456"; //16 byte
//       String ivSTR = "1234567890123456";
//       final key = enc.Key.fromUtf8(keySTR + "1234567890");
//       final iv = enc.IV.fromUtf8(ivSTR);
//       // final key = enc.Key.fromLength(32);
//       // final key = enc.Key.fromUtf8('polka123');
//       // final iv = IV.fromLength(16);
//       final encrypter =
//           Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
//       // final encrypter = Encrypter(AES(key));
//       final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
//       _textController.text = decrypted;
//     } catch (e) {
//       _textController.text = 'Error al desencriptar el texto';
//     }
//   }
// }
