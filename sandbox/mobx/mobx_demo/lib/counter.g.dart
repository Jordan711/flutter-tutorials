// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Counter on CounterBase, Store {
  late final _$valuesAtom = Atom(name: 'CounterBase.values', context: context);

  @override
  int get values {
    _$valuesAtom.reportRead();
    return super.values;
  }

  @override
  set values(int value) {
    _$valuesAtom.reportWrite(value, super.values, () {
      super.values = value;
    });
  }

  late final _$CounterBaseActionController = ActionController(
    name: 'CounterBase',
    context: context,
  );

  @override
  void increment() {
    final _$actionInfo = _$CounterBaseActionController.startAction(
      name: 'CounterBase.increment',
    );
    try {
      return super.increment();
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$CounterBaseActionController.startAction(
      name: 'CounterBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
values: ${values}
    ''';
  }
}
