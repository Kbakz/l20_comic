import 'package:flutter_test/flutter_test.dart';
import 'package:l20_comic/main.dart';
import 'package:l20_comic/models/comic.dart';

void main() {
  test('mantém os metadados das HQs de exemplo', () {
    expect(comics, hasLength(4));

    for (final comic in comics) {
      expect(comic.id, isNull);
      expect(comic.url, startsWith('assets/hqs/'));
      expect(comic.url, endsWith('.pdf'));
      expect(comic.lastRead, isNull);
    }
  });

  test('aceita id, url e data da última leitura', () {
    const comic = Comic(
      id: 42,
      title: 'HQ de teste',
      author: 'L20 Comics',
      genre: 'Aventura',
      pages: 10,
      minutes: 3,
      cover: 'assets/cover/teste.png',
      url: 'https://example.com/hq-teste.pdf',
      lastRead: DateTime(2026, 9, 12, 14, 30),
    );

    expect(comic.id, 42);
    expect(comic.url, 'https://example.com/hq-teste.pdf');
    expect(comic.lastRead, DateTime(2026, 9, 12, 14, 30));
  });

  testWidgets('exibe a experiência inicial da L20 Comics', (tester) async {
    await tester.pumpWidget(const L20App());

    expect(find.textContaining('Lone'), findsAtLeastNWidgets(1));
    expect(find.textContaining('LER AGORA'), findsAtLeastNWidgets(1));
    expect(find.textContaining('Conheça outras histórias'), findsOneWidget);
    expect(find.text('Sua última leitura'), findsOneWidget);
    expect(find.text('Páginas lidas: 34 de 60'), findsOneWidget);
  });

  testWidgets('alterna descrição de áudio e navega entre seções', (
    tester,
  ) async {
    await tester.pumpWidget(const L20App());

    expect(find.bySemanticsLabel('Descrição de áudio ativada'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Descrição de áudio ativada'));
    await tester.pump();
    expect(find.bySemanticsLabel('Descrição de áudio desativada'), findsOneWidget);

    await tester.tap(find.text('LIVRARIA'));
    await tester.pump();
    expect(find.text('Livraria'), findsOneWidget);
    expect(find.text('Buscar histórias'), findsOneWidget);

    await tester.tap(find.text('PERFIL'));
    await tester.pump();
    expect(find.text('Meu histórico'), findsOneWidget);
    expect(find.text('Configurações'), findsOneWidget);
  });

  testWidgets('abre o leitor e atualiza o progresso da leitura', (tester) async {
    await tester.pumpWidget(const L20App());

    await tester.tap(find.textContaining('LER AGORA').first);
    await tester.pump();
    expect(find.text('Página 34 / 60'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pump();
    expect(find.text('Página 35 / 60'), findsOneWidget);

    await tester.pageBack();
    await tester.pump();
    expect(find.text('Páginas lidas: 35 de 60'), findsOneWidget);
  });
}
