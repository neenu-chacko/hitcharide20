import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workavane/brand_colors.dart';
import 'package:workavane/datamodels/prediction.dart';
import 'package:workavane/dataprovider/appdata.dart';
import 'package:workavane/helper/RequestHelper.dart';
import 'package:workavane/widgets/BrandDivider.dart';
import 'package:workavane/widgets/predictiontile.dart';

import '../globalvariables.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var pickup=new TextEditingController();
    var destination=new TextEditingController();

    var focusDestination = FocusNode();

  bool focused = false;

  void setFocus(){
    if(!focused){
      FocusScope.of(context).requestFocus(focusDestination);
      focused = true;
    }
  }

    List<Prediction> destinationPredictionList = [];

  void searchPlace(String placeName) async {

    if(placeName.length > 1){

      String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapkey&sessiontoken=123254251&components=country:in';
      var response = await RequestHelper.getRequest(url);

      if(response == 'failed'){
        return;
      }
      //print(response);

      if(response['status'] == 'OK'){
        var predictionJson = response['predictions'];
        var thisList = (predictionJson as List).map((e) => Prediction.fromJson(e)).toList();

        setState(() {
          destinationPredictionList = thisList;
        });

      

    }

  }
  }

  @override
  Widget build(BuildContext context) {
    setFocus();
    
    String address= Provider.of<AppData>(context).pickupAddress.placeName ?? '';

    pickup.text=address;
    
   return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ),
                  ),
                ]
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
              child: Column(
                children: <Widget>[

                  SizedBox(height: 5,),
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                      },
                          child: Icon(Icons.arrow_back)
                      ),
                      Center(
                        child: Text('Set Destination',
                          style: TextStyle(fontSize: 20,fontFamily: 'Brand-Bold' ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18,),

                  Row(
                    children: <Widget>[
                      Image.asset('images/pickicon.png', height: 16, width: 16,),

                      SizedBox(width: 18,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: BrandColors.colorLightGrayFair,
                           
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(2.0),
                            child: TextField(
                              controller: pickup,
                             
                              decoration: InputDecoration(
                                hintText: 'Pickup location',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8)
                                

                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[
                      Image.asset('images/desticon.png', height: 16, width: 16,),

                      SizedBox(width: 18,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: BrandColors.colorLightGrayFair,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(2.0),
                            child: TextField(
                              focusNode: focusDestination,
                              controller: destination,
                              onChanged: (value){
                              searchPlace(value);
                              },
                              decoration: InputDecoration(
                                  hintText: 'Where to?',
                                  fillColor: BrandColors.colorLightGrayFair,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),



          (destinationPredictionList.length > 0) ?
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListView.separated(
              padding: EdgeInsets.all(0),
                itemBuilder: (context, index){
                  return PredictionTile(
                    prediction: destinationPredictionList[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => BrandDivider(),
                itemCount: destinationPredictionList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
          )
              : Container(),

            

        ],
      ),
    );
  }
}

