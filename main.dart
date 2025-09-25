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

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F51B5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Select a language',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _languageButton(context, 'Ingles'),
                    const SizedBox(height: 25),
                    _languageButton(context, 'Frances'),
                    const SizedBox(height: 25),
                    _languageButton(context, 'Portugues'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageButton(BuildContext context, String language) {
    return SizedBox(
      width: 250,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD3D3D3),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () {
          if (language == 'Portugues') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NativeLanguageScreen(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FlashcardScreen(language: language),
              ),
            );
          }
        },
        child: Text(
          language,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class NativeLanguageScreen extends StatelessWidget {
  const NativeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F51B5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'What is your native language?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _nativeLanguageButton(context, 'Ingles'),
                const SizedBox(height: 20),
                _nativeLanguageButton(context, 'Frances'),
                const SizedBox(height: 20),
                _nativeLanguageButton(context, 'Alemao'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nativeLanguageButton(BuildContext context, String nativeLanguage) {
    return SizedBox(
      width: 220,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD3D3D3),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FlashcardScreen(language: 'Portugues', nativeLanguage: nativeLanguage),
            ),
          );
        },
        child: Text(
          nativeLanguage,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  final String language;
  final String? nativeLanguage;

  const FlashcardScreen({
    super.key,
    required this.language,
    this.nativeLanguage,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> with SingleTickerProviderStateMixin {
  final Map<String, List<Map<String, String>>> flashcards = {
    'Ingles': [
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
    'Frances': [
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
    'Portugues': [
      {'word': 'Olá', 'translation': ''},
      {'word': 'Adeus', 'translation': ''},
      {'word': 'Maçã', 'translation': ''},
      {'word': 'Água', 'translation': ''},
      {'word': 'Livro', 'translation': ''},
      {'word': 'Casa', 'translation': ''},
      {'word': 'Sol', 'translation': ''},
      {'word': 'Lua', 'translation': ''},
      {'word': 'Gato', 'translation': ''},
      {'word': 'Cachorro', 'translation': ''},
    ],
  };

  final Map<String, Map<String, String>> translations = {
    'Olá': {
      'Ingles': 'Hello',
      'Frances': 'Bonjour',
      'Alemao': 'Hallo',
    },
    'Adeus': {
      'Ingles': 'Goodbye',
      'Frances': 'Au revoir',
      'Alemao': 'Auf Wiedersehen',
    },
    'Maçã': {
      'Ingles': 'Apple',
      'Frances': 'Pomme',
      'Alemao': 'Apfel',
    },
    'Água': {
      'Ingles': 'Water',
      'Frances': 'Eau',
      'Alemao': 'Wasser',
    },
    'Livro': {
      'Ingles': 'Book',
      'Frances': 'Livre',
      'Alemao': 'Buch',
    },
    'Casa': {
      'Ingles': 'House',
      'Frances': 'Maison',
      'Alemao': 'Haus',
    },
    'Sol': {
      'Ingles': 'Sun',
      'Frances': 'Soleil',
      'Alemao': 'Sonne',
    },
    'Lua': {
      'Ingles': 'Moon',
      'Frances': 'Lune',
      'Alemao': 'Mond',
    },
    'Gato': {
      'Ingles': 'Cat',
      'Frances': 'Chat',
      'Alemao': 'Katze',
    },
    'Cachorro': {
      'Ingles': 'Dog',
      'Frances': 'Chien',
      'Alemao': 'Hund',
    },
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

  Map<String, String> getButtonTexts() {
    if (widget.language == 'Portugues') {
      if (widget.nativeLanguage == 'Alemao') {
        return {
          'reveal': 'Übersetzung aufdecken',
          'previous': 'Vorherige',
          'next': 'Nächste',
        };
      } else if (widget.nativeLanguage == 'Frances') {
        return {
          'reveal': 'Révéler la traduction',
          'previous': 'Précédent',
          'next': 'Suivant',
        };
      } else {
        return {
          'reveal': 'Reveal translation',
          'previous': 'Previous',
          'next': 'Next',
        };
      }
    } else {
      return {
        'reveal': 'Revelar tradução',
        'previous': 'Anterior',
        'next': 'Próximo',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final cards = flashcards[widget.language]!;
    final currentCard = cards[currentIndex];
    final buttonTexts = getButtonTexts();

    String? currentTranslation;
    if (widget.language == 'Portugues' && widget.nativeLanguage != null) {
      currentTranslation = translations[currentCard['word']]?[widget.nativeLanguage!];
    } else {
      currentTranslation = currentCard['translation']!;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF3F51B5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Flashcards em ${widget.language}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (widget.language == 'Portugues') {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionScreen(),
                ),
                (route) => false,
              );
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    border: InputBorder.none,
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
                          color: const Color(0xFFD3D3D3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: 300,
                            height: 150,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              isRevealed ? currentTranslation! : currentCard['word']!,
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
                          backgroundColor: const Color(0xFFD3D3D3),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: Text(
                          isRevealed ? buttonTexts['reveal']! : buttonTexts['reveal']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: currentIndex > 0 ? previousCard : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD3D3D3),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            ),
                            child: Text(buttonTexts['previous']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: currentIndex < cards.length - 1 ? nextCard : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD3D3D3),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            ),
                            child: Text(buttonTexts['next']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
