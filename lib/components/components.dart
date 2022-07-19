import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';

void navigateTo(context, nextPage) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );

void navigateAndFinish(context, nextPage) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
    (route) => false);

Widget defaultTextField({
  required String labeltxt,
  required Icon prefixicon,
  bool isPass = false,
  IconData? suffix,
  TextEditingController? controller,
  required TextInputType txtinput,
  Function()? SuffixPressed,
  Function(String val)? onSubmit,
  Function(String value)? valid,
  TextStyle? hintStyle,
}) {
  return TextFormField(
    keyboardType: txtinput,
    controller: controller,
    onFieldSubmitted: onSubmit,
    obscureText: isPass,
    decoration: InputDecoration(hintStyle: hintStyle,
      fillColor: Colors.white,
      filled: true,
      hintText: labeltxt,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 10
        ),
      ),

      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: Colors.white,
            width: 10
        ),
      ),
      prefixIcon: prefixicon,
      suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: SuffixPressed,
      ),
    ),
    validator: (value) {
      valid!;
    },
  );
}

Widget defaultText(
        {required String text,
        double? fontsize,
        isUpperCase = false,
        textColor,
        double? textHeight,linesMax,TextOverflow? textOverflow,FontStyle? fontStyle,TextStyle? hintStyle,TextAlign? textAlign}) =>
    Text(
      isUpperCase ? text.toUpperCase() : text,
      maxLines:linesMax,
      overflow: textOverflow,
      textAlign: textAlign,
      style:
          TextStyle(fontSize: fontsize, color: textColor, height: textHeight,
          fontStyle: fontStyle,),
    );

Widget defaultTextButton(
        {required String text, required VoidCallback fn, double? fontSize,textColor,bool isUpper=true}) =>
    TextButton(
        onPressed: fn,

        child: Text(
         isUpper ? text.toUpperCase() : text,
          style: TextStyle(fontSize: fontSize,color: textColor),
        ));

Widget defaultBtn({
  double left_margin_icon = 1,
  double right_margin_icon = 10,
  double right_margin_text = 20,
  double width = 330,
  Color backgroundcolor = Colors.blue,
  bool isUpperCase = true,
  double BorderRadValue = 31,
  required String txt,
  required VoidCallback function,
  IconData? icon,
  double fontSize = 20,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(BorderRadValue),
      color: backgroundcolor,
    ),
    child: TextButton.icon(
      icon: Container(
        margin:
            EdgeInsets.only(right: right_margin_icon, left: left_margin_icon),
        child: Icon(
          icon,
          color: Colors.white,
          size: 38,
        ),
      ),
      onPressed: function,
      label: Container(
        margin:
            EdgeInsets.only(right: right_margin_text, left: left_margin_icon),
        child: Text(
          isUpperCase ? txt.toUpperCase() : txt,
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
      ),
    ),
  );
}

Widget myDivider() => Container(
      width: double.infinity,
      color: Colors.grey,
      height: 1,
    );

Widget buildListProduct(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? Colors.blue
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
