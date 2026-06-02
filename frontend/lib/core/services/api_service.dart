import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../feature/menu/menu_data.dart';
import '../../models/table_model.dart';

class ApiService {
  static const String _base = 'http://192.168.18.164:3000/api';

  // Dohvati artikle
  static Future<List<FoodItem>> getArtikli() async {
    final res = await http.get(Uri.parse('$_base/artikli'));
    final List data = jsonDecode(res.body);
    return data.map((e) => FoodItem(
      id: e['id_artikl'],
      name: e['naziv'],
      description: e['opis'],
      price: double.parse(e['cijena'].toString()),
      rating: 4.5,
      category: e['kategorija'],
    )).toList();
  }

  // Dohvati stolove
  static Future<List<TableModel>> getStolove() async {
    final res = await http.get(Uri.parse('$_base/stolovi'));
    final List data = jsonDecode(res.body);
    return data.map((e) => TableModel(
      id: e['id_stol'],
      counter: e['broj'],
    )).toList();
  }

  // Pošalji narudžbu
  static Future<bool> posaljiNarudzbu({
  required int idStol,
  required Map<int, int> quantities,
  required List<FoodItem> sviArtikli,
}) async {
  try {
    final stavke = quantities.entries
        .where((e) => e.value > 0)
        .map((e) => {
              'id_artikl': sviArtikli[e.key].id,
              'kolicina': e.value,
            })
        .toList();


    final res = await http.post(
      Uri.parse('$_base/narudzbe'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id_stol': idStol, 'stavke': stavke}),
    );

    return res.statusCode == 200;
  } catch (e) {
    return false;
  }
}
}