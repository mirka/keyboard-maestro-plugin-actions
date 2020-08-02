function BTTHud(options) {
	const BTT = Application('BetterTouchTool');

	const {
		title = 'HUD',
		detail,
		duration = '1.5',
		backgroundColor = '0, 0, 0',
		opacity = '180',
		slideDirection = 0,
	} = options;

	const hudConfig = {
		'BTTActionHUDTitle': title,
		'BTTActionHUDDetail': detail,
		'BTTActionHUDDuration': duration,
		'BTTActionHUDBackground': [backgroundColor, opacity].join(','),
		'BTTActionHUDSlideDirection': slideDirection,
	};

	const actionConfig = {
		'BTTPredefinedActionType': 254,
		'BTTHUDActionConfiguration': JSON.stringify(hudConfig),
	};

	BTT.trigger_action(JSON.stringify(actionConfig));
}

function parseParam(name) {
	const app = Application.currentApplication();
	app.includeStandardAdditions = true;
	const val = app.doShellScript(`echo $KMPARAM_${name}`);
	return val === '' ? undefined : val;
}

const opacityValues = {
	'Default': '180',
	'Light': '100',
	'Transparent': '0',
	'Opaque': '255',
};

const slideValues = {
	'None': 0,
	'Up': 1,
	'Down': 2,
	'Left': 3,
	'Right': 4,
};

BTTHud({
	title: parseParam('Title'),
	detail: parseParam('Detail'),
	duration: parseParam('Duration'),
	backgroundColor: parseParam('Background'),
	opacity: opacityValues[parseParam('Opacity')],
	slideDirection: slideValues[parseParam('Slide')],
});
