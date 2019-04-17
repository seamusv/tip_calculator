class TipModel {
  double _totalCost = 0.0;
  int _totalBuddies = 1;
  int _totalTip = 10;

  String get sharePerBuddy => '\$${((_totalCost * (1 + _totalTip / 100)) / _totalBuddies).toStringAsFixed(2)}';

  String get totalBuddies => _totalBuddies.toString();

  String get totalCost => '\$${_totalCost.toStringAsFixed(2)}';

  String get totalTip => '${_totalTip.toString()}%';

  void updateTotalCost(double newCost) => _totalCost = newCost;

  void incrementBuddies() => _totalBuddies += 1;

  void decrementBuddies() {
    if (_totalBuddies > 1) _totalBuddies -= 1;
  }

  void incrementTip() => _totalTip += 5;

  void decrementTip() {
  	if (_totalTip > 0) _totalTip -= 5;
	}
}
