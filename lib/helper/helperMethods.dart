import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workavane/datamodels/address.dart';
import 'package:workavane/dataprovider/appdata.dart';
import 'package:workavane/helper/RequestHelper.dart';
import 'package:workavane/globalvariables.dart';
import 'package:provider/provider.dart';



/*class HelperMethods{

  static Future<String> findCordinateAddress(Position position, context )async{
    String placeAddress = '';

   var connectivityResult = await Connectivity().checkConnectivity();
   if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
     return placeAddress;
   }
     String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey';

       var response = await RequestHelper.getRequest(url);
       if(response != 'failed'){
     placeAddress = response['results'][0]['formatted_address'];
     Address pickupAddress = new Address();

     pickupAddress.longitude = position.longitude;
     pickupAddress.latitude = position.latitude;
     pickupAddress.placeName = placeAddress;

     Provider.of<AppData>(context, listen: false).updatePickupAddress(pickupAddress);

     

   }

   return placeAddress;


  }

  }*/
  class HelperMethods{

  

 static Future<String> findCordinateAddress(Position position) async {

   String placeAddress = '';

   var connectivityResult = await Connectivity().checkConnectivity();
   if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
     return placeAddress;
   }

   String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey';

   var response = await RequestHelper.getRequest(url);

   if(response != 'failed'){

     placeAddress = response['results'][0]['formatted_address'];

     Address pickupAddress=new Address();

     pickupAddress.longitude=position.longitude;
     pickupAddress.latitude=position.latitude;
     pickupAddress.placeName= placeAddress;
     Provider.of<AppData>(context, listen: false).updatePickupAddress(pickupAddress);


   }

   return placeAddress;

  }
  }
