import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    @required this.id,
    @required this.phoneNumber,
    @required this.name,
    @required this.photo,
  })  : assert(phoneNumber != null),
        assert(id != null);

  /// The current user's id.
  final String id;

  /// Url for the current user's phone number.
  final String phoneNumber;

  /// The current user's name (display name).
  final String name;

  /// The current user's name (display name).
  final String photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '', phoneNumber: '',  name: null, photo: null);

  @override
  List<Object> get props => [id, phoneNumber,  name, photo];
}