import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:l20_comic/models/comic.dart';

const Color appYellow = Color(0xFFFFD600);
const Color appGray = Color(0xFF262934);
const Color appSurface = Color(0xFF0d0e12);
const Color appSurfaceAlt = Color(0xFF191A1E);
const Color appMuted = Color(0xFF4a4a4d);
const Color appDestaque = Color(0xFF39FF14);

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo/L20 COMICS SF.png',
      width: 95,
      height: 50,
      fit: BoxFit.contain,
    );
  }
}

class AudioButton extends StatelessWidget {
  const AudioButton({
    super.key,

    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: enabled
          ? 'Descrição de áudio ativada'
          : 'Descrição de áudio desativada',
      button: true,
      child: IconButton(
        onPressed: () => onChanged(!enabled),
        tooltip: enabled
            ? 'Desativar descrição de áudio'
            : 'Ativar descrição de áudio',
        icon: SvgPicture.asset(
          'assets/icons/icon_audioDescription.svg',
          width: 35,
          height: 35,
          colorFilter: ColorFilter.mode(
            enabled ? appYellow : appMuted,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.audioEnabled,
    required this.onAudioChanged,
    required this.greeting,
    required this.name,
    required this.prompt,
  });

  final bool audioEnabled;
  final ValueChanged<bool> onAudioChanged;
  final String greeting;
  final String name;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.fromLTRB(35, 20, 35, 40),
      decoration: BoxDecoration(
        color: appSurface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        border: const Border(
          bottom: BorderSide(color: appSurfaceAlt, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Logo(),
              const Spacer(),
              AudioButton(enabled: audioEnabled, onChanged: onAudioChanged),
            ],
          ),
          const Spacer(),
          Text.rich(
            TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Exo2',
                fontSize: 22,
                height: 1.1,
              ),
              children: [
                TextSpan(text: '$greeting, '),
                TextSpan(
                  text: '$name.',
                  style: const TextStyle(
                    color: appYellow,
                    fontFamily: 'Exo2',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            prompt,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Exo2',
              fontSize: 22,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.action, this.onTap});

  final String title;
  final String? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        if (action != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              action!,
              style: const TextStyle(
                color: appYellow,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class Label extends StatelessWidget {
  const Label({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 8,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: value.clamp(0, 1),
        minHeight: 6,
        backgroundColor: appSurfaceAlt,
        color: appYellow,
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.url, this.radius = 0});

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, _, _) => Container(
          color: appSurfaceAlt,
          child: const Icon(Icons.auto_stories, color: appMuted, size: 40),
        ),
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : Container(
                color: appSurfaceAlt,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: appYellow,
                    strokeWidth: 2,
                  ),
                ),
              ),
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({
    super.key,
    required this.comic,
    required this.onRead,
    this.onDownload,
  });

  final Comic comic;
  final VoidCallback onRead;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 236,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: appSurfaceAlt),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 52,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(text: 'EM DESTAQUE', color: appDestaque),
                  const SizedBox(height: 12),
                  Text(
                    comic.title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comic.author,
                    style: const TextStyle(color: appYellow, fontSize: 9),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      comic.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.35,
                        fontSize: 8.5,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.menu_book_outlined,
                        size: 10,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${comic.pages} páginas',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.schedule, size: 10, color: Colors.white),
                      const SizedBox(width: 3),
                      Text(
                        '${comic.minutes} min de leitura',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        height: 29,
                        child: ElevatedButton.icon(
                          onPressed: onRead,
                          icon: const Icon(Icons.menu_book, size: 13),
                          label: const Text('LER AGORA'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appYellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            textStyle: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 29,
                        height: 29,
                        child: Material(
                          color: appGray,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: onDownload,
                            borderRadius: BorderRadius.circular(8),
                            child: const Center(
                              child: Icon(
                                Icons.download_outlined,
                                color: appYellow,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 48, child: CoverImage(url: comic.cover)),
        ],
      ),
    );
  }
}

class ContinueCard extends StatelessWidget {
  const ContinueCard({
    super.key,
    required this.comic,
    required this.page,
    required this.onTap,
  });

  final Comic comic;
  final int page;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: appSurface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 58,
            height: 75,
            child: CoverImage(url: comic.cover, radius: 10),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comic.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                Text(
                  'Página $page de ${comic.pages}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 8),
                ProgressBar(value: page / comic.pages),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.play_circle_fill,
              color: appYellow,
              size: 34,
            ),
            tooltip: 'Continuar leitura',
          ),
        ],
      ),
    );
  }
}

class ComicTile extends StatelessWidget {
  const ComicTile({super.key, required this.comic, required this.onTap});

  final Comic comic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: CoverImage(url: comic.cover, radius: 16)),
          const SizedBox(height: 8),
          Text(
            comic.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Text(
            '${comic.genre}  •  ${comic.pages} pág.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class ComicMiniCard extends StatelessWidget {
  const ComicMiniCard({super.key, required this.comic, required this.onTap});

  final Comic comic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: CoverImage(url: comic.cover, radius: 12)),
            const SizedBox(height: 7),
            Text(
              comic.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              comic.genre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
