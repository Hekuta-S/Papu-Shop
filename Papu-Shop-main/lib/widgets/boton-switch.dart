import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/material.dart';

class BotonSwitchNaranja extends StatefulWidget {
  final bool estadoInicial;
  final Function(String) onCambioEstado;

  BotonSwitchNaranja({
    required this.estadoInicial,
    required this.onCambioEstado,
  });

  @override
  _BotonSwitchNaranjaState createState() => _BotonSwitchNaranjaState();
}

class _BotonSwitchNaranjaState extends State<BotonSwitchNaranja> {
  late bool _estado;

  @override
  void initState() {
    super.initState();
    // Inicializa el estado con el valor proporcionado
    _estado = widget.estadoInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿El producto esta en descuento?',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppConstant.appSecondColor),
        ),
        SizedBox(height: 8.0),
        Switch(
          value: _estado,
          onChanged: (bool newValue) {
            setState(() {
              _estado = newValue;
              // Llama a la función de devolución de llamada con el nuevo valor
              widget.onCambioEstado(_estado ? 'true' : 'false');
            });
          },
          activeTrackColor: AppConstant.appSecondColor,
          activeColor: Colors.orangeAccent,
        ),
      ],
    );
  }
}
