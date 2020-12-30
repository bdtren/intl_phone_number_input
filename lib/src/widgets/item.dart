import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country country;
  final bool showFlag;
  final bool useEmoji;
  final String customCountryCodeText;

  /// [hasDialCodeInCustomText] is only use in case [customCountryCodeText] is set.
  /// if [true] It will replace every sub text "<dialCode>" with actual [country.dialCode]
  final bool hasDialCodeInCustomText;
  final TextStyle textStyle;
  final bool withCountryNames;
  final bool showCountryCode;
  final Color backgroundColor;

  const Item({
    Key key,
    this.country,
    this.showFlag,
    this.useEmoji,
    this.customCountryCodeText,
    this.hasDialCodeInCustomText = true,
    this.textStyle,
    this.withCountryNames = false,
    this.showCountryCode = true,
    this.backgroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // SizedBox(width: 12.0),
          _Flag(
            margin: EdgeInsets.only(left: 12.0),
            country: country,
            showFlag: showFlag,
            useEmoji: useEmoji,
          ),
          // SizedBox(width: 12.0),
          this.showCountryCode
            ? Container(
               margin: EdgeInsets.only(left: 12.0),
               child: Text(
                  customCountryCodeText != null
                    ? customCountryCodeText?.replaceAll("<dialCode>", this.hasDialCodeInCustomText? country?.dialCode ?? '' : "<dialCode>")
                    : '${(country?.dialCode ?? '').padRight(5, "   ")}',
                 textDirection: TextDirection.ltr,
                 style: textStyle,
               ),
             )
            : SizedBox(),
        ],
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country country;
  final bool showFlag;
  final bool useEmoji;
  final EdgeInsets margin;

  const _Flag({Key key, this.country, this.showFlag, this.useEmoji, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null && showFlag
        ? Container(
            margin: margin,
            child: useEmoji
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headline5,
                  )
                : country?.flagUri != null
                    ? Image.asset(
                        country?.flagUri,
                        width: 32.0,
                        package: 'intl_phone_number_input',
                      )
                    : SizedBox.shrink(),
          )
        : SizedBox.shrink();
  }
}
