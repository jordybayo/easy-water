import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Tags {
  /// {@macro user}
  const Tags({
    @required this.id,
  })  : assert(id != null);


  ///  the current tag id
  final String id;

  /// Empty user which represents an unauthenticated user.
  static const empty = Tags(id: '',);

  @override
  List<Object> get props => [id,];
}