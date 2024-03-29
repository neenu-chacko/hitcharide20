import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:workavane/brand_colors.dart';
import 'package:workavane/datamodels/address.dart';
import 'package:workavane/datamodels/prediction.dart';
import 'package:workavane/dataprovider/appdata.dart';
import 'package:workavane/helper/RequestHelper.dart';

import '../globalvariables.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  PredictionTile({this.prediction});

  @override
  Widget build(BuildContext context) {
     void getPlaceDetails(String placeID,context)async{

           String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$mapkey';
          var response = await RequestHelper.getRequest(url);

          if(response == 'failed'){
      return;
    }

    if(response['status'] == 'OK'){

      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude = response ['result']['geometry']['location']['lat'];
      thisPlace.longitude = response ['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false).updateDestinationAddress(thisPlace);
      //print(thisPlace.placeName);

      Navigator.pop(context, 'getDirection');
    }
     }


    return FlatButton(
            onPressed: (){
              getPlaceDetails(prediction.placeId, context);

            },
           padding: EdgeInsets.all(0),
          child: Container(
        child: Row(
          children: <Widget>[
          Icon(OMIcons.locationOn,color: BrandColors.colorDimText,),
        SizedBox(
          width:12,
        ),

        Expanded(
                child: Column(            
            
            crossAxisAlignment: CrossAxisAlignment.start,

            children:<Widget> [

            Text(prediction.mainText,overflow: TextOverflow.ellipsis ,style:TextStyle(fontSize: 16),),
            SizedBox(height:2,),
            Text(prediction.secondaryText,overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize: 12,color: BrandColors.colorLightGray),),


          ],
          ),
        ),

        ],
        
        ),
      ),
    );
  }
}
