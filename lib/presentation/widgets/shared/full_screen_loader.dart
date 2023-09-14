import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    final messages = <String>[
      'Cargando peliculas 🎞🖼',
      'Comprando palomitas 🍟🍕',
      'Buscando asientos libres ',
      'Acomodando a los demas',
      'Buscando el control remoto',
    ];
    return Stream.periodic(
      const Duration(milliseconds: 1200),
      (computationCount) {
        return messages[computationCount];
      },
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Estamos cargando los datos'),
        const SizedBox(height: 20),
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        StreamBuilder(
          stream: getLoadingMessage(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Cargando... ✨🧨');

            return Text(snapshot.data.toString());
          },
        )
      ]),
    );
  }
}
