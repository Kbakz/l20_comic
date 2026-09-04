import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';
import 'package:l20_comic/screens/home_screen.dart';
import 'package:l20_comic/screens/library_screen.dart';
import 'package:l20_comic/screens/profile_screen.dart';
import 'package:l20_comic/screens/reader_screen.dart';
import 'package:l20_comic/widgets/common.dart';

void main() => runApp(const L20App());

class L20App extends StatefulWidget {
  const L20App({super.key});

  @override
  State<L20App> createState() => _L20AppState();
}

class _L20AppState extends State<L20App> {
  // Aba ativa do bottom navigation.
  int tab = 0;
  // Controle do áudio acessível em todas as telas.
  bool audioEnabled = true;
  // Última página lida para manter o progresso entre telas.
  int readingPage = 18;

  // Abre a tela do leitor com o estado atual do progresso.
  void openReader(Comic comic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReaderScreen(
          comic: comic,
          initialPage: comic.featured ? readingPage : 1,
          audioEnabled: audioEnabled,
          onProgress: (page) => setState(() => readingPage = page),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'L20 Comics',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appYellow,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
        splashFactory: InkRipple.splashFactory,
      ),
      home: Scaffold(
        body: SafeArea(
          // Mantém todas as telas em memória enquanto alterna entre as abas.
          child: IndexedStack(
            index: tab,
            children: [
              HomeScreen(
                audioEnabled: audioEnabled,
                onAudioChanged: (value) => setState(() => audioEnabled = value),
                onRead: openReader,
                readingPage: readingPage,
              ),
              LibraryScreen(
                onRead: openReader,
                audioEnabled: audioEnabled,
                onAudioChanged: (value) => setState(() => audioEnabled = value),
              ),
              ProfileScreen(
                readingPage: readingPage,
                onRead: () => openReader(comics.first),
                audioEnabled: audioEnabled,
                onAudioChanged: (value) => setState(() => audioEnabled = value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (value) => setState(() => tab = value),
          backgroundColor: appSurface,
          indicatorColor: appYellow.withValues(alpha: .16),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: appYellow),
              label: 'INÍCIO',
            ),
            NavigationDestination(
              icon: Icon(Icons.auto_stories_outlined),
              selectedIcon: Icon(Icons.auto_stories, color: appYellow),
              label: 'LIVRARIA',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: appYellow),
              label: 'PERFIL',
            ),
          ],
        ),
      ),
    );
  }
}
