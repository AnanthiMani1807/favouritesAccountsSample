import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../domain/account/account_model.dart';
import '../domain/account/favourite_model.dart';

class DropdownValue extends StateNotifier<List<UserDataModel>> {
  DropdownValue() : super([]);

  String userUrl = 'https://reqres.in/api/users?page=2';

  Future<List<UserDataModel>> getUserData() async {
    try {
      final response = await http.get(Uri.parse(userUrl));
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        print('Status Code: ${response.statusCode}');
        final jsonData = json.decode(response.body);
        final users = jsonData['data'] as List<dynamic>;
        return users.map((user) {
          return UserDataModel(
            first_name: user['first_name'],
            last_name: user['last_name'],
            email: user['email'],
            id:user['id'],
            avatar: user['avatar'],
          );
        }).toList();
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  Future<List<FavouriteUserDataModel>> getFavouriteUser() async {
    try {
      final response = await http.get(Uri.parse(userUrl));
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        print('Status Code: ${response.statusCode}');
        final jsonData = json.decode(response.body);
        final users = jsonData['data'] as List<dynamic>;
        return users.map((user) {
          return FavouriteUserDataModel(
            first_name: user['first_name'],
            last_name: user['last_name'],
            avatar: user['avatar'],
          );
        }).toList();
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}

final dropdownValueNotifierProvider = StateNotifierProvider<DropdownValue, List<UserDataModel>>(
      (ref) => DropdownValue(),
);

final accountListFutureProvider = FutureProvider<List<UserDataModel>>((ref) async {
  final dropdownValue = ref.read(dropdownValueNotifierProvider.notifier);
  return dropdownValue.getUserData();
});

final accountCategoryProvider = StateProvider<String>((ref) => 'Account');


final favouriteListFutureProvider =
FutureProvider<List<FavouriteUserDataModel>>((ref) async {
  final dropdownValue = ref.read(dropdownValueNotifierProvider.notifier);
  return dropdownValue.getFavouriteUser();
});
final favouritesCategoryProvider = StateProvider<String>((ref) => 'Favourites');