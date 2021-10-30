import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../module/hostel.dart';
import '../custom_icons_icons.dart';
class MyFacilities with ChangeNotifier {
  static List<CommonFacility> _items = [
    CommonFacility(
        id: "0", name: "Wifi", icon: CustomIcons.wifi, choosen: false),
    CommonFacility(id: "1", name: "LCD", icon: CustomIcons.lcd, choosen: false),
    CommonFacility(
        id: "2",
        name: "Water Filter",
        icon: CustomIcons.water_filter1,
        choosen: false),
    CommonFacility(
        id: "3",
        name: "Air Conditioner",
        icon: CustomIcons.air_conditioner,
        choosen: false),
    CommonFacility(
        id: "4", name: "Mosque", icon: CustomIcons.mosque, choosen: false),
    CommonFacility(
        id: "5",
        name: "Generator/UPS",
        icon: CustomIcons.renewable_energy,
        choosen: false),
    CommonFacility(
        id: "6", name: "Fridge", icon: CustomIcons.fridge, choosen: false),
    CommonFacility(
        id: "7", name: "Food", icon: CustomIcons.food, choosen: false),
    CommonFacility(
        id: "8", name: "Heater", icon: CustomIcons.heater, choosen: false),
    CommonFacility(
        id: "9", name: "Cooler", icon: CustomIcons.cooler, choosen: false),
    CommonFacility(
        id: "10", name: "Carpet", icon: CustomIcons.carpet, choosen: false),
    CommonFacility(
        id: "11", name: "Shower", icon: CustomIcons.shower, choosen: false),
    CommonFacility(
        id: "12", name: "Parking", icon: CustomIcons.parking, choosen: false),
    CommonFacility(
        id: "13",
        name: "Study Table",
        icon: CustomIcons.work_table,
        choosen: false),
    CommonFacility(
        id: "14", name: "TV/LED", icon: CustomIcons.tv, choosen: false),
    CommonFacility(
        id: "15", name: "Kitchen", icon: CustomIcons.kitchen, choosen: false),
    CommonFacility(
        id: "16", name: "Bed", icon: CustomIcons.slumber, choosen: false),
  ];
  List<bool> chooseItems = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  void clear(){
    chooseItems = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
  }
  void addItemList(List<String?> ids) {
    clear();
    ids.forEach((element) {
      chooseItems[int.parse(element!)]=true;
    });
  }
  void addItems(String id) {
    chooseItems[int.parse(id)] = !chooseItems[int.parse(id)];
    notifyListeners();
  }
  List<CommonFacility> chooseListById(ids) {
    List<CommonFacility> myList = [];
    ids.forEach((element) {
      myList.add(_items[int.parse(element)]);
    });
    return myList;
  }

  List<CommonFacility> chooseList() {
    List<CommonFacility> myList = [];
    _items.forEach((element) {
      if (chooseItems[int.parse(element.id!)])
        myList.add(element);
    });
    return myList;
  }

  List<String?> selectedItems(){
    List<String?> ids=[];
    for(int i=0;i<_items.length;i++){
      if(chooseItems[i])
        ids.add(_items[i].id);
    }
    return ids;
  }
  get items {
    return [..._items];
  }

  List<String?> get getNames {
    List<String?> names=[];
    _items.forEach((element) {
      names.add(element.name);
    });
    return names;
  }
  Future<List<CommonFacility>> getBuyName(String search) async {
    final itemId = [];
    search = search.toLowerCase();
    for (int i = 0; i < items.length; i++) {
      if (items[i].name.toLowerCase().contains(search)) {
        itemId.add(items[i]);
      }
    }
    return [...itemId as Iterable<CommonFacility>];
  }
}

class RoomCategories with ChangeNotifier {
  List<RoomCategory> _items = [];
  get items {
    return [..._items];
  }
  void addListOfItems(List<RoomCategory> items){

    _items=[];
    items.forEach((element) {
      _items.add(RoomCategory(
        id: element.id,
        isAC: element.isAC,
        isFridge: element.isFridge,
        isBath: element.isBath,
        rent: element.rent,
        description: element.description,
        bed: element.bed,
      )
      );
    });
    //notifyListeners();
  }

  int findRoom(String id) {
    final index = _items.indexWhere((val) => val.id == id);
    return index;
  }

  void deleteRoom(int index) {
    if (index != -1)
      _items.removeAt(index);
    print(_items.length);
    notifyListeners();
  }

  void addRoom(RoomCategory obj) {
    print("Heelo Adding room in list");
    _items.add(obj);
    notifyListeners();
  }

  void setName(String id, String name) {
    final index = _items.indexWhere((val) => val.id == id);
    if (index >= 0) _items[index].description = name;
    notifyListeners();
  }

  void removeRoom(String courseId) {
    int index = _items.indexWhere((element) => element.id == courseId);
    if (index == -1) return;
    _items.removeAt(index);
    notifyListeners();
  }
}