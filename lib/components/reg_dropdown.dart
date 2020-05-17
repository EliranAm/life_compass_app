import 'package:flutter/material.dart';

class RegDropdown extends StatelessWidget {
  RegDropdown({
    this.title: '',
    @required this.items,
    @required this.selectItem,
    @required this.onChanged,
  });

  final String title;
  final List<String> items;
  final String selectItem;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        top: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40.0,
            //padding: EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
          ),
          Expanded(
            child: DropdownButton(
              value: selectItem,
              isDense: true,
              isExpanded: true,
              items: items
                  .map(
                    (age) => DropdownMenuItem(
                      value: age,
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 2.0,
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          age.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              style: TextStyle(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
