import 'dart:math';
import 'package:flutter/material.dart';

class StickyNote extends StatelessWidget {
  final double height;

  StickyNote(
      {super.key, required this.height, this.color = const Color(-137214)});

  final Color color;
  List<String> frases = [
    'Não se esqueça, você não deve desconfiar de suas metas, avance que você conseguirá!',
    'As pessoas costumam dizer que a motivação não dura sempre. Bem, nem o efeito do banho, por isso recomenda-se diariamente.',
    'A persistência é o caminho do êxito.',
    'No meio da dificuldade encontra-se a oportunidade.',
    'Lute. Acredite. Conquiste. Perca. Deseje. Espere. Alcance. Invada. Caia. Seja tudo o quiser ser, mas, acima de tudo, seja você sempre.',
    'Eu faço da dificuldade a minha motivação. A volta por cima vem na continuação.',
    'A verdadeira motivação vem de realização, desenvolvimento pessoal, satisfação no trabalho e reconhecimento.',
    'Pedras no caminho? Eu guardo todas. Um dia vou construir um castelo.',
    'O insucesso é apenas uma oportunidade para recomeçar com mais inteligência.',
    'Você precisa fazer aquilo que pensa que não é capaz de fazer.',
    'Só se pode alcançar um grande êxito quando nos mantemos fiéis a nós mesmos.'
  ];
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    String frase = frases[_random.nextInt(frases.length)];

    return Transform.rotate(
      angle: 0.0,
      child: CustomPaint(
          painter: StickyNotePainter(color: color),
          child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                frase,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24 * MediaQuery.of(context).textScaleFactor, fontFamily: 'Handlee'),
              ))),
    );
  }
}

class StickyNotePainter extends CustomPainter {
  StickyNotePainter({required this.color});

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawShadow(size, canvas);
    Paint gradientPaint = _createGradientPaint(size);
    _drawNote(size, canvas, gradientPaint);
  }

  void _drawNote(Size size, Canvas canvas, Paint gradientPaint) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    double foldAmount = 0.12;
    path.lineTo(size.width * 3 / 4, size.height);

    path.quadraticBezierTo(size.width * foldAmount * 2, size.height,
        size.width * foldAmount, size.height - (size.height * foldAmount));
    path.quadraticBezierTo(
        0, size.height - (size.height * foldAmount * 1.5), 0, size.height / 4);
    path.lineTo(0, 0);

    canvas.drawPath(path, gradientPaint);
  }

  Paint _createGradientPaint(Size size) {
    Paint paint = Paint();

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    RadialGradient gradient = RadialGradient(
        colors: [brighten(color), color],
        radius: 1.0,
        stops: const [0.5, 1.0],
        center: Alignment.bottomLeft);
    paint.shader = gradient.createShader(rect);
    return paint;
  }

  void _drawShadow(Size size, Canvas canvas) {
    Rect rect = Rect.fromLTWH(12, 12, size.width - 24, size.height - 24);
    Path path = Path();
    path.addRect(rect);
    canvas.drawShadow(path, Colors.black.withOpacity(0.7), 12.0, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

Color brighten(Color c, [int percent = 30]) {
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}
