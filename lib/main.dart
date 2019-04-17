import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tip_calculator/tip_model.dart';

void main() {
	SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
		.then((_) => runApp(TipCalculatorApp()));
}

final h1Bold = TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold);
final h2 = TextStyle(fontSize: 40.0);
final h2Bold = h2.copyWith(fontWeight: FontWeight.bold);
final h4 = TextStyle(fontSize: 25.0);

class TipCalculatorApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Tip Calculator',
			theme: ThemeData(
				primaryColor: Color.fromARGB(0xff, 0x37, 0x47, 0x4f),
				primaryColorDark: Color.fromARGB(0xff, 0x10, 0x20, 0x27),
				scaffoldBackgroundColor: Color.fromARGB(0xff, 0x62, 0x72, 0x7b),
				textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
			home: TipCalculatorPage(),
		);
	}
}

class TipCalculatorPage extends StatefulWidget {
	TipCalculatorPage({Key key}) : super(key: key);

	@override
	_TipCalculatorPageState createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage> {
	final _model = TipModel();
	final _controller = TextEditingController();
	final _focusNode = FocusNode();

	@override
	void initState() {
		super.initState();
		_focusNode.addListener(() {
			if (_focusNode.hasFocus) {
				_controller.clear();
				_updateTotalCost("0");
			}
		});
	}

	void _incrementBuddies() {
		setState(() {
			_model.incrementBuddies();
		});
	}

	void _decrementBuddies() {
		setState(() {
			_model.decrementBuddies();
		});
	}

	void _incrementTip() {
		setState(() {
			_model.incrementTip();
		});
	}

	void _decrementTip() {
		setState(() {
			_model.decrementTip();
		});
	}

	void _updateTotalCost(String amount) {
		setState(() {
			_model.updateTotalCost(double.tryParse(amount) ?? 0.0);
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			resizeToAvoidBottomPadding: false,
			appBar: AppBar(
				title: Text('Tip Calculator'),
			),
			body: Column(
				mainAxisSize: MainAxisSize.max,
				children: <Widget>[
					_buildShareWidget(),
					Expanded(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: <Widget>[
								_buildExpenseWidget(),
								_buildTipWidget(),
								_buildBuddyWidget(),
							],
						),
					),
				],
			),
		);
	}

	Widget _buildShareWidget() {
		return Container(
			padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
			width: double.infinity,
			color: Colors.white,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						_model.sharePerBuddy,
						style: h1Bold.apply(color: Theme.of(context).scaffoldBackgroundColor),
					),
					Text(
						'Per Buddy',
						style: h2.apply(color: Theme.of(context).scaffoldBackgroundColor),
					)
				],
			),
		);
	}

	Widget _buildExpenseWidget() {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				Text(
					'Total Damage (\$)',
					style: h4,
				),
				TextField(
					controller: _controller,
					focusNode: _focusNode,
					onChanged: _updateTotalCost,
					keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
					textAlign: TextAlign.center,
					style: h2Bold,
					decoration: InputDecoration(
						border: InputBorder.none,
					),
				),
			],
		);
	}

	Widget _buildTipWidget() {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				Text(
					'Generous Tip',
					style: h4,
				),
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						IconButton(
							icon: Icon(Icons.remove),
							onPressed: _decrementTip,
							iconSize: h2Bold.fontSize,
							color: Colors.white,
						),
						Text(
							_model.totalTip,
							style: h2Bold,
						),
						IconButton(
							icon: Icon(Icons.add),
							onPressed: _incrementTip,
							iconSize: h2Bold.fontSize,
							color: Colors.white,
						),
					],
				),
			],
		);
	}

	Widget _buildBuddyWidget() {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				Text(
					'Buddies',
					style: h4,
				),
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						IconButton(
							icon: Icon(Icons.remove),
							onPressed: _decrementBuddies,
							iconSize: h2Bold.fontSize,
							color: Colors.white,
						),
						Text(
							_model.totalBuddies,
							style: h2Bold,
						),
						IconButton(
							icon: Icon(Icons.add),
							onPressed: _incrementBuddies,
							iconSize: h2Bold.fontSize,
							color: Colors.white,
						),
					],
				),
			],
		);
	}
}
