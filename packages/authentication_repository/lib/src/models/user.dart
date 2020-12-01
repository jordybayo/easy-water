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
    @required this.phonenumber,
    @required this.id,
    @required this.name,
    @required this.dialcode,
    @required this.country,
    @required this.language,
  })  : assert(phonenumber != null),
        assert(id != null);

  /// Url for the current user's phone number.
  final String phonenumber;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's dial code.
  final String dialcode;

  /// Url for the current user's country.
  final String country;

  /// Url for the current user's language.
  final String language;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(phonenumber: '', id: '', name: null, dialcode: null, country: null, language: null);

  @override
  List<Object> get props => [phonenumber, id, name, dialcode, country, language];
}