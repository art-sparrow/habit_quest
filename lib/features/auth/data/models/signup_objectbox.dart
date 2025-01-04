import 'package:objectbox/objectbox.dart';

@Entity()
class SignUpEntity {
  SignUpEntity({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.joinedOn = '',
    this.uid = '',
    this.fcmToken = '',
  });

  @Id()
  int id = 0;

  String name;
  String phone;
  String email;
  String joinedOn;
  String uid;
  String fcmToken;
}
