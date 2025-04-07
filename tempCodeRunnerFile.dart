case 2:
        stdout.write("Enter seller ID: ");
        int sellerId = int.parse(stdin.readLineSync()!);
        if (!users.any((user) => user.id == sellerId && user.role == UserRole.seller)) {
          print("Error: Seller ID $sellerId is not registered or is not a seller.");
          return;
        }
        stdout.write("Enter item name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter description: ");
        String description = stdin.readLineSync()!;
        stdout.write("Enter starting price (or leave blank): ");
        String? startingPriceInput = stdin.readLineSync();
        double? startingPrice =
        startingPriceInput != null && startingPriceInput.isNotEmpty
            ? double.parse(startingPriceInput)
            : null;

        print("Do you want this item to be sold at a fixed price or via auction?");
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
          startingPrice,
          fixedPrice,
          ItemStatus.available,
        ),
          );
          print("Item added successfully with a fixed price.");
        } else if (itemChoice == 2) {
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
        startingPrice,
        null,
        ItemStatus.auction,
          );
          items.add(newItem);

          auctions.add(Auction(newItem.itemId, startTime, endTime, startingBid, true));
          print("Item added successfully and listed for auction.");
        } else {
          print("Invalid option. Item not added.");
        }
        break;