import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/screens/add_hostel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../module/hostel.dart';
import 'package:provider/provider.dart';
class Hostels with ChangeNotifier {
  List<Hostel> _myHostel=[
  ];
  List<Hostel> _items=[
    // Hostel(
    //   id: "0",
    //   name: "Bobs Hostel",
    //   whatsApp: "03312821231",
    //   phone: "0999999999",
    //   longitude: 22.4,
    //   latitude: 35.6,
    //   facilities: ["1","5","10","12"],
    //   images: [
    //     "https://i.ibb.co/QFwc1GK/img1.jpg",
    //     "https://i.ibb.co/QFwc1GK/img1.jpg",
    //   ],
    //   isPublished: true,
    //   genderCategory: "Male",
    //   facebookUrl: "https://www.facebook.com/salman.khuwaja",
    //   category: "Private",
    //   address: "Mubarak Colony Hyderabad",
    //   roomCategories: [
    //     RoomCategory(
    //       id: "0",
    //       bed: "1",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 5000,
    //       description: "Hello You looks great",
    //     ),
    //     RoomCategory(
    //       id: "1",
    //       bed: "2",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 6000,
    //       description: "Hello You looks great",
    //     ),
    //     RoomCategory(
    //       id: "3",
    //       bed: "4",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 8000,
    //       description: "Hello You looks great",
    //     ),
    //     RoomCategory(
    //       id: "4",
    //       bed: "1",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 10000,
    //       description: "Hello You looks great",
    //     ),
    //   ],
    // ),
    // Hostel(
    //   id: "0",
    //   name: "Al Karim",
    //   whatsApp: "03312821231",
    //   phone: "0999999999",
    //   longitude: 22.4,
    //   latitude: 35.6,
    //   facilities: ["3","5","11","16","12"],
    //   images: [
    //     "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    //     "https://images.beazer.com/347809a3-364c-4f35-a938-ccf04b6d1ff7-c",
    //   ],
    //   isPublished: true,
    //   genderCategory: "Male",
    //   facebookUrl: "https://www.facebook.com/salman.khuwaja",
    //   category: "Private",
    //   address: "Mubarak Colony Hyderabad",
    //   roomCategories: [
    //     RoomCategory(
    //       id: "0",
    //       bed: "1",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 5000,
    //       description: "Hello You looks great",
    //     ),
    //     RoomCategory(
    //       id: "1",
    //       bed: "2",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 6000,
    //       description: "Hello You looks great",
    //     ),
    //     RoomCategory(
    //       id: "3",
    //       bed: "4",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 8000,
    //       description: "Hello You looks great",
    //     ),
    //     RoomCategory(
    //       id: "4",
    //       bed: "1",
    //       isAC: "Yes",
    //       isFridge: "No",
    //       isBath: "Yes",
    //       rent: 10000,
    //       description: "Hello You looks great",
    //     ),
    //   ],
   // ),
  ];
  //FirebaseStorage _storage = FirebaseStorage.instance;

  get items{
    return [..._items];
  }

  get myHostel{
    return [..._myHostel];
  }

  Map<String, dynamic> encodeHostel(obj){
    return {
      "name": obj.name,
      "whatsApp": obj.whatsApp,
      "address": obj.address,
      "category": obj.category,
      "facebookUrl": obj.facebookUrl,
      "genderCategory": obj.genderCategory,
      "isPublished": obj.isPublished,
      "images": obj.images,
      "facilities": obj.facilities,
      "latitude": obj.latitude,
      "longitude": obj.longitude,
      "phone": obj.phone,
      "roomCategories": obj.roomCategories
          .map((item) =>
      {
        "id": item.id,
        "bed": item.bed,
        "isBath": item.isBath,
        "isAC": item.isAC,
        "isFridge": item.isFridge,
        "rent" : item.rent,
        "description": item.description,
      }).toList(),
    };
  }

  Future<bool> addHostel(Hostel obj) async {
    try{
      final response=await FirebaseFirestore.instance.collection("hostels").add(encodeHostel(obj));
      _myHostel.add(obj);
      notifyListeners();
    }catch(error){
      return false;
    }
    return true;
  }

  Future<bool> updateHostel(index,Hostel obj) async {
    try{
      print("I ama in update mode");
      final response=await FirebaseFirestore.instance.collection("hostels").doc(obj.id).update(encodeHostel(obj));
      _myHostel[index]=obj;
      notifyListeners();
    }catch(error){
      return false;
    }
    return true;
  }

  Future<void> fetchMyHostel() async{
    try{
      final response=await FirebaseFirestore.instance.collection("hostels").get();
      List<Hostel> localHostel=[];
      response.docs.forEach((hostelData) {
        localHostel.add(
          Hostel(
           id: hostelData.id,
           name: hostelData.get("name"),
           address: hostelData.get("address"),
           category: hostelData.get("category"),
           facebookUrl: hostelData.get("facebookUrl"),
           genderCategory: hostelData.get("genderCategory"),
           isPublished: hostelData.get("isPublished"),
           images: List<String>.from(hostelData.get("images")),
            facilities: List<String>.from(hostelData.get("facilities")),
            latitude: hostelData.get("latitude"),
            longitude: hostelData.get("longitude"),
            phone: hostelData.get("phone"),
            whatsApp: hostelData.get('whatsApp'),
            roomCategories: List<Map<String,dynamic>>.from(hostelData.get("roomCategories")).map((roomData) {
              print(roomData["rent"].runtimeType);
              return RoomCategory(
                id: roomData["id"].toString(),
                bed: roomData["bed"].toString(),
                description: roomData["description"].toString(),
                rent: roomData["rent"] as double,
                isBath: roomData["isBath"].toString(),
                isFridge: roomData["isFridge"].toString(),
                isAC: roomData["isAC"].toString(),
              );
            }
            ).toList(),
          ),
        );
       }
       );
      _myHostel=localHostel;
      notifyListeners();
    }catch(error){
        throw(error);
    }
  }
  Future<void> fetchAllHostel() async{
    try{
      final response=await FirebaseFirestore.instance.collection("hostels").get();
      List<Hostel> localHostel=[];
      response.docs.forEach((hostelData) {
        localHostel.add(
          Hostel(
            id: hostelData.id,
            name: hostelData.get("name"),
            address: hostelData.get("address"),
            category: hostelData.get("category"),
            facebookUrl: hostelData.get("facebookUrl"),
            genderCategory: hostelData.get("genderCategory"),
            isPublished: hostelData.get("isPublished"),
            images: List<String>.from(hostelData.get("images")),
            facilities: List<String>.from(hostelData.get("facilities")),
            latitude: hostelData.get("latitude"),
            longitude: hostelData.get("longitude"),
            phone: hostelData.get("phone"),
            whatsApp: hostelData.get('whatsApp'),
            roomCategories: List<Map<String,dynamic>>.from(hostelData.get("roomCategories")).map((roomData) {
              print(roomData["rent"].runtimeType);
              return RoomCategory(
                id: roomData["id"].toString(),
                bed: roomData["bed"].toString(),
                description: roomData["description"].toString(),
                rent: roomData["rent"] as double,
                isBath: roomData["isBath"].toString(),
                isFridge: roomData["isFridge"].toString(),
                isAC: roomData["isAC"].toString(),
              );
            }
            ).toList(),
          ),
        );
      }
      );
      _items=localHostel;
      notifyListeners();
    }catch(error){
      throw(error);
    }
  }
}