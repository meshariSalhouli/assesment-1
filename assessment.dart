class Item {
  String name;
  double price;

  Item(this.name, this.price);
}

class ItemStock {
  Item item;
  int stock;

  ItemStock(this.item, this.stock);

  bool isInStock() {
    return stock > 0;
  }
}

class VendingMachine {
  final List<String> items;
  Map ItemStock = {};

  double balance = 0.0;

  VendingMachine(this.items);

  void addItem(Item item, int stock) {
    if (ItemStock.containsKey(item.name)) {
      ItemStock[item.name]!['stock'] += stock;
    } else {
      ItemStock[item.name] = {'item': item, 'stock': stock};
    }
    print('Added ${item.name} with stock: $stock.');
  }

  double? selectItem(String itemName) {
    if (ItemStock.containsKey(itemName)) {
      var itemInfo = ItemStock[itemName]!;
      if (itemInfo['stock'] > 0) {
        print(
            '${itemName} is available at \$${itemInfo['item'].price.toStringAsFixed(2)}.');
        return itemInfo['item'].price;
      } else {
        print('$itemName is out of stock.');
        return 0;
      }
    } else {
      print('$itemName not found in the vending machine.');
      return 0;
    }
  }

  void insertMoney(double amount) {
    if (amount > 0) {
      balance += amount;
      print(
          'You have inserted \$${amount.toStringAsFixed(2)}. Current balance: \$${balance.toStringAsFixed(2)}.');
    } else {
      print('Please insert a valid amount.');
    }
  }

  bool dispenseItem(String itemName) {
    if (ItemStock.containsKey(itemName)) {
      var itemInfo = ItemStock[itemName]!;
      if (itemInfo['stock'] > 0) {
        if (balance >= itemInfo['item'].price) {
          balance -= itemInfo['item'].price;
          itemInfo['stock'] -= 1;
          print('Dispensing $itemName.');
          if (balance > 0) {
            getChange;
            ();
          }
          return true;
        } else {
          print('Insufficient balance to purchase this item.');
          return false;
        }
      } else {
        print('$itemName is out of stock.');
        return false;
      }
    } else {
      print('$itemName not found in the vending machine.');
      return false;
    }
  }

  getChange() {
    if (balance > 0) {
      print('Returning change: \$${balance.toStringAsFixed(2)}.');
      balance = 0.0;
    } else {
      print('No change to return.');
    }
  }
}

void main() {
  VendingMachine vendingMachine = VendingMachine([]);

  Item Soda = Item('Soda', 2.50);
  Item chips = Item('Chips', 1.50);
  Item candy = Item('Candy', 1.00);

  vendingMachine.addItem(Soda, 10);
  vendingMachine.addItem(chips, 5);
  vendingMachine.addItem(candy, 0);

  vendingMachine.insertMoney(3.00);
  vendingMachine.dispenseItem('Chips');
  vendingMachine.dispenseItem('Soda');
  vendingMachine.dispenseItem('Candy');
  vendingMachine.insertMoney(0.50);
  vendingMachine.dispenseItem('Candy');

  vendingMachine.dispenseItem('Candy');
  vendingMachine.dispenseItem('Candy');

  double change = vendingMachine.getChange();
  print('Returning change: \$${change.toStringAsFixed(2)}');
}
