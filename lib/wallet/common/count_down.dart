import 'component_index.dart';

Widget CountDown({
  String sharedPreferenceKey,
  ValueNotifier<bool> counting,
  int startNum = 5,
  int stopNum = 1,
  stopText = 'Verification Code'
}) {
  if (counting.value == true) {
    int countNum = SpWalletUtil.getInt(sharedPreferenceKey);
    ValueNotifier<int> count;

    if (countNum == null) {
      count = ValueNotifier(startNum);
    } else {
      count = ValueNotifier(countNum);
    }

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (count.value > stopNum) {
        count.value--;
      } else {
        timer.cancel();
        timer = null;
        count.value = startNum;
        counting.value = false;
      }

      SpWalletUtil.putInt(sharedPreferenceKey, count.value);
    });

    return ValueListenableBuilder(
        valueListenable: count,
        builder: (BuildContext context, int value, Widget child) {
          return Text(count.value.toString() + 's',
            style: TextStyle(
                height: 1,
                fontSize: 24.sp,
                color: Color(0xffD9DADB)
            ),
          );
        }
    );
  }

  return Text(stopText,
    style: TextStyle(
        height: 1,
        fontSize: 24.sp,
        color: Color(0xff002fa7)
    ),
  );
}
