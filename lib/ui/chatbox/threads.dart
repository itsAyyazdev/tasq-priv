import 'package:tasq/ui/widgets/shared/empty_screen.dart';
import 'package:tasq/utils/globals/import_hub.dart';

class Threads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EmptyScreen(
        msg: "No threads",
      ),
    );
  }
}
