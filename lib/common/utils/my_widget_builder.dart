import 'package:flutter/material.dart';

import 'my_color.dart';

///
/// 功能：
/// 描述：
/// crated by xudailong on 2020/7/31.
///
class MBuilder{

  static Text text(String text,{double size  = 16,Color color,FontWeight weight =FontWeight.normal,int line = 1,TextAlign align = TextAlign.start,TextDecoration decoration = TextDecoration.none,double letterSp = 1.0,bool soft = true,TextOverflow flow = TextOverflow.ellipsis,double h=1.5}){
    return Text(text,style: TextStyle(fontSize: size,color: color==null?MColor.norFontColor:color,fontWeight: weight,decoration: decoration,letterSpacing: letterSp,height: h),overflow:flow,maxLines: line,textAlign: align,softWrap: soft);
  }

  static dot({Color color}) {
    return Container(
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
    );
  }
}