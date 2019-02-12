import 'package:angular/core.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'wait-box',
    templateUrl: 'wait_box.html',
    styleUrls: <String>['wait_box.css'],
    directives: [MaterialSpinnerComponent],
    providers: [])
class WaitBoxComponent implements OnInit {
  WaitBoxComponent();

  @override
  void ngOnInit() {}
}
