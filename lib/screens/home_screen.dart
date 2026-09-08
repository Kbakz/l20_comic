import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';
import 'package:l20_comic/widgets/common.dart';

class _GreetingCopy {
  const _GreetingCopy({required this.greeting, required this.prompt});

  final String greeting;
  final String prompt;
}

const _greetingCopies = [
  _GreetingCopy(greeting: 'Bom dia', prompt: 'o que vai ler hoje?'),
  _GreetingCopy(greeting: 'Boa tarde', prompt: 'qual história vai descobrir?'),
  _GreetingCopy(greeting: 'Boa noite', prompt: 'qual aventura vai começar?'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.audioEnabled,
    required this.onAudioChanged,
    required this.onRead,
    required this.readingPage,
  });

  final bool audioEnabled;
  final ValueChanged<bool> onAudioChanged;
  final ValueChanged<Comic> onRead;
  final int readingPage;

  @override
  Widget build(BuildContext context) {
    final featured = comics.first;
    final greeting =
        _greetingCopies[DateTime.now().day % _greetingCopies.length];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
            audioEnabled: audioEnabled,
            onAudioChanged: onAudioChanged,
            greeting: greeting.greeting,
            name: 'Lone',
            prompt: greeting.prompt,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppPanel(
              child: FeaturedCard(
                comic: featured,
                onRead: () => onRead(featured),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppPanel(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (readingPage > 1) ...[
                    SectionTitle(
                      title: 'Continue lendo',
                      action: 'ABRIR',
                      onTap: () => onRead(featured),
                    ),
                    ContinueCard(
                      comic: featured,
                      page: readingPage,
                      onTap: () => onRead(featured),
                    ),
                    const SizedBox(height: 24),
                  ],
                  SectionTitle(
                    title: 'Conheça outras histórias',
                    action: 'VER TUDO',
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 205,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: comics.length - 1,
                      separatorBuilder: (_, _) => const SizedBox(width: 14),
                      itemBuilder: (_, index) => ComicMiniCard(
                        comic: comics[index + 1],
                        onTap: () => onRead(comics[index + 1]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
