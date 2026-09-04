import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';
import 'package:l20_comic/widgets/common.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({
    super.key,
    required this.comic,
    required this.initialPage,
    required this.audioEnabled,
    required this.onProgress,
  });

  final Comic comic;
  final int initialPage;
  final bool audioEnabled;
  final ValueChanged<int> onProgress;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late int page;
  late bool audio;

  @override
  void initState() {
    super.initState();
    page = widget.initialPage;
    audio = widget.audioEnabled;
  }

  void changePage(int value) {
    setState(() => page = value.clamp(1, widget.comic.pages));
    widget.onProgress(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08090D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.comic.title, style: const TextStyle(fontSize: 15)),
        actions: [
          AudioButton(
            enabled: audio,
            onChanged: (value) => setState(() => audio = value),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                final delta = (details.primaryVelocity ?? 0) < 0 ? 1 : -1;
                changePage(page + delta);
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: Container(
                  key: ValueKey(page),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(color: Colors.black54, blurRadius: 20),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CoverImage(url: widget.comic.cover),
                ),
              ),
            ),
          ),
          Text(
            'Página $page / ${widget.comic.pages}',
            style: const TextStyle(color: appMuted),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            child: Row(
              children: [
                IconButton(
                  onPressed: page > 1 ? () => changePage(page - 1) : null,
                  icon: const Icon(Icons.chevron_left, size: 32),
                ),
                Expanded(child: ProgressBar(value: page / widget.comic.pages)),
                IconButton(
                  onPressed: page < widget.comic.pages
                      ? () => changePage(page + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
