import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';
import 'package:l20_comic/screens/admin_screen.dart';
import 'package:l20_comic/widgets/common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.readingPage,
    required this.onRead,
    required this.audioEnabled,
    required this.onAudioChanged,
  });

  final int readingPage;
  final VoidCallback onRead;
  final bool audioEnabled;
  final ValueChanged<bool> onAudioChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
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
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundColor: appYellow,
                  child: Icon(Icons.person, color: Colors.black, size: 46),
                ),
                const SizedBox(height: 12),
                Text(
                  'Lone',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'lone@l20comics.com',
                  style: TextStyle(color: appMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Meu histórico',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ContinueCard(comic: comics.first, page: readingPage, onTap: onRead),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.settings_outlined, color: appYellow),
            title: Text('Configurações'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(
              Icons.admin_panel_settings_outlined,
              color: appYellow,
            ),
            title: const Text('Área administrativa'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AdminScreen())),
          ),
        ],
      ),
    );
  }
}
