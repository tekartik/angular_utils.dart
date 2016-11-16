import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
  selector: 'wait-box',
  templateUrl: 'wait_box.html',
  styleUrls: const <String>['wait_box.css'],
    directives: const [materialDirectives],
    providers: const [materialProviders])
class WaitBoxComponent implements OnInit {

  WaitBoxComponent();

  @override
  void ngOnInit() {}

}
