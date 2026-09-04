import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';
import 'package:l20_comic/widgets/common.dart';

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

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Logo(),
              const Spacer(),
              AudioButton(enabled: audioEnabled, onChanged: onAudioChanged),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 21,
                backgroundColor: appYellow,
                child: Text(
                  'AD',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Text(
            'Bom dia, Lone.',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Text(
            'o que vai ler hoje?',
            style: TextStyle(fontSize: 26, height: 1.1),
          ),
          const SizedBox(height: 24),
          FeaturedCard(comic: featured, onRead: () => onRead(featured)),
          const SizedBox(height: 22),
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
          SectionTitle(title: 'Conheça outras histórias', action: 'VER TUDO'),
          const SizedBox(height: 12),
          SizedBox(
            height: 205,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: comics.length - 1,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (_, index) => ComicMiniCard(
                comic: comics[index + 1],
                onTap: () => onRead(comics[index + 1]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
