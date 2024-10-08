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
  String? _image;

  factory TokenStorage() {
    return _instance;
  }

  TokenStorage._internal();

  void setToken(String token) {
    _token = token;
  }

  void setUserImage(String image) {
    _image = image;
  }

  void setAvailability(bool availability) {
    _availability = availability;
  }

  void setUsername(String new_name) {
    _username = new_name;
  }

  void setHospital(String new_hospital) {
    _hospital = new_hospital;
  }

  void setRegNo(String new_regNo) {
    _regNo = new_regNo;
  }

  void setDesignation(String new_designation) {
    _designation = new_designation;
  }

  void setContactNo(String new_contactNo) {
    _contactNo = new_contactNo;
  }


  void clearUserData() {
    _token = null;
    _username = null;
    _email = null;
    _hospital = null;
    _password = null;
    _availability = null;
    _role = null;
    _createdAt = null;
    _updatedAt = null;
    _available = null;
    _regNo = null;
    _designation = null;
    _contactNo = null;
    _id = null;
    _image = null;
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

  void clearToken() {
    _token = null;
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

  String? getImage() {
    return _image;
  }

}
