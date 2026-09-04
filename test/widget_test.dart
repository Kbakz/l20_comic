import 'package:flutter_test/flutter_test.dart';
import 'package:l20_comic/main.dart';

void main() {
  testWidgets('exibe a experiência inicial da L20 Comics', (tester) async {
    await tester.pumpWidget(const L20App());
    expect(find.text('Bom dia, Lone.'), findsOneWidget);
    expect(find.text('LER AGORA'), findsOneWidget);
    expect(find.text('LIVRARIA'), findsOneWidget);
  });
}
