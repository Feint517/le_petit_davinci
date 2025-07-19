import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Color _darkenColor(Color color, double factor) {
  return HSLColor.fromColor(color)
      .withLightness(
        (HSLColor.fromColor(color).lightness - factor).clamp(0.0, 1.0),
      )
      .toColor();
}

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final data = <SectionData>[
    SectionData(
      color: Colors.blue,
      colorOscuro: _darkenColor(Colors.blue, 0.1),
      etapa: 1,
      seccion: 1,
      titulo: 'Preséntate',
    ),
    SectionData(
      color: Colors.orange,
      colorOscuro: _darkenColor(Colors.orange, 0.1),
      etapa: 1,
      seccion: 2,
      titulo: "Usa el tiempo presente",
    ),
    SectionData(
      color: Colors.green,
      colorOscuro: _darkenColor(Colors.green, 0.1),
      etapa: 1,
      seccion: 3,
      titulo: "Saluda y despídete",
    ),
    SectionData(
      color: Colors.purple,
      colorOscuro: _darkenColor(Colors.purple, 0.1),
      etapa: 1,
      seccion: 4,
      titulo: "Habla de comida",
    ),
  ];
  int iCurrentSection = 0;
  final heightFirstBox = 56.0;
  final heightSection = 764.0;
  final scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollCtrl.addListener(scrollListener);
  }

  void scrollListener() {
    final currentScroll = scrollCtrl.position.pixels - heightFirstBox - 24.0;
    int index = (currentScroll / heightSection).floor();

    if (index < 0) index = 0;

    if (index != iCurrentSection) setState(() => iCurrentSection = index);
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/test/italian.svg', width: 26, height: 26),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/test/racha.svg',
                  width: 26,
                  height: 26,
                ),
                const SizedBox(width: 8),
                const Text(
                  '0',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                    fontSize: 16.0,
                    color: Color(0xFF37464F),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/test/diamante.svg',
                  width: 26,
                  height: 26,
                ),
                const SizedBox(width: 8),
                const Text(
                  '1000',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                    fontSize: 16.0,
                    color: Color(0xFF49C0F8),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/test/vidas.svg',
                  width: 26,
                  height: 26,
                ),
                const SizedBox(width: 8.0),
                const Text(
                  '5',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                    fontSize: 16.0,
                    color: Color(0xFFEE5555),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            controller: scrollCtrl,
            itemBuilder:
                (_, i) =>
                    i == 0
                        ? SizedBox(height: heightFirstBox)
                        : Section(data: data[i - 1]),
            separatorBuilder: (_, i) => const SizedBox(height: 24.0),
            padding: const EdgeInsets.only(
              bottom: 24.0,
              left: 16.0,
              right: 16.0,
            ),
            itemCount: data.length + 1,
          ),
          // CurrentSection(data: data[iCurrentSection]),
        ],
      ),
      backgroundColor: const Color(0xFF131F24),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF2D3D41))),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/test/inicio.svg',
                width: 32,
                height: 32,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/test/practica.svg',
                width: 32,
                height: 32,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/test/escudo.svg',
                width: 32,
                height: 32,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/test/cofre.svg',
                width: 32,
                height: 32,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/test/mas.svg',
                width: 32,
                height: 32,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentSection extends StatelessWidget {
  final SectionData data;

  const CurrentSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: data.color,
        borderRadius: BorderRadius.circular(16.0),
        border: Border(bottom: BorderSide(color: data.colorOscuro, width: 4.0)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ETAPA ${data.etapa}, SECCIÓN ${data.seccion}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      data.titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: data.colorOscuro, width: 2.0),
                ),
              ),
              child: SvgPicture.asset(
                'assets/test/leccion.svg',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionData {
  final Color color;
  final Color colorOscuro;
  final int etapa;
  final int seccion;
  final String titulo;

  const SectionData({
    required this.color,
    required this.colorOscuro,
    required this.etapa,
    required this.seccion,
    required this.titulo,
  });
}

class Section extends StatelessWidget {
  final SectionData data;

  const Section({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Color(0xFF2D3D41))),
            const SizedBox(width: 16),
            Text(
              data.titulo,
              style: const TextStyle(
                color: Color(0xFF52656D),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(child: Divider(color: Color(0xFF2D3D41))),
          ],
        ),
        const SizedBox(height: 24.0),
        ...List.generate(
          9,
          (i) =>
              i % 9 != 4
                  ? Container(
                    margin: EdgeInsets.only(
                      bottom: i != 8 ? 24.0 : 0,
                      left: getLeft(i),
                      right: getRight(i),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: data.colorOscuro, width: 6.0),
                      ),
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: data.color,
                        fixedSize: const Size(56, 48),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                      ),
                      child: SvgPicture.asset(
                        'assets/test/estrella.svg',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  )
                  : Container(
                    margin: const EdgeInsets.only(bottom: 24.0),
                    child: SvgPicture.asset(
                      'assets/test/cofre-ruta.svg',
                      width: 72,
                      height: 72,
                    ),
                  ),
        ),
      ],
    );
  }

  double getLeft(int indice) {
    const margin = 72.0;
    int pos = indice % 9;

    if (pos == 1) {
      return margin;
    }
    if (pos == 2) {
      return margin * 2;
    }
    if (pos == 3) {
      return margin;
    }

    return 0.0;
  }

  double getRight(int indice) {
    const margin = 72.0;
    int pos = indice % 9;

    if (pos == 5) {
      return margin;
    }
    if (pos == 6) {
      return margin * 2;
    }
    if (pos == 7) {
      return margin;
    }

    return 0.0;
  }
}
