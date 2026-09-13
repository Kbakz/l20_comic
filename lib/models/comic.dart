// Modelo base para cada história exibida no app.
class Comic {
  const Comic({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.pages,
    required this.minutes,
    required this.cover,
    this.url = '',
    this.description = '',
    this.featured = false,
    this.readPages = 0,
    this.lastRead,
  });

  final int? id;
  final String title;
  final String author;
  final String genre;
  final int pages;
  final int minutes;
  final String cover;
  final String url;
  final String description;
  final bool featured;
  final int readPages;
  final DateTime? lastRead;
}

// Catálogo inicial usado pela home, livraria e perfil.
const comics = [
  Comic(
    title: 'Páginas do Tempo:\nCrônicas da liberdade',
    author: 'Estalone Lima',
    genre: 'História • Aventura',
    pages: 60,
    minutes: 10,
    featured: true,
    readPages: 34,
    url: 'assets/hqs/paginas_do_tempo_cronicas_da_liberdade.pdf',
    description: 'Acompanhe Bento, um baiano capaz de “viajar no tempo” através das próprias lembranças. Entre momentos marcados por luta, resistência e esperança.',
    cover: 'https://images.unsplash.com/photo-1612036782180-6f0b6cd846fe?w=900&q=85',
  ),
  Comic(
    title: 'Baixa Grande',
    author: 'Coletivo L20',
    genre: 'Cultura • Brasil',
    pages: 42,
    minutes: 8,
    url: 'assets/hqs/baixa_grande.pdf',
    cover: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=700&q=85',
  ),
  Comic(
    title: 'Além do Horizonte',
    author: 'L20 Comics',
    genre: 'Ficção • Aventura',
    pages: 84,
    minutes: 15,
    url: 'assets/hqs/alem_do_horizonte.pdf',
    cover: 'https://images.unsplash.com/photo-1618519764620-7403abdbdfe9?w=700&q=85',
  ),
  Comic(
    title: 'Cidade Neon',
    author: 'Maya Costa',
    genre: 'Ficção científica',
    pages: 36,
    minutes: 7,
    url: 'assets/hqs/cidade_neon.pdf',
    cover: 'https://images.unsplash.com/photo-1608889825103-eb5ed706fc64?w=700&q=85',
  ),
];
