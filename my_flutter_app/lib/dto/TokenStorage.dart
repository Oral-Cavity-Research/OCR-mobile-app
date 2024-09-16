class TokenStorage {
  static final TokenStorage _instance = TokenStorage._internal();

  String? _token;
  String? _username;
  String? _email;
  String? _hospital;
  String? _password;
  bool? _availability;
  String? _role;
  String? _createdAt;
  String? _updatedAt;
  bool? _available;
  String? _regNo;
  String? _designation;
  String? _contactNo;
  String? _id;

  factory TokenStorage() {
    return _instance;
  }

  TokenStorage._internal();

  void setToken(String token) {
    _token = token;
  }

  void setUser(dynamic user) {
    _username = user['username'];
    _email = user['email'];
    _hospital = user['hospital'];
    _password = user['password'];
    _availability = user['availability'];
    _role = user['role'];
    _createdAt = user['createdAt'];
    _updatedAt = user['updatedAt'];
    _available = user['available'];
    _regNo = user['reg_no'];
    _designation = user['designation'];
    _contactNo = user['contact_no'];
    _id = user['_id'];
  }

  String? getToken() {
    return _token;
  }

  String? getUsername() {
    return _username;
  }

  String? getEmail() {
    return _email;
  }

  String? getHospital() {
    return _hospital;
  }

  String? getPassword() {
    return _password;
  }

  bool? getAvailability() {
    return _availability;
  }

  String? getRole() {
    return _role;
  }

  String? getCreatedAt() {
    return _createdAt;
  }

  String? getUpdatedAt() {
    return _updatedAt;
  }

  bool? getAvailable() {
    return _available;
  }

  String? getRegNo() {
    return _regNo;
  }

  String? getDesignation() {
    return _designation;
  }

  String? getContactNo() {
    return _contactNo;
  }

  String? getId() {
    return _id;
  }
}
