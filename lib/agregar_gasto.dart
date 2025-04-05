import 'package:flutter/material.dart';

class AgregarGastoScreen extends StatefulWidget {
  const AgregarGastoScreen({super.key});

  @override
  State<AgregarGastoScreen> createState() => _AgregarGastoScreenState();
}

class _AgregarGastoScreenState extends State<AgregarGastoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  final _montoController = TextEditingController();
  final _tituloController = TextEditingController();
  String _tipoGasto = 'individual';
  String _pagadoPor = 'Tú';
  final List<String> _participantes = ['Tú', 'Kiki', 'Oddie', 'O\'Brien'];
  List<bool> _seleccionados = [true, false, false, false];
  bool _gastoDividido = true;
  String _selectedPersona = 'Kiki';
  String _selectedGrupo = 'Escuela';

  @override
  void dispose() {
    _descripcionController.dispose();
    _montoController.dispose();
    _tituloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deuda ${_tipoGasto == 'individual' ? 'individual' : 'grupal'}',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selector de tipo de deuda
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Deudas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          FilterChip(
                            label: const Text('Individual'),
                            selected: _tipoGasto == 'individual',
                            onSelected: (bool selected) {
                              setState(() {
                                _tipoGasto = 'individual';
                              });
                            },
                            selectedColor: Colors.green.withOpacity(0.2),
                            checkmarkColor: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            label: const Text('Grupal'),
                            selected: _tipoGasto == 'grupal',
                            onSelected: (bool selected) {
                              setState(() {
                                _tipoGasto = 'grupal';
                              });
                            },
                            selectedColor: Colors.green.withOpacity(0.2),
                            checkmarkColor: Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Campos específicos según el tipo de gasto
                      if (_tipoGasto == 'individual') ...[
                        // Selector de persona
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Persona',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedPersona,
                          items:
                              ['Kiki', 'Oddie', 'O\'Brien'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPersona = newValue!;
                            });
                          },
                        ),
                      ] else ...[
                        // Selector de grupo
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Grupo',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedGrupo,
                          items: ['Escuela', 'Amigos', 'Familia']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGrupo = newValue!;
                            });
                          },
                        ),
                      ],
                      const SizedBox(height: 16),

                      // Título
                      TextFormField(
                        controller: _tituloController,
                        decoration: const InputDecoration(
                          labelText: 'Título',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un título';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Monto
                      TextFormField(
                        controller: _montoController,
                        decoration: const InputDecoration(
                          labelText: 'Monto',
                          border: OutlineInputBorder(),
                          prefixText: '\$',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un monto';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Por favor ingresa un monto válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      if (_tipoGasto == 'individual') ...[
                        // Gasto dividido
                        const Text('Gasto dividido?'),
                        Row(
                          children: [
                            FilterChip(
                              label: const Text('Sí'),
                              selected: _gastoDividido,
                              onSelected: (bool selected) {
                                setState(() {
                                  _gastoDividido = true;
                                });
                              },
                              selectedColor: Colors.green.withOpacity(0.2),
                              checkmarkColor: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            FilterChip(
                              label: const Text('No'),
                              selected: !_gastoDividido,
                              onSelected: (bool selected) {
                                setState(() {
                                  _gastoDividido = false;
                                });
                              },
                              selectedColor: Colors.green.withOpacity(0.2),
                              checkmarkColor: Colors.green,
                            ),
                          ],
                        ),
                      ] else ...[
                        // Monto divisible entre
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Monto divisible entre',
                            border: OutlineInputBorder(),
                          ),
                          value: 'Todos',
                          items: ['Todos', 'Algunos'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue == 'Todos') {
                                _seleccionados = List.generate(
                                    _participantes.length, (index) => true);
                              } else {
                                _seleccionados = List.generate(
                                    _participantes.length, (index) => false);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        // Lista de participantes con casillas (solo visible cuando se selecciona "Algunos")
                        if (_seleccionados.contains(false)) ...[
                          const Text(
                            'Selecciona los participantes:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _participantes.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(_participantes[index]),
                                value: _seleccionados[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _seleccionados[index] = value!;
                                  });
                                },
                                activeColor: Colors.green,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              );
                            },
                          ),
                        ],
                      ],
                      const SizedBox(height: 16),
                      //////
                      if (_tipoGasto == 'individual') ...[
                        // Gasto realizado por (solo muestra la persona seleccionada o "Tú")
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Gasto realizado por',
                            border: OutlineInputBorder(),
                          ),
                          value: _pagadoPor,
                          items: ['Tú', _selectedPersona].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _pagadoPor = newValue!;
                            });
                          },
                        ),
                      ] else ...[
                        // Gasto realizado por (muestra todos los participantes del grupo)
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Gasto realizado por',
                            border: OutlineInputBorder(),
                          ),
                          value: _pagadoPor,
                          items: _participantes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _pagadoPor = newValue!;
                            });
                          },
                        ),
                      ],
                      ///////
                      const SizedBox(height: 16),

                      // Fecha
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Text(
                              '29/03/2025',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Descripción
                      TextFormField(
                        controller: _descripcionController,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa una descripción';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _guardarGasto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Gasto añadido correctamente'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          // Limpiar los campos
                          _tituloController.clear();
                          _montoController.clear();
                          _descripcionController.clear();
                          setState(() {
                            _pagadoPor = 'Tú';
                            if (_tipoGasto == 'individual') {
                              _selectedPersona = 'Kiki';
                            } else {
                              _seleccionados = List.generate(
                                  _participantes.length, (index) => true);
                            }
                          });
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardarGasto() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica para guardar el gasto
      Navigator.pop(context);
    }
  }
}
