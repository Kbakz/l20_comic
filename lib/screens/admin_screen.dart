import 'package:flutter/material.dart';
import 'package:l20_comic/models/comic.dart';
import 'package:l20_comic/widgets/common.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área administrativa')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Gerenciar HQs',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Cadastre e organize o catálogo da L20 Comics.',
            style: TextStyle(color: appMuted),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () => _showComicForm(context),
            icon: const Icon(Icons.add),
            label: const Text('CADASTRAR NOVA HQ'),
            style: FilledButton.styleFrom(
              backgroundColor: appYellow,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 20),
          ...comics.map(
            (comic) => Card(
              color: appSurface,
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: SizedBox(
                  width: 42,
                  child: CoverImage(url: comic.cover, radius: 6),
                ),
                title: Text(comic.title),
                subtitle: Text(
                  '${comic.pages} páginas • ${comic.genre}',
                  style: const TextStyle(color: appMuted, fontSize: 11),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') _showComicForm(context, comic: comic);
                    if (value == 'delete') _confirmDelete(context, comic.title);
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar HQ')),
                    PopupMenuItem(value: 'delete', child: Text('Excluir HQ')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showComicForm(BuildContext context, {Comic? comic}) {
    final title = TextEditingController(text: comic?.title);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: appSurface,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              comic == null ? 'Cadastrar HQ' : 'Editar HQ',
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados salvos com sucesso.')),
                );
              },
              child: const Text('SALVAR'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String title) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir HQ?'),
        content: Text('“$title” será removida do catálogo.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('HQ excluída.')));
            },
            child: const Text('EXCLUIR'),
          ),
        ],
      ),
    );
  }
}
