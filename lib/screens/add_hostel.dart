import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/module/hostel.dart';
import 'package:hostel_app/module/hostels.dart';
import 'package:hostel_app/screens/my_map.dart';
import 'package:hostel_app/screens/search_facility.dart';
import 'package:hostel_app/widgets/hoste_category_list.dart';
import 'package:hostel_app/widgets/room_category_tile.dart';
import '../module/providers.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import '../custom_icons_icons.dart';

class AddHostel extends StatefulWidget {
  static const routeName = '/add_customer';

  @override
  _AddHostelState createState() => _AddHostelState();
}

class _AddHostelState extends State<AddHostel> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final gender = ["Male", "Female", "Both"];
  final hostelType = ["Private", "Public"];
  Hostel hostel = Hostel();
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  List<String> deleteUrls = <String>[];
  String _error = 'No Error Dectected';

  void deleteAsset(int index, bool isUrl) async {
    setState(() {
      if (isUrl) {
        deleteUrls.add(imageUrls[index]);
        imageUrls.removeAt(index);
      } else
        images.removeAt(index);
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  void deleteImageByUrl() {
    deleteUrls.forEach((url) {
      FirebaseStorage.instance
          .getReferenceFromUrl(url)
          .then((value) => value.delete());
    });
  }

  Future<void> uploadImages() async {
    try {
      for (var imageFile in images) {
        final url = await postImage(imageFile);
        print(url);
        imageUrls.add(url);
      }
    } catch (error) {
      throw (error);
    }
  }

  void _submit(index) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    await uploadImages();
    hostel.images = imageUrls;
    hostel.facilities =
        Provider.of<MyFacilities>(context, listen: false).selectedItems();
    hostel.roomCategories =
        Provider.of<RoomCategories>(context, listen: false).items;
    print(hostel.roomCategories.length);
    bool result=true;
    print("Index $index");
    if (index==null) {
      print(index);
      print("Adding Hostel in List");
      result =
      await Provider.of<Hostels>(context, listen: false).addHostel(hostel);
       }
      else {
        print("Updating Hostel");
      result = await Provider.of<Hostels>(context, listen: false).updateHostel(
          index, hostel);
      }
      if (result == true) deleteImageByUrl();
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#f8c4bf",
          statusBarColor: "#f8c4bf",
          lightStatusBar: true,
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }
  int index=-1;
  bool checkOnlyFirst=true;
  @override
  void didChangeDependencies() {
    print("Refreshing all data");
    if (checkOnlyFirst){
      final data = ModalRoute.of(context).settings.arguments;
      index=data;
      if (data != null) {
        hostel = Provider.of<Hostels>(context, listen: false)
            .myHostel[index]
            .hostelCopy();
        imageUrls = hostel.images;
        Provider.of<RoomCategories>(context).addListOfItems(hostel.roomCategories);
        Provider.of<MyFacilities>(context, listen: false)
            .addItemList(hostel.facilities);
      }
      else{
        Provider.of<MyFacilities>(context).clear();
        Provider.of<RoomCategories>(context).addListOfItems([]);
      }
      setState(() {
        checkOnlyFirst=false;
      });
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final index = ModalRoute.of(context).settings.arguments;

    final dSize = MediaQuery.of(context).size;
    final _hintStyle = TextStyle(
      fontSize: dSize.height * 0.020,
      color: Color(0xFF191C3D),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Hostel",
          style: TextStyle(
              fontSize: dSize.height * 0.027,
              color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, size: dSize.height * 0.028),
//        leading:Icon(Icons.menu,color: Colors.green,),
        actions: <Widget>[
          _isLoading
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(CustomIcons.disk),
                  onPressed: ()=>_submit(index),
                ),
        ],
      ),
      //drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              children: <Widget>[
                TextFormField(
                  style: _hintStyle,
                  initialValue: hostel.name,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    labelText: "Hostel Name",
                  ),
                  validator: (text) {
                    if (text.length < 3)
                      return "Name is very short";
                    else if (text == null) return "Field is required";
                    return null;
                  },
                  onSaved: (text) => hostel.name = text,
                ),
                TextFormField(
                  style: _hintStyle,
                  initialValue: hostel.phone,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    labelText: "Phone No",
                  ),
                  validator: (text) {
                    if (text.length < 9 || int.tryParse(text) == null)
                      return "Invalid Phone";
                    else if (text == null) return "Field is required";
                    return null;
                  },
                  onSaved: (text) => hostel.phone = text,
                ),
                TextFormField(
                  initialValue: hostel.whatsApp,
                  style: _hintStyle,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    labelText: "WhatsApp No",
                  ),
                  validator: (text) {
                    if (text.length < 9 || int.tryParse(text) == null)
                      return "Invalid Phone";
                    else if (text == null) return "Field is required";
                    return null;
                  },
                  onSaved: (text) => hostel.whatsApp = text,
                ),
                TextFormField(
                  initialValue: hostel.facebookUrl,
                  style: _hintStyle,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    labelText: "Facebook Url",
                  ),
                  validator: (value) {
                    if (value != "" &&
                        !RegExp(r"(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?")
                            .hasMatch(value)) {
                      return 'This is not Facebook URL';
                    }
                    return null;
                  },
                  onSaved: (text) => hostel.facebookUrl = text,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          initialValue: hostel.address,
                          cursorColor: Theme.of(context).primaryColor,
                          style: _hintStyle,
                          decoration: InputDecoration(
                            //suffix: Icon(Icons.keyboard_arrow_down),
                            labelText: "Address",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                          ),
                          validator: (text) {
                            if (text.length < 10)
                              return "Address is to short";
                            else if (text == null) return "Address is required";
                            return null;
                          },
                          onSaved: (text) => hostel.address = text,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        child: SizedBox(
                          child: IconButton(
                            icon: Icon(
                              Icons.my_location,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(MyMap.routeName);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: dSize.width * 0.50 - 22.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFF252A59).withOpacity(0.30),
                          width: 0.5,
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        style: _hintStyle,
                        elevation: 0,
                        value: hostel.genderCategory ?? gender[0],
                        //isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        decoration: InputDecoration.collapsed(
                          enabled: false,
                          hintText: null,
                        ),
                        onChanged: (val) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        onSaved: (val) => hostel.genderCategory = val,
                        items: gender
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // onSaved: (val)=>creditType=val,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: dSize.width * 0.50 - 22.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFF252A59).withOpacity(0.30),
                          width: 0.5,
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        style: _hintStyle,
                        elevation: 0,
                        value: hostel.category ?? hostelType[0],
                        onChanged: (val) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        onSaved: (val) => hostel.category = val,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        decoration: InputDecoration.collapsed(
                          enabled: false,
                          hintText: null,
                        ),
                        //onSaved: (val)=>paymentType=val,
                        items: hostelType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Container(
                  //height: dSize.height*0.50,
                  //margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.16),
                        )
                      ]),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: <Widget>[
                      ...List.generate(imageUrls.length, (index) {
                        return gridImage(
                            imageUrls[index], index, deleteAsset, true);
                      }),
                      ...List.generate(images.length, (index) {
                        Asset asset = images[index];
                        return gridImage(asset, index, deleteAsset, false);
                      }),
                      GestureDetector(
                          onTap: () async {
                            await loadAssets();
                            for (int i = 0; i < images.length; i++)
                              print(images[0].identifier);
                          },
                          child: gridAddWidget("Images")),
                    ],
                    //itemBuilder: (ctx, index) => index==4? gridAddWidget("Images"): gridImage("assets/demo.jpg")
                  ),
                ),
                Container(
                  //height: dSize.height*0.50,
                  //margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.16),
                        )
                      ]),
                  child: Consumer<MyFacilities>(builder: (context, mf, ch) {
                    final myList = mf.chooseList();
                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        ...List.generate(myList.length, (index) {
                          return gridWidget(index, myList[index]);
                        }),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SearchFacility.routeName);
                            },
                            child: gridAddWidget("Facilities")),
                      ],
                      //itemBuilder: (ctx, index) => index==4? gridAddWidget("Images"): gridImage("assets/demo.jpg")
                    );
                  }),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFC42B0B).withOpacity(0.10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Bed",
                        style: TextStyle(
                            color: Color(0xFFC42B0B),
                            fontWeight: FontWeight.w600),
                      ),
                      Text("Bath",
                          style: TextStyle(
                              color: Color(0xFFC42B0B),
                              fontWeight: FontWeight.w600)),
                      Text("AC",
                          style: TextStyle(
                              color: Color(0xFFC42B0B),
                              fontWeight: FontWeight.w600)),
                      Text("Fridge",
                          style: TextStyle(
                              color: Color(0xFFC42B0B),
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                    //height: 500,
                    child: HostelCategoryList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget gridWidget(int index, CommonFacility obj) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Icon(
          obj.icon,
          color: Colors.black,
        ),
      ),
      Text(
        obj.name,
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1, color: Colors.black, fontWeight: FontWeight.w500),
      )
    ],
  );
}

Widget gridAddWidget(String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Padding(
        child: Icon(CustomIcons.plus),
        padding: EdgeInsets.all(5),
      ),
      Text(
        "Add $text",
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFFC42B0B), fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget gridImage(asset, index, deleteAsset, bool isUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onLongPress: () {},
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                )
              ],
            ),
            child: isUrl
                ? Image.network(
                    asset,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  )
                : AssetThumb(
                    width: 300,
                    height: 300,
                    asset: asset,
                  ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.redAccent,
              ),
              padding: EdgeInsets.zero,
              onPressed: () => deleteAsset(index, isUrl),
            ),
          ),
        ],
      ),
    ),
  );
}
