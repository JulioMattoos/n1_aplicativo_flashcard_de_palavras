import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LanguageSelectionScreen(),
    );
  }
}

// ------------------- TELA DE SELEÇÃO DE IDIOMA -------------------
class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Selecione um Idioma!',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _languageButton(context, 'Inglês'),
                    const SizedBox(height: 15),
                    _languageButton(context, 'Espanhol'),
                    const SizedBox(height: 15),
                    _languageButton(context, 'Francês'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageButton(BuildContext context, String language) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FlashcardScreen(language: language),
            ),
          );
        },
        child: Text(language, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

// ------------------- TELA DE FLASHCARDS -------------------
class FlashcardScreen extends StatefulWidget {
  final String language;

  const FlashcardScreen({super.key, required this.language});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> with SingleTickerProviderStateMixin {
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

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    flashcards[widget.language]?.shuffle();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextCard() {
    if (currentIndex < flashcards[widget.language]!.length - 1) {
      setState(() {
        currentIndex++;
        isRevealed = false;
        _controller.reset();
        _controller.forward();
      });
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        isRevealed = false;
        _controller.reset();
        _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cards = flashcards[widget.language]!;
    final currentCard = cards[currentIndex];

    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _slideAnimation,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: 300,
                            height: 150,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              isRevealed ? currentCard['translation']! : currentCard['word']!,
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.indigo[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(isRevealed ? 'Ocultar Tradução' : 'Revelar Tradução'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: currentIndex > 0 ? previousCard : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Anterior'),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: currentIndex < cards.length - 1 ? nextCard : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Próximo'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
