enum UserRole { buyer, seller }

enum ItemStatus { available, auction, sold }

enum NotificationType { outbid, auctionEnd, saleCompleted }

enum DeliveryStatus { pending, inTransit, delivered }

class User {
  static int _nextId = 1;
  int _id;
  String _username;
  String _email;
  String _phone;
  String _address;
  String _password;
  UserRole _role;

  User(
    this._username,
    this._email,
    this._phone,
    this._address,
    this._password,
    this._role,
  ) : _id = _nextId++;

  int get id => _id;
  String get username => _username;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  String get passwordHash => _password;
  UserRole get role => _role;

  set username(String value) => _username = value;
  set email(String value) => _email = value;
  set phone(String value) => _phone = value;
  set address(String value) => _address = value;
  set passwordHash(String value) => _password = value;
  set role(UserRole value) => _role = value;

  void updateContact({String? email, String? phone}) {
    if (email != null) _email = email;
    if (phone != null) _phone = phone;
  }

  void updateAddress({String? address}) {
    if (address != null) _address = address;
  }

  @override
  String toString() => 'User: $_username ($_role)';
}

class Item {
  static int _nextId = 1;
  int _itemId;
  int _sellerId;
  String _name;
  String _description;
  double? _startingPrice;
  double? _fixedPrice;
  ItemStatus _status;

  Item(
    this._sellerId,
    this._name,
    this._description,
    this._startingPrice,
    this._fixedPrice,
    this._status,
  ) : _itemId = _nextId++;

  int get itemId => _itemId;
  int get sellerId => _sellerId;
  String get name => _name;
  String get description => _description;
  double? get startingPrice => _startingPrice;
  double? get fixedPrice => _fixedPrice;
  ItemStatus get status => _status;

  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set startingPrice(double? value) => _startingPrice = value;
  set fixedPrice(double? value) => _fixedPrice = value;
  set status(ItemStatus value) => _status = value;

  void updateDetails([String? name, String? description]) {
    if (name != null) _name = name;
    if (description != null) _description = description;
  }

  @override
  String toString() => 'Item: $_name ($_status)';
}

class Auction {
  static int _nextId = 1;
  int _auctionId;
  int _itemId;
  DateTime _startTime;
  DateTime _endTime;
  double _currentBid;
  bool _isActive;

  Auction(
    this._itemId,
    this._startTime,
    this._endTime,
    this._currentBid,
    this._isActive,
  ) : _auctionId = _nextId++;

  int get auctionId => _auctionId;
  int get itemId => _itemId;
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  double get currentBid => _currentBid;
  bool get isActive => _isActive;

  set currentBid(double value) => _currentBid = value;
  set isActive(bool value) => _isActive = value;

  void extendAuction([int minutes = 30]) {
    _endTime = _endTime.add(Duration(minutes: minutes));
    print("Auction $_auctionId extended by $minutes minutes.");
  }

  @override
  String toString() =>
      'Auction for Item $_itemId: Current Bid \$$_currentBid (${_isActive ? "Active" : "Completed"})';
}

class Bid {
  static int _nextId = 1;
  int _bidId;
  int _auctionId;
  int _userId;
  double _amount;
  DateTime _time;

  Bid(this._auctionId, this._userId, this._amount, this._time)
    : _bidId = _nextId++;

  int get bidId => _bidId;
  int get auctionId => _auctionId;
  int get userId => _userId;
  double get amount => _amount;
  DateTime get time => _time;

  set amount(double value) => _amount = value;
  //check it ============================================
  set time(DateTime value) => _time = value;
  //=====================================================
  @override
  String toString() =>
      'Bid: \$$_amount by User $_userId on Auction $_auctionId at $_time';
}

class Sale {
  static int _nextId = 1;
  int _saleId;
  int _itemId;
  int _buyerId;
  int _sellerId;
  double _amount;
  String _paymentMethod;
  DateTime _saleDate;

  Sale(
    this._itemId,
    this._buyerId,
    this._sellerId,
    this._amount,
    this._paymentMethod,
    this._saleDate,
  ) : _saleId = _nextId++;

  int get saleId => _saleId;
  double get amount => _amount;
  String get paymentMethod => _paymentMethod;
  int get itemId => _itemId;
  int get buyerId => _buyerId;
  int get sellerId => _sellerId;

  @override
  String toString() => 'Sale $_saleId - \$$_amount on $_saleDate';
}

class Notification {
  static int _nextId = 1;
  int _notificationId;
  int _userId;
  String _message;
  NotificationType _type;
  DateTime _timestamp;
  bool _isRead;

  Notification(
    this._userId,
    this._message,
    this._type,
    this._timestamp,
    this._isRead,
  ) : _notificationId = _nextId++;

  void markAsRead() {
    _isRead = true;
  }

  @override
  String toString() => 'Notification: $_message [$_type]';
}

class Delivery {
  static int _nextId = 1;
  int _deliveryId;
  int _saleId;
  int _buyerId;
  int _sellerId;
  DeliveryStatus _status;
  String _trackingNumber;
  DateTime _estimatedArrival;

  Delivery(
    this._saleId,
    this._buyerId,
    this._sellerId,
    this._status,
    this._trackingNumber,
    this._estimatedArrival,
  ) : _deliveryId = _nextId++;

  void updateStatus(DeliveryStatus newStatus) {
    _status = newStatus;
  }

  @override
  String toString() => 'Delivery $_trackingNumber ($_status)';
}

void main() {
  List<User> users = [
    User(
      "Omar",
      "omar@gmail.com",
      "+96892345678",
      "Muscat, Oman",
      "Omar@12345",
      UserRole.seller,
    ),

    User(
      "Abdullah",
      "yousef@gmail.com",
      "+96891234488",
      "Nizwa, Oman",
      "Yousef!2024",
      UserRole.buyer,
    ),

    User(
      "Khaled",
      "khaled@gmail.com",
      "+96892754312",
      "Muscat, Oman",
      "Khaled#Pass1",
      UserRole.seller,
    ),

    User(
      "Tariq",
      "tariq@gmail.com",
      "+96895321100",
      "Sohar, Oman",
      "Tariq2025!",
      UserRole.buyer,
    ),

    User(
      "Fahad",
      "fahad@gmail.com",
      "+96898442233",
      "Salalah, Oman",
      "Fahad@Secure",
      UserRole.seller,
    ),
  ];

  List<Item> items = [
    Item(
      110,
      "Laser Printer",
      "High-quality laser printer suitable for office use",
      60,
      110,
      ItemStatus.available,
    ),
    Item(
      220,
      "Office Desk",
      "Modern wooden office desk with drawers",
      140,
      220,
      ItemStatus.available,
    ),
    Item(
      90,
      "Swivel Chair",
      "Ergonomic swivel chair with adjustable height",
      45,
      90,
      ItemStatus.sold,
    ),
    Item(
      130,
      "File Cabinet",
      "Metal filing cabinet with 4 drawers for documents",
      70,
      130,
      ItemStatus.available,
    ),
    Item(
      50,
      "Whiteboard",
      "Magnetic whiteboard for meetings and presentations",
      25,
      50,
      ItemStatus.available,
    ),
  ];
  List<Auction> auctions = [
    Auction(
      1,
      DateTime.parse("2025-04-07 09:00"),
      DateTime.parse("2025-04-10 17:00"),
      65,
      true,
    ),
    Auction(
      2,
      DateTime.parse("2025-04-06 08:30"),
      DateTime.parse("2025-04-09 16:00"),
      150,
      true,
    ),
    Auction(
      3,
      DateTime.parse("2025-04-01 10:00"),
      DateTime.parse("2025-04-04 18:00"),
      90,
      false,
    ),
    Auction(
      4,
      DateTime.parse("2025-04-05 14:00"),
      DateTime.parse("2025-04-08 15:00"),
      120,
      true,
    ),
  ];
  List<Bid> bids = [];
  Map<int, Auction> auctionMap = {};
}
