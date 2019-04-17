import 'package:flutter_test/flutter_test.dart';

import 'package:tip_calculator/tip_model.dart';

void main() {
	group('calculate share', () {
		test('Default is zero', () {
			final model = TipModel();
			expect(model.sharePerBuddy, '\$0.00');
			expect(model.totalTip, '10%');
			expect(model.totalBuddies, '1');
		});

		test('Returns the correct calculation', () {
			final model = TipModel();
			model.updateTotalCost(250.00);
			expect(model.sharePerBuddy, '\$275.00');
		});

		test('Returns the correct calculation with 3 buddies', () {
			final model = TipModel();
			model.updateTotalCost(250.00);
			model.incrementBuddies();
			model.incrementBuddies();
			expect(model.sharePerBuddy, '\$91.67');
			expect(model.totalBuddies, '3');
		});
	});

	group('test assertions', () {
		test('Able to increase buddies', () {
			final model = TipModel();
			expect(model.totalBuddies, '1');

			model.incrementBuddies();
			model.incrementBuddies();
			model.incrementBuddies();
			expect(model.totalBuddies, '4');
		});

		test('Not able to reduce buddies below 1', () {
			final model = TipModel();
			expect(model.totalBuddies, '1');

			model.incrementBuddies();
			expect(model.totalBuddies, '2');

			model.decrementBuddies();
			model.decrementBuddies();
			model.decrementBuddies();
			model.decrementBuddies();
			expect(model.totalBuddies, '1');
		});

		test('Not able to reduce tip below 0%', () {
			final model = TipModel();
			expect(model.totalTip, '10%');

			model.decrementTip();
			expect(model.totalTip, '5%');

			model.decrementTip();
			model.decrementTip();
			model.decrementTip();
			model.decrementTip();
			expect(model.totalTip, '0%');
		});
	});
}
