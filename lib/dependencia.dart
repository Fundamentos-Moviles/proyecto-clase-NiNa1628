import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class Dependencias extends StatefulWidget{
  const Dependencias({super.key});

  @override
  State<Dependencias> createState() => _DependenciasState();
}

final emojiPresets = {
  'notoAnimatedEmojis': notoAnimatedEmojis,
  'classicEmojiPreset': classicEmojiPreset,
  'threeDEmojiPreset': threeDEmojiPreset,
  'handDrawnEmojiPreset': handDrawnEmojiPreset,
};

// PDF
Future<void> main() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}

class _DependenciasState extends State<Dependencias>{
  int? rating;

  final emojiPresets = {
    'notoAnimatedEmojis': notoAnimatedEmojis,
    'classicEmojiPreset': classicEmojiPreset,
    'threeDEmojiPreset': threeDEmojiPreset,
    'handDrawnEmojiPreset': handDrawnEmojiPreset,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Íconos y Emojis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Íconos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              Icon(AntDesign.gitlab_fill),
              Icon(Bootstrap.google),
              Icon(BoxIcons.bxl_apple),
              Icon(Clarity.map_outline_badged),
              Icon(EvaIcons.clipboard),
              Icon(FontAwesome.angular_brand),
              Icon(HeroIcons.printer),
              Icon(Iconsax.cake_bold),
              Icon(IonIcons.bug),
              Icon(LineAwesome.amazon),
              Icon(MingCute.knife_line),
              Icon(OctIcons.code_of_conduct),
              Icon(PixelArtIcons.gif),
              Icon(TeenyIcons.google_play_store),
              Icon(ZondIcons.shield),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: generatePDF,
            child: const Text("Generar PDF"),
          ),
          const SizedBox(height: 30),
          const Text('Retroalimentación con Emojis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...emojiPresets.entries.map((entry) => Column(
            children: [
              Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
              EmojiFeedback(
                initialRating: 3,
                onChangeWaitForAnimation: true,
                emojiPreset: entry.value,
                onChanged: (value) {
                  setState(() => rating = value);
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(SnackBar(content: Text('Valor: $value')));
                },
              )
            ],
          )),
        ],
      ),
    );
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
