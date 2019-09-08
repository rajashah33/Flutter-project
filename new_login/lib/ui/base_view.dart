//System imports
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../service_locator.dart';

///Base view for the project whcih other views use to derive from
class BaseView<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  BaseView({ScopedModelDescendantBuilder<T> builder}) : _builder = builder;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Model> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
      model: locator<T>(),
      child: ScopedModelDescendant<T>(
        builder: widget._builder,
      ),
    );
  }
}
