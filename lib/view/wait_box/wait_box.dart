import 'package:angular/core.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'wait-box',
    templateUrl: 'wait_box.html',
    styleUrls: const <String>['wait_box.css'],
    directives: const [MaterialSpinnerComponent],
    providers: const [])
class WaitBoxComponent implements OnInit {
  WaitBoxComponent();

  @override
  void ngOnInit() {}
}
