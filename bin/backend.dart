import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  final server = await shelf_io.serve(
      (request) => Response(200, body: 'OK'), 'localhost', 8080);

  print('Servidor rodando em: http://localhost:8080');
}
