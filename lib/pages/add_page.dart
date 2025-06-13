import 'package:flutter/material.dart';
import 'package:myapp/service/database.dart';
import 'package:random_string/random_string.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController apellidomController = TextEditingController();
  TextEditingController apellidopController = TextEditingController();
  TextEditingController cuentaController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  SizedBox(width: 80.0),
                  Text(
                    "Añadir ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Cliente",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              
              // Campo Título
              _buildTextField("Codigo", "Añadir codigo del cliente", codigoController, keyboardType: TextInputType.number),
              
              // Campo Descripción
              _buildTextField("Nombre", "Añadir nombre del cliente", nombreController, maxLines: 3),
              
              // Campo Instructor ID
              _buildTextField("Telefono", "Añadir telefono del cliente", telefonoController, keyboardType: TextInputType.number),
              
              // Campo Precio
              _buildTextField("Direccion", "Añadir direccio del cliente", direccionController, keyboardType: TextInputType.number),
              
              // Campo Categoría
              _buildTextField("Apellido Materno", "Añadir Apellido Materno del cliente", apellidomController),
              _buildTextField("Apellido Paterno", "Añadir Apellido Paterno del cliente", apellidopController),
              _buildTextField("Cuenta", "Añadir Cuenta", cuentaController, keyboardType: TextInputType.number),
              
              // Selector de Fecha
              Row(
                children: [
                  Text(
                    "Fecha: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30.0),
              
              // Botón para agregar curso
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (codigoController.text.isNotEmpty &&
                        nombreController.text.isNotEmpty &&
                        telefonoController.text.isNotEmpty &&
                        direccionController.text.isNotEmpty &&
                        apellidomController.text.isNotEmpty &&
                        apellidopController.text.isNotEmpty &&
                        cuentaController.text.isNotEmpty
                        ) {
                      
                      String addID = randomAlphaNumeric(10);
                      Map<String, dynamic> courseInfoMap = {
                        "codigo": codigoController.text,
                        "nombre": nombreController.text,
                        "telefono": telefonoController.text,
                        "direccion": direccionController.text,
                        "apellidom": apellidomController.text,
                        "apellidop": apellidopController.text,
                        "cuenta": cuentaController.text,
                        "fecha": selectedDate,
                      };
                      
                      await DatabaseMethods()
                          .addCourse(courseInfoMap, addID)
                          .then((value) {
                        // Limpiar campos
                        codigoController.clear();
                        nombreController.clear();
                        telefonoController.clear();
                        direccionController.clear();
                        apellidomController.clear();
                        apellidopController.clear();
                        cuentaController.clear();
                        
                        // Mostrar mensaje de éxito
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Cliente añadido exitosamente",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                        
                        // Regresar a la página anterior
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Añadir Cliente",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, 
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            color: Color(0xFFececf8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
            keyboardType: keyboardType,
            maxLines: maxLines,
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}