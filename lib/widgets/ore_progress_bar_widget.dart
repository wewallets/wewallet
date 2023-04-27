import 'package:mars/common/transaction_component_index.dart';

class OreProgressBarWidget extends StatelessWidget {
  final double progress;

  OreProgressBarWidget(this.progress);

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adaptationDp(320),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(adaptationDp(4))),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(width: adaptationDp(315), height: adaptationDp(7), decoration: BoxDecoration(color: Color(0xFFE6B86F), borderRadius: BorderRadius.all(Radius.circular(adaptationDp(4))))),
              Container(
                width: progress / 100 * adaptationDp(315),
                height: adaptationDp(7),
                decoration: BoxDecoration(color: Color(0xFFBF9241), borderRadius: BorderRadius.all(Radius.circular(adaptationDp(4)))),
              ),
              Container(
                margin: EdgeInsets.only(left: (progress / 100 * adaptationDp(315)) - progress>=20 ? adaptationDp(15):0),
                child: LoadImage('jinduzj', width: adaptationDp(20), height: adaptationDp(20), fit: BoxFit.contain),
              ),
            ],
          )),
    );
  }
}
