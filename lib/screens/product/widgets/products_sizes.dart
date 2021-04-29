import 'package:flutter/material.dart';

import 'add_sizeDialog.dart';

class ProductsSizes extends FormField<List> {
  ProductsSizes(
      {List initialValue,
      FormFieldSetter<List> onSaved,
      FormFieldValidator<List> validator,
      BuildContext context})
      : super(
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      autovalidateMode: AutovalidateMode.disabled,
      builder: (state) {
          return SizedBox(
            height: 34,
            child: GridView(
              padding: EdgeInsets.symmetric(vertical: 4),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisSpacing: 8, childAspectRatio: 0.5),
              children: state.value.map((e) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.pinkAccent, width: 3),
                    ),
                    alignment: Alignment.center,
                    child: Text(e,style: TextStyle(color: Colors.white)),
                  ),
                  onLongPress: (){
                    state.didChange(state.value..remove(e));
                  },
                );
              }).toList()..add(
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: state.hasError ? Colors.red : Colors.pinkAccent, width: 3),
                      ),
                      alignment: Alignment.center,
                      child: Text("+", style: TextStyle(color: Colors.white)),
                    ),
                    onTap: () async {
                      String size = await showDialog(context: context, builder: (context) => AddSizeDialog());
                      if(size != null)
                        state.didChange(state.value..add(size.toUpperCase()));
                    },
                  )
              ),
            ),
          );
        });

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
