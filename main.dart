import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione um Idioma'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecione um idioma para começar!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlashcardScreen(language: 'Inglês'),
                  ),
                );
              },
              child: const Text('Inglês'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlashcardScreen(language: 'Espanhol'),
                  ),
                );
              },
              child: const Text('Espanhol'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlashcardScreen(language: 'Francês'),
                  ),
                );
              },
              child: const Text('Francês'),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  final String language;

  const FlashcardScreen({super.key, required this.language});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final Map<String, List<Map<String, String>>> flashcards = {
    'Inglês': [
      {'word': 'Hello', 'translation': 'Olá'},
      {'word': 'Goodbye', 'translation': 'Adeus'},
      {'word': 'Apple', 'translation': 'Maçã'},
      {'word': 'Water', 'translation': 'Água'},
      {'word': 'Book', 'translation': 'Livro'},
      {'word': 'House', 'translation': 'Casa'},
      {'word': 'Sun', 'translation': 'Sol'},
      {'word': 'Moon', 'translation': 'Lua'},
      {'word': 'Cat', 'translation': 'Gato'},
      {'word': 'Dog', 'translation': 'Cachorro'},
    ],
    'Espanhol': [
      {'word': 'Hola', 'translation': 'Olá'},
      {'word': 'Adiós', 'translation': 'Adeus'},
      {'word': 'Manzana', 'translation': 'Maçã'},
      {'word': 'Agua', 'translation': 'Água'},
      {'word': 'Libro', 'translation': 'Livro'},
      {'word': 'Casa', 'translation': 'Casa'},
      {'word': 'Sol', 'translation': 'Sol'},
      {'word': 'Luna', 'translation': 'Lua'},
      {'word': 'Gato', 'translation': 'Gato'},
      {'word': 'Perro', 'translation': 'Cachorro'},
    ],
    'Francês': [
      {'word': 'Bonjour', 'translation': 'Olá'},
      {'word': 'Au revoir', 'translation': 'Adeus'},
      {'word': 'Pomme', 'translation': 'Maçã'},
      {'word': 'Eau', 'translation': 'Água'},
      {'word': 'Livre', 'translation': 'Livro'},
      {'word': 'Maison', 'translation': 'Casa'},
      {'word': 'Soleil', 'translation': 'Sol'},
      {'word': 'Lune', 'translation': 'Lua'},
      {'word': 'Chat', 'translation': 'Gato'},
      {'word': 'Chien', 'translation': 'Cachorro'},
    ],
  };

  int currentIndex = 0;
  bool isRevealed = false;

  @override
  void initState() {
    super.initState();
    flashcards[widget.language]!.shuffle(); // 🔹 embaralhar as cartas
  }

  @override
  Widget build(BuildContext context) {
    final cards = flashcards[widget.language]!;
    final currentCard = cards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards em ${widget.language}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const LanguageSelectionScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  isRevealed ? currentCard['translation']! : currentCard['word']!,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRevealed = !isRevealed;
                });
              },
              child: Text(isRevealed ? 'Ocultar Tradução' : 'Revelar Tradução'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: currentIndex > 0
                      ? () {
                          setState(() {
                            currentIndex--;
                            isRevealed = false;
                          });
                        }
                      : null,
                  child: const Text('Anterior'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: currentIndex < cards.length - 1
                      ? () {
                          setState(() {
                            currentIndex++;
                            isRevealed = false;
                          });
                        }
                      : null,
                  child: const Text('Próximo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
