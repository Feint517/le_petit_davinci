class ShapesSVG {
  // Circle SVG
  static const String circle = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="40" cy="40" r="35" fill="#FF6B6B" stroke="#FF4757" stroke-width="3"/>
</svg>
  ''';

  // Square SVG
  static const String square = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="5" y="5" width="70" height="70" fill="#4ECDC4" stroke="#26A085" stroke-width="3"/>
</svg>
  ''';

  // Triangle SVG
  static const String triangle = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M40 10 L70 65 L10 65 Z" fill="#45B7D1" stroke="#2980B9" stroke-width="3"/>
</svg>
  ''';

  // Rectangle SVG
  static const String rectangle = '''
<svg width="100" height="60" viewBox="0 0 100 60" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="5" y="5" width="90" height="50" fill="#96CEB4" stroke="#6AB187" stroke-width="3"/>
</svg>
  ''';

  // Pentagon SVG
  static const String pentagon = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M40 8 L70 28 L58 60 L22 60 L10 28 Z" fill="#F7DC6F" stroke="#F4D03F" stroke-width="3"/>
</svg>
  ''';

  // Hexagon SVG
  static const String hexagon = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M40 5 L65 22.5 L65 57.5 L40 75 L15 57.5 L15 22.5 Z" fill="#BB8FCE" stroke="#8E44AD" stroke-width="3"/>
</svg>
  ''';

  // Star SVG
  static const String star = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M40 8 L47 30 L70 30 L52 45 L59 67 L40 52 L21 67 L28 45 L10 30 L33 30 Z" fill="#F8C471" stroke="#E67E22" stroke-width="2"/>
</svg>
  ''';

  // Heart SVG
  static const String heart = '''
<svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M40 70 C40 70 10 50 10 30 C10 20 20 10 30 10 C35 10 40 15 40 15 C40 15 45 10 50 10 C60 10 70 20 70 30 C70 50 40 70 40 70 Z" fill="#EC7063" stroke="#E74C3C" stroke-width="3"/>
</svg>
  ''';
}

class ShapeData {
  final String name;
  final String svgString;
  final String frenchName;

  const ShapeData({
    required this.name,
    required this.svgString,
    required this.frenchName,
  });

  static const List<ShapeData> allShapes = [
    ShapeData(
      name: 'Circle',
      svgString: ShapesSVG.circle,
      frenchName: 'Cercle',
    ),
    ShapeData(name: 'Square', svgString: ShapesSVG.square, frenchName: 'Carré'),
    ShapeData(
      name: 'Triangle',
      svgString: ShapesSVG.triangle,
      frenchName: 'Triangle',
    ),
    ShapeData(
      name: 'Rectangle',
      svgString: ShapesSVG.rectangle,
      frenchName: 'Rectangle',
    ),
    ShapeData(
      name: 'Pentagon',
      svgString: ShapesSVG.pentagon,
      frenchName: 'Pentagone',
    ),
    ShapeData(
      name: 'Hexagon',
      svgString: ShapesSVG.hexagon,
      frenchName: 'Hexagone',
    ),
    ShapeData(name: 'Star', svgString: ShapesSVG.star, frenchName: 'Étoile'),
    ShapeData(name: 'Heart', svgString: ShapesSVG.heart, frenchName: 'Cœur'),
  ];
}
