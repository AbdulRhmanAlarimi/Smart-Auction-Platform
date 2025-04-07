import 'dart:io';

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
      "john_doe",
      "john@example.com",
      "1234567890",
      "123 Main St",
      "password123",
      UserRole.buyer,
    ),
    User(
      "jane_seller",
      "jane@example.com",
      "0987654321",
      "456 Elm St",
      "securepass",
      UserRole.seller,
    ),
  ];

  List<Item> items = [
    Item(
      users[0]._id,
      "Antique Vase",
      "A beautiful antique vase from the 18th century.",
      100.0,
      null,
      ItemStatus.available,
    ),

    Item(
      users[1]._id,
      "Vintage Watch",
      "A rare vintage watch in excellent condition.",
      200.0,
      500.0,
      ItemStatus.sold,
    ),
  ];

  List<Auction> auctions = [
    Auction(
      items[0].itemId,
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      100.0,
      true,
    ),
    Auction(
      items[1].itemId,
      DateTime.now(),
      DateTime.now().add(Duration(days: 2)),
      200.0,
      true,
    ),
  ];

  List<Bid> bids = [
    Bid(auctions[0]._auctionId, users[0]._id, 120.0, DateTime.now()),
    Bid(
      auctions[1]._auctionId,
      users[1]._id,
      150.0,
      DateTime.now().add(Duration(minutes: 10)),
    ),
  ];

  Map<int, Auction> auctionMap = {
    for (var auction in auctions) auction.auctionId: auction,
  };

  void displayMenu() {
    print("\n=== Smart Auction Platform Menu ===");
    print("1. Display Information of Lists");
    print("2. Add New Data to List");
    print("3. Delete Record");
    print("4. Search Record");
    print("5. Exit");
    stdout.write("Choose an option: ");
  }

  void displayListInfo(List<Item> items, List<Auction> auctions) {
    print("\n=== Display Information ===");
    print("1. Display Item Information");
    print("2. Display Auction Information");
    stdout.write("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print("\nItems:");
        items.forEach((item) => print(item));
        break;
      case 2:
        print("\nAuctions:");
        auctions.forEach((auction) => print(auction));
        break;
      default:
        print("Invalid option. Please try again.");
    }
  }

  void addNewData(
    List<User> users,
    List<Item> items,
    List<Auction> auctions,
    List<Bid> bids,
  ) {
    print("\n=== Add New Data ===");
    print("1. Add User");
    print("2. Add Item");
    print("3. Add Bid");
    stdout.write("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter username: ");
        String username = stdin.readLineSync()!;
        stdout.write("Enter email: ");
        String email = stdin.readLineSync()!;
        stdout.write("Enter phone: ");
        String phone = stdin.readLineSync()!;
        stdout.write("Enter address: ");
        String address = stdin.readLineSync()!;
        stdout.write("Enter password: ");
        String password = stdin.readLineSync()!;
        stdout.write("Enter role (buyer/seller): ");
        String role = stdin.readLineSync()!;
        users.add(
          User(
            username,
            email,
            phone,
            address,
            password,
            role == "buyer" ? UserRole.buyer : UserRole.seller,
          ),
        );
        print("User added successfully.");
        break;
      case 2:
        stdout.write("Enter seller ID: ");
        int sellerId = int.parse(stdin.readLineSync()!);
        if (!users.any(
          (user) => user.id == sellerId && user.role == UserRole.seller,
        )) {
          print(
            "Error: Seller ID $sellerId is not registered or is not a seller.",
          );
          return;
        }
        stdout.write("Enter item name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter description: ");
        String description = stdin.readLineSync()!;
        print(
          "Do you want this item to be sold at a fixed price or via auction?",
        );
        print("1. Fixed Price");
        print("2. Auction");
        stdout.write("Choose an option: ");
        int itemChoice = int.parse(stdin.readLineSync()!);

        if (itemChoice == 1) {
          stdout.write("Enter fixed price: ");
          double fixedPrice = double.parse(stdin.readLineSync()!);
          items.add(
            Item(
              sellerId,
              name,
              description,
              null, // Starting price is null for fixed price
              fixedPrice,
              ItemStatus.available,
            ),
          );
          print("Item added successfully with a fixed price.");
        } else if (itemChoice == 2) {
          stdout.write("Enter starting price: ");
          String? startingPriceInput = stdin.readLineSync();
          double? startingPrice =
              startingPriceInput != null && startingPriceInput.isNotEmpty
                  ? double.parse(startingPriceInput)
                  : null;
          stdout.write("Enter auction start time (yyyy-MM-dd HH:mm): ");
          DateTime startTime = DateTime.parse(stdin.readLineSync()!);
          stdout.write("Enter auction end time (yyyy-MM-dd HH:mm): ");
          DateTime endTime = DateTime.parse(stdin.readLineSync()!);
          stdout.write("Enter starting bid: ");
          double startingBid = double.parse(stdin.readLineSync()!);

          Item newItem = Item(
            sellerId,
            name,
            description,
            startingBid, // Starting price is used for auction
            null, // Fixed price is null for auction
            ItemStatus.auction,
          );
          items.add(newItem);

          auctions.add(
            Auction(newItem.itemId, startTime, endTime, startingBid, true),
          );
          print("Item added successfully and listed for auction.");
        } else {
          print("Invalid option. Item not added.");
        }
        break;
      case 4:
        stdout.write("Enter auction ID: ");
        int auctionId = int.parse(stdin.readLineSync()!);
        Auction? auction = auctions.firstWhere(
          (a) => a.auctionId == auctionId,
          orElse: () {
            throw Exception("Error: Auction ID $auctionId not found.");
          },
        );

        if (auction == null) {
          return;
        }

        stdout.write("Enter user ID: ");
        int userId = int.parse(stdin.readLineSync()!);
        stdout.write("Enter bid amount: ");
        double amount = double.parse(stdin.readLineSync()!);

        if (amount <= auction.currentBid) {
          print(
            "Error: Bid amount must be greater than the current bid (\$${auction.currentBid}).",
          );
          return;
        }

        bids.add(Bid(auctionId, userId, amount, DateTime.now()));
        auction.currentBid = amount;
        print("Bid added successfully.");
        break;
      default:
        print("Invalid option.");
    }
  }

  void deleteRecord(
    List<User> users,
    List<Item> items,
    List<Auction> auctions,
    List<Bid> bids,
  ) {
    print("\n=== Delete Record ===");
    print("1. Delete User");
    print("2. Delete Item");
    print("3. Delete Auction");
    print("4. Delete Bid");
    stdout.write("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter user ID to delete: ");
        int userId = int.parse(stdin.readLineSync()!);
        users.removeWhere((user) => user.id == userId);
        print("User deleted successfully.");
        break;
      case 2:
        stdout.write("Enter item ID to delete: ");
        int itemId = int.parse(stdin.readLineSync()!);
        items.removeWhere((item) => item.itemId == itemId);
        print("Item deleted successfully.");
        break;
      case 3:
        stdout.write("Enter auction ID to delete: ");
        int auctionId = int.parse(stdin.readLineSync()!);
        auctions.removeWhere((auction) => auction.auctionId == auctionId);
        print("Auction deleted successfully.");
        break;
      case 4:
        stdout.write("Enter bid ID to delete: ");
        int bidId = int.parse(stdin.readLineSync()!);
        bids.removeWhere((bid) => bid.bidId == bidId);
        print("Bid deleted successfully.");
        break;
      default:
        print("Invalid option.");
    }
  }

  void searchRecord(
    List<User> users,
    List<Item> items,
    List<Auction> auctions,
    List<Bid> bids,
  ) {
    print("\n=== Search Record ===");
    print("1. Search User");
    print("2. Search Item");
    print("3. Search Auction");
    print("4. Search Bid");
    stdout.write("Choose an option: ");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        stdout.write("Enter username to search: ");
        String username = stdin.readLineSync()!;
        users.where((user) => user.username.contains(username)).forEach(print);
        break;
      case 2:
        stdout.write("Enter item name to search: ");
        String name = stdin.readLineSync()!;
        items.where((item) => item.name.contains(name)).forEach(print);
        break;
      case 3:
        stdout.write("Enter auction ID to search: ");
        int auctionId = int.parse(stdin.readLineSync()!);
        auctions
            .where((auction) => auction.auctionId == auctionId)
            .forEach(print);
        break;
      case 4:
        stdout.write("Enter bid ID to search: ");
        int bidId = int.parse(stdin.readLineSync()!);
        bids.where((bid) => bid.bidId == bidId).forEach(print);
        break;
      default:
        print("Invalid option.");
    }
  }

  void mainMenu(
    List<User> users,
    List<Item> items,
    List<Auction> auctions,
    List<Bid> bids,
  ) {
    while (true) {
      displayMenu();
      int choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          displayListInfo(items, auctions);
          break;
        case 2:
          addNewData(users, items, auctions, bids);
          break;
        case 3:
          deleteRecord(users, items, auctions, bids);
          break;
        case 4:
          searchRecord(users, items, auctions, bids);
          break;
        case 5:
          print("Exiting program. Goodbye!");
          return;
        default:
          print("Invalid option. Please try again.");
      }
    }
  }

  mainMenu(users, items, auctions, bids);
}
