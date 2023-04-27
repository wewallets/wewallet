import 'package:mars/common/transaction_component_index.dart';

// ignore: must_be_immutable
class ActivityProgressBarWidget extends StatelessWidget {
  int progress;
  double width = 77;
  double height = 5.5;
  double radius = 4.75;
  String title;

  ActivityProgressBarWidget(this.progress, this.title, {this.width = 77, this.height = 5.5, this.radius = 4.75});

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(color: Color(0xFFE8E8E8)),
              ),
              Container(
                width: progress / 100 * width,
                height: height,
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFFB41D), Color(0xFFFFB41D)]), borderRadius: BorderRadius.all(Radius.circular(radius))),
              ),
              Padding(child: Text(title, style: TextStyles.textWhite9), padding: EdgeInsets.only(left: 5)),
            ],
          )),
    );
  }
}
