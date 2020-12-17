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
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.phoneNumber,
    @required this.photo,
  })  : assert(email != null),
        assert(id != null);

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String photo;

  /// Url for the current user's phoneNumber.
  final String phoneNumber;


  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', id: '', name: null, phoneNumber:'', photo: null);

  @override
  List<Object> get props => [email, id, name, phoneNumber, photo];
}