import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Añadir nuevo cliente
  Future addCourse(Map<String, dynamic> courseInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("clientes")
        .doc(id)
        .set(courseInfoMap);
  }

  // Obtener todos los cliente
  Stream<QuerySnapshot> getCoursesDetails() {
    return FirebaseFirestore.instance.collection("clientes").snapshots();
  }

  // Eliminar cliente
  deleteCourseData(String id) async {
    return await FirebaseFirestore.instance
        .collection("clientes")
        .doc(id)
        .delete();
  }

  // Actualizar cliente
  updateCourseData(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("clientes")
        .doc(id)
        .update(updateInfo);
  }
}