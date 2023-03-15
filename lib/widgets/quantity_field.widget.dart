import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantityField extends StatelessWidget {
  const QuantityField({
    Key? key,
    required ValueNotifier<int> quantityNotifier,
  })  : _quantityNotifier = quantityNotifier,
        super(key: key);

  final ValueNotifier<int> _quantityNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _quantityNotifier,
        builder: (context, data, _) {
          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove,
                      ),
                      onPressed: () {
                        if (_quantityNotifier.value != 1) {
                          _quantityNotifier.value--;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    _quantityNotifier.value.toString(),
                    style: GoogleFonts.openSans(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        _quantityNotifier.value++;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
