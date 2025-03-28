import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Participantes',
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gestionar participantes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Añade o elimina personas que participan en los gastos',
                style: TextStyle(
                    fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(), //change
                      decoration: const InputDecoration(
                        labelText: 'Nombre del participante',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // if (_nombreController.text.trim().isNotEmpty) {
                      //   setState(() {
                      //     _participantes.add(_nombreController.text.trim());
                      //     _nombreController.clear();
                      //   });
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Añadir'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Lista de participantes
              // // Expanded(
              //   child: //_participantes.isEmpty
              //       //? 
              //       const Center(
              //           child: Text(
              //             'No hay participantes. Añade algunos para comenzar.',
              //             style: TextStyle(
              //               fontSize: 16,
              //               color: Colors.grey,
              //               fontFamily: 'Poppins',
              //             ),
              //           ),
              //         )
              //       : 
              //       ListView.builder(
              //           itemCount: _participantes.length,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               margin: const EdgeInsets.only(bottom: 8),
              //               child: ListTile(
              //                 title: Text(
              //                   _participantes[index],
              //                   style: const TextStyle(fontFamily: 'Poppins'),
              //                 ),
              //                 trailing: IconButton(
              //                   icon:
              //                       const Icon(Icons.delete, color: Colors.red),
              //                   onPressed: () {
              //                     setState(() {
              //                       _participantes.removeAt(index);
              //                     });
              //                   },
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              // ),

              // Botón para cerrar
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
