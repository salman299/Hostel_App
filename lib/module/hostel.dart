import 'package:flutter/cupertino.dart';


class RoomCategory {
  String? id;
  String bed;
  String isBath;
  String isAC;
  String isFridge;
  double? rent;
  String? description;

  RoomCategory(
      {this.id,
      this.description,
      this.rent,
      this.bed = "1",
      this.isBath = "Yes",
      this.isAC = "Yes",
      this.isFridge = "Yes"});
}

class CommonFacility {
  String? id;
  String? name;
  IconData? icon;
  bool? choosen;
  CommonFacility({this.id, this.name, this.icon, this.choosen});
}


class Hostel {
  String? id;
  String? name;
  String? phone;
  String? whatsApp;
  String? facebookUrl;
  String? address;
  double? latitude;
  double? longitude;
  String? category;
  String? genderCategory;
  bool? isPublished;
  List<String>? images = [];
  List<String?>? facilities = [];
  List<RoomCategory>? roomCategories=[];

  Hostel({
    this.id,
    this.name,
    this.phone,
    this.whatsApp,
    this.facebookUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.category,
    this.facilities,
    this.genderCategory,
    this.images,
    this.isPublished,
    this.roomCategories,
  });

  Hostel hostelCopy(){
    return Hostel(
      id: this.id,
      name: this.name,
      phone: this.phone,
      whatsApp: this.whatsApp,
      facebookUrl: this.facebookUrl,
      address: this.address,
      latitude: this.latitude,
      longitude: this.longitude,
      category: this.category,
      facilities: this.facilities,
      genderCategory: this.genderCategory,
      images: this.images,
      isPublished: this.isPublished,
      roomCategories: this.roomCategories,
    );
  }
}
