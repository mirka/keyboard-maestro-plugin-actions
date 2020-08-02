const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const JSZip = require('jszip');
const plist = require('plist');

const SRC_DIR = 'src';
const DIST_DIR = 'dist';
const PLIST_NAME = 'Keyboard Maestro Action.plist';

// Author metadata
const AUTHOR = 'Lena Morita';
const AUTHOR_URL = 'https://github.com/mirka/keyboard-maestro-plugin-actions';

function buildAction(dir) {
	const zip = new JSZip();

	const plistSrc = plist.parse(
		fs.readFileSync(path.join(SRC_DIR, dir, PLIST_NAME), 'utf8')
	);
	const prettyFolderName = plistSrc.Name;

	fs.readdir(path.join(SRC_DIR, dir), (err, files) => {
		files.forEach(filename => {
			const filepath = path.join(SRC_DIR, dir, filename);

			switch (filename) {
			case '.DS_Store':
				break;
			case PLIST_NAME: {
				const plistDist = {
					...plistSrc,
					Author: AUTHOR,
					URL: AUTHOR_URL,
				};
				zip.folder(prettyFolderName).file(PLIST_NAME, plist.build(plistDist));
				break;
			}
			case 'default.applescript':
			case 'default.js': {
				const builtFile = path.join(DIST_DIR, `${dir}_default.scpt`);
				const lang = /.js$/.test(filename) ? 'JavaScript' : 'AppleScript';

				execSync(`osacompile -l ${lang} -o ${builtFile} ${filepath}`);

				const data = fs.readFileSync(builtFile);
				zip.folder(prettyFolderName).file('default.scpt', data);

				fs.unlinkSync(builtFile);
				break;
			}
			default: {
				const data = fs.readFileSync(filepath);
				zip.folder(prettyFolderName).file(filename, data);
				break;
			}
			}
		});

		zip
			.generateNodeStream({ type: 'nodebuffer', streamFiles: true })
			.pipe(fs.createWriteStream(path.join(DIST_DIR, `${dir}.zip`)))
			.on('finish', function () {
				console.log(`Built action "${prettyFolderName}"`);
			});
	});
}

fs.rmdirSync(DIST_DIR, { recursive: true });
fs.mkdirSync(DIST_DIR);
console.log(`Reset ${DIST_DIR}`);

fs.readdir(SRC_DIR, { withFileTypes: true }, (err, subdirs) => {
	if (err) throw err;

	subdirs
		.filter(item => item.isDirectory())
		.map(subdir => subdir.name)
		.forEach(buildAction);
});
