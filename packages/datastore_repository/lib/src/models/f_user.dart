import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


/// {@template user}
/// User model
///
/// [FUser.empty] represents an unauthenticated user.
/// {@endtemplate}
class FUser extends Equatable {
  /// {@macro user}
  const FUser({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.phoneNumber,
    @required this.waterFlow,
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

  ///  the current phoneNumber
  final String phoneNumber;

  ///  the current waterFlow
  final double waterFlow;


  /// Empty user which represents an unauthenticated user.
  static const empty = FUser(email: '', id: '', name: null, photo: null, phoneNumber: '', waterFlow: 0.0);

  @override
  List<Object> get props => [email, id, name, photo, phoneNumber, waterFlow];
}
