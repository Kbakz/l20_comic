import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:l20_comic/models/comic.dart';

const Color appYellow = Color(0xFFFFD600);
const Color appGray = Color(0xFF262934);
const Color appSurface = Color(0xFF0d0e12);
const Color appSurfaceAlt = Color(0xFF191A1E);
const Color appMuted = Color(0xFF4a4a4d);
const Color appDestaque = Color(0xFF39FF14);
const double appBorderWidth = 1.3;

class AppPanel extends StatelessWidget {
  const AppPanel({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color = appSurface,
    this.borderRadius = 16,
    this.borderWidth = appBorderWidth,
    this.border,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double borderRadius;
  final double borderWidth;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ?? Border.all(
          color: appSurfaceAlt,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}

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
          width: 37,
          height: 37,
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
  const Label({
    super.key,
    required this.text,
    required this.color,
    this.colorText = Colors.black,
    this.fontSize = 8,
  });

  final String text;
  final Color color;
  final Color colorText;
  final double fontSize;

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
        style: TextStyle(
          color: colorText,
          fontSize: fontSize,
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
          child: const Icon(Icons.auto_stories, color: appGray, size: 40),
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
    return SizedBox(
      height: 290,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 52,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(
                    text: 'EM DESTAQUE',
                    color: appDestaque,
                    colorText: Color(0xFF153c0d),
                    fontSize: 9,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      comic.title.toUpperCase(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comic.author,
                    style: const TextStyle(color: appYellow, fontSize: 9),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    comic.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 2,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon_book.svg',
                          width: 10,
                          height: 10,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          ' ${comic.pages} páginas',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.schedule, size: 10, color: Colors.white),
                        const SizedBox(width: 3),
                        Text(
                          ' ${comic.minutes} min de leitura',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0),
                  Row(
                    children: [
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: onRead,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appYellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            textStyle: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('LER AGORA '),
                              const SizedBox(width: 5),
                              SvgPicture.asset(
                                'assets/icons/icon_book.svg',
                                width: 15,
                                height: 15,
                                colorFilter: const ColorFilter.mode(
                                  Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Material(
                          color: appGray,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: onDownload,
                            borderRadius: BorderRadius.circular(8),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/icon_download.svg',
                                width: 18,
                                height: 18,
                                colorFilter: const ColorFilter.mode(
                                  appYellow,
                                  BlendMode.srcIn,
                                ),
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
          Expanded(
            flex: 48,
            child: ClipPath(
              clipper: _FeaturedCoverClipper(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CoverImage(url: comic.cover),
                  CustomPaint(painter: _FeaturedCoverEdgePainter()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCoverClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final diagonal = (size.height * .1).clamp(20.0, 32.0);

    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(diagonal, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _FeaturedCoverEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final diagonal = (size.height * .1).clamp(20.0, 32.0);
    final fadeWidth = 28.0;
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          appSurface,
          appSurface,
          appSurface.withValues(alpha: .7),
          appSurface.withValues(alpha: .2),
          Colors.transparent,
        ],
        stops: const [0, .2, .45, .7, 1],
      ).createShader(Rect.fromLTWH(0, 0, fadeWidth, size.height))
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(
      const Offset(0, 0),
      Offset(diagonal, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ContinueCard extends StatelessWidget {
  const ContinueCard({
    super.key,
    required this.comic,
    required this.readPages,
    required this.onTap,
  });

  final Comic comic;
  final int readPages;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final progress = (readPages / comic.pages).clamp(0.0, 1.0);
    final percentage = (progress * 100).round();

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: appSurfaceAlt,
                    color: appYellow,
                    strokeWidth: 3,
                  ),
                ),
                Text(
                  '$percentage%',
                  style: const TextStyle(
                    color: appYellow,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comic.title,
                  style: const TextStyle( fontSize: 11, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 7),
                Text(
                  'Páginas lidas: $readPages de ${comic.pages}',
                  style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 27,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: appGray,
                foregroundColor: appYellow,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                textStyle: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('CONTINUAR'),
            ),
          ),
        ],
    );
  }
}

class ContinueReadingSection extends StatelessWidget {
  const ContinueReadingSection({
    super.key,
    required this.comic,
    required this.readPages,
    required this.onTap,
    this.title = 'Sua última leitura',
  });

  final Comic comic;
  final int readPages;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (readPages <= 0) return const SizedBox.shrink();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.fromLTRB(16, 33, 16, 16),
          decoration: BoxDecoration(
            color: appSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: appSurfaceAlt, width: appBorderWidth),
          ),
          child: ContinueCard(
            comic: comic,
            readPages: readPages,
            onTap: onTap,
          ),
        ),
        Positioned(
          left: 23,
          top: 10,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              border: Border(
                left: BorderSide(color: appSurfaceAlt, width: appBorderWidth),
                right: BorderSide(color: appSurfaceAlt, width: appBorderWidth),
                bottom: BorderSide(color: appSurfaceAlt, width: appBorderWidth),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 3),
            child: Text(
              title,
              style: const TextStyle(
                color: appYellow,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
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
