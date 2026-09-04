import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';

const Color appYellow = Color(0xFFFFD600);
const Color appSurface = Color(0xFF0d0e12);
const Color appSurfaceAlt = Color(0xFF191A1E);
const Color appMuted = Color(0xFF4a4a4d);
const Color appDestaque = Color(0xFF39FF14);

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 30,
          letterSpacing: -2,
        ),
        children: [
          TextSpan(text: 'L2', style: TextStyle(color: Colors.white)),
          TextSpan(text: 'Q', style: TextStyle(color: appYellow)),
          TextSpan(
            text: '\n  COMICS',
            style: TextStyle(color: appYellow, fontSize: 8, letterSpacing: 3),
          ),
        ],
      ),
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
      label: enabled ? 'Descrição de áudio ativada' : 'Descrição de áudio desativada',
      button: true,
      child: IconButton(
        onPressed: () => onChanged(!enabled),
        tooltip: enabled ? 'Desativar descrição de áudio' : 'Ativar descrição de áudio',
        icon: Icon(
          enabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
          color: enabled ? appYellow : appMuted,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.action,
    this.onTap,
  });

  final String title;
  final String? action;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 10,
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
        loadingBuilder: (_, child, progress) =>
            progress == null
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
  const FeaturedCard({super.key, required this.comic, required this.onRead});

  final Comic comic;
  final VoidCallback onRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: appSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: appSurfaceAlt),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 6, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(text: 'EM DESTAQUE', color: Colors.greenAccent),
                  const SizedBox(height: 16),
                  Text(
                    comic.title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(comic.author, style: const TextStyle(color: appYellow, fontSize: 12)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Text(
                      comic.description,
                      style: const TextStyle(color: appMuted, height: 1.45, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.menu_book_outlined, size: 16, color: appMuted),
                      const SizedBox(width: 5),
                      Text('${comic.pages} páginas', style: const TextStyle(color: appMuted, fontSize: 11)),
                      const SizedBox(width: 12),
                      const Icon(Icons.schedule, size: 16, color: appMuted),
                      const SizedBox(width: 5),
                      Text('${comic.minutes} min', style: const TextStyle(color: appMuted, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: onRead,
                      icon: const Icon(Icons.menu_book, size: 18),
                      label: const Text('LER AGORA'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appYellow,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 4, child: CoverImage(url: comic.cover)),
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
          SizedBox(width: 58, height: 75, child: CoverImage(url: comic.cover, radius: 10)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comic.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 7),
                Text(
                  'Página $page de ${comic.pages}',
                  style: const TextStyle(color: appMuted, fontSize: 12),
                ),
                const SizedBox(height: 8),
                ProgressBar(value: page / comic.pages),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.play_circle_fill, color: appYellow, size: 34),
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
            style: const TextStyle(color: appMuted, fontSize: 10),
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
              style: const TextStyle(color: appMuted, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
