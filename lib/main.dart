import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  int readingPage = comics.first.readPages;

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
        fontFamily: 'Poppins',
        splashFactory: InkRipple.splashFactory,
      ),
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              // Mantém todas as telas em memória enquanto alterna entre as abas.
              child: IndexedStack(
                index: tab,
                children: [
                  HomeScreen(
                    audioEnabled: audioEnabled,
                    onAudioChanged: (value) =>
                        setState(() => audioEnabled = value),
                    onRead: openReader,
                    readingPage: readingPage,
                  ),
                  LibraryScreen(
                    onRead: openReader,
                    audioEnabled: audioEnabled,
                    onAudioChanged: (value) =>
                        setState(() => audioEnabled = value),
                  ),
                  ProfileScreen(
                    readingPage: readingPage,
                    onRead: () => openReader(comics.first),
                    audioEnabled: audioEnabled,
                    onAudioChanged: (value) =>
                        setState(() => audioEnabled = value),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 140,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                      ],
                      stops: [0, .58, .86, 1],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 40,
              child: AppPanel(
                color: appSurface,
                borderRadius: 18,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 7,
                ),
                border: Border.all(color: appSurfaceAlt),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 1),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, -4),
                  ),
                ],
                child: Row(
                  children: [
                    Expanded(
                      child: _AnimatedNavigationItem(
                        asset: 'assets/icons/icon_home.svg',
                        label: 'INÍCIO',
                        selected: tab == 0,
                        onTap: () => setState(() => tab = 0),
                      ),
                    ),
                    Expanded(
                      child: _AnimatedNavigationItem(
                        asset: 'assets/icons/icons_newsstand.svg',
                        label: 'LIVRARIA',
                        selected: tab == 1,
                        onTap: () => setState(() => tab = 1),
                      ),
                    ),
                    Expanded(
                      child: _AnimatedNavigationItem(
                        asset: 'assets/icons/icon_person.svg',
                        label: 'PERFIL',
                        selected: tab == 2,
                        onTap: () => setState(() => tab = 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _AnimatedNavigationItem extends StatelessWidget {
  const _AnimatedNavigationItem({
    required this.asset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String asset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 58,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: selected ? 1.5 : 1,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: SvgPicture.asset(
                  asset,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    selected ? appYellow : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              if (!selected)
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
