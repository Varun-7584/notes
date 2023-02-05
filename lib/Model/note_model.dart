//create  a model here
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Note{
  final int ? id ;
  final String title ;
  final String description ;

  //create constructor

const Note({ this.id , required this.title , required this.description});

//create model
factory Note .fromJson(Map<String , dynamic >json)=> Note(
  id : json['id'],
  title: json ['title'],
  description: json['description']
);

Map<String , dynamic> toJson() =>{
  'id': id,
  'title': title,
  'description':description,
  };
}