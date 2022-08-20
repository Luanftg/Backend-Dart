import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeira rota');
    });

    //http: //localhost:8080/ola/mundo
    router.get('/ola/mundo/<usuario>', (Request request, String usuario) {
      return Response.ok("Ola Mundo $usuario");
    });

    // http://localhost:8080/query?nome=Luan
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      return Response.ok('Query é: $nome',
          headers: {"Content-Type": "text/plain"});
    });

    // http://localhost:8080/tmd/home
    router.get('/tmd/home', (Request req) => Response.ok('''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teatro Marcelo Denny</title>
</head>
<body>
    <h1>Teatro Marcelo Denny</h1>
</body>
</html>
''', headers: {"Content-Type": "text/html"}));

    router.post('/login', (Request req) async {
      String result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];

      if (usuario == 'admin' && senha == '123') {
        return Response.ok('Bem vindo $usuario');
      } else {
        return Response.forbidden('Acesso negado');
      }
    });

    return router;
  }
}
