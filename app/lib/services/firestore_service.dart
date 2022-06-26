import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference countries = FirebaseFirestore.instance.collection('countries');

  Future<QuerySnapshot<Object?>> getCountries() {
    return countries.orderBy('name').get();
  }

  Future<QuerySnapshot<Object?>> getCities(String countryId) {
    return countries.doc(countryId).collection('cities').orderBy('name').get();
  }
}
