import 'package:flutter/material.dart';

class Address{
  String placeName;
  double latitude;
  double longitude;
  String placeId;
  String placeFormattedAddress;

  Address(
    {
      this.placeId,
      this.latitude,
      this.longitude,
      this.placeFormattedAddress,
      this.placeName,
    }

  );


}