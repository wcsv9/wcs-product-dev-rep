/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/licensePortions Copyright IBM Corp., 2009-2015.
 */

CKEDITOR.plugins.setLang( 'a11yhelp', 'eu',
{
	//do not translate anything with the form ${xxx} 
	
	title : "Laguntza",
	contents : "Laguntza edukiak. Sakatu IHES elkarrizketa-koadro hau ixteko.",
	legend :
	[
		{
			name : "Erabilerraztasunari buruzko argibideak",
			items :
			[
				{
					name : "Editoreko tresna-barra",
					legend: 
						"Sakatu ${toolbarFocus} tresna-barrara joateko. " +
						"Tresna-barran, TAB eta MAIUS-TAB erabiliz aurreko eta hurrengo multzoetara joan zaitezke. " +
						"Erabili ESKUINERA eta EZKERRERA geziak hurrengo eta aurreko botoietara joateko. " +
						"Sakatu ZURIUNE barra edo SARTU tekla tresna-barrako botoia aktibatzeko."
				},

				{
					name : "Editoreko elkarrizketa-koadroa",
					legend :
						"Elkarrizketa-koadroan, sakatu TAB koadroko hurrengo eremura joateko, sakatu MAIUS + TAB aurrekora joateko, sakatu SARTU bidaltzeko eta sakatu IHES elkarrizketa-koadroa uzteko. " +
						"Fitxa-orri aniztun elkarrizketa-koadroetan, ALT + F10 sakatuz fitxa zerrendara joan zaitezke. " +
						"Hor TAB edo ESKUIN gezia sakatuz hurrengo fitxara mugi zaitezke. " +
						"Aurreko fitxara itzultzeko, sakatu MAIUS + TAB edo EZKERRERA gezia. " +
						"Fitxa-orria hautatzeko, sakatu ZURIUNE edo SARTU tekla."
				},

				{
					name : "Editoreko laster-menua",
					legend :
						"Sakatu ${contextMenu} edo MENU tekla laster-menua irekitzeko. " +
						"Han, TAB edo BEHERA gezia sakatuz menuaren hurrengo aukerara joan zaitezke. " +
						"MAIUS+TAB teklekin edo GORA geziarekin aurreko aukerara joan zaitezke. " +
						"Aukera hautatzeko sakatu ZURIUNE edo SARTU tekla. " +
						"Oraingo aukeraren azpimenua ireki nahi baduzu, sakatu ESKUINERA gezia, ZURIUNE edo SARTU teklak. " +
						"Itzuli menu gurasora IHES edo EZKERRERA gezia sakatuz. " +
						"Sakatu IHES laster-menua ixteko."
				},

				{
					name : "Editoreko zerrenda-koadroa",
					legend :
						"Zerrenda-koadro baten barruan zaudenean, sakatu TAB tekla edo BEHERA gezia zerrendako hurrengo elementura joateko. " +
						"Zerrendako aurreko elementura joateko, sakatu MAIUS + TAB edo GORA gezia. " +
						"Zerrendako aukera bat hautatzeko, sakatu ZURIUNE edo SARTU tekla. " +
						"Sakatu IHES zerrenda-koadroa itxi nahi baduzu."
				},

				{
					name : "Editoreko elementuen bide-izenen barra (erabilgarri badago*)",
					legend :
						"Sakatu ${elementsPathFocus} elementuen bide-izenen barrara joateko. " +
						"Hurrengo elementura joateko, erabili TAB edo ESKUINERA teklak. " +
						"MAIUS+TAB teklekin edo EZKERRERA geziarekin aurreko botoira joan zaitezke. " +
						"Editoreko elementu bat hautatzeko sakatu ZURIUNE edo SARTU tekla."
				}
			]
		},
		{
			name : "Komandoak",
			items :
			[
				{
					name : " Desegin komandoa",
					legend : "Sakatu ${undo}"
				},
				{
					name : " Berregin komandoa",
					legend : "Sakatu ${redo}"
				},
				{
					name : " Lodia komandoa",
					legend : "Sakatu ${bold}"
				},
				{
					name : " Etzana komandoa",
					legend : "Sakatu ${italic}"
				},
				{
					name : " Azpimarratu komandoa",
					legend : "Sakatu ${underline}"
				},
				{
					name : " Estekatu komandoa",
					legend : "Sakatu ${link}"
				},
				{
					name : " 'Tolestu tresna-barra' komandoa (erabilgarri badago*)",
					legend : "Sakatu ${toolbarCollapse}"
				},
				{
					name: ' \'Sartu aurreko foku-espazioan\' komandoa',
					legend: 'Sakatu ${accessPreviousSpace} kurtsorearen aurrean dagoen foku-espazio iristezin batean zuriune bat sartzeko. ' +
						'Foku-espazio iristezin bat, kurtsorea jarri ezin duzun toki bat da, ' + 
						'sagua edo teklatua erabiltzen baduzu. Adibidez, komando hau ondoko bi taula elementuren artean edukia txertatzeko erabil dezakezu.'
				},
				{
					name: ' \'Sartu atzeko foku-espazioan\' komandoa',
					legend: 'Sakatu ${accessNextSpace} kurtsorearen atzean dagoen foku-espazio iristezin batean zuriune bat sartzeko. ' +
						'Foku-espazio iristezin bat kurtsorea jarri ezin duzun toki bat da, ' +
						'sagua edo teklatua erabiltzen baduzu. Adibidez, komando hau ondoko bi taula elementuren artean edukia txertatzeko erabil dezakezu.'
				},
				{
					name : " Handitu koska",
					legend : "Sakatu ${indent}"
				},
				{
					name : " Txikitu koska",
					legend : "Sakatu ${outdent}"
				},				
				{
					name : " Testu-norabidea ezkerretik eskuinera",
					legend : "Sakatu ${bidiltr}"
				},
				{
					name : " Testu norabidea eskuinetik ezkerrera",
					legend : "Sakatu ${bidirtl}"
				},
				{
					name: ' Arkatz iraunkorra',
					legend: 'Editorean, sakatu ${ibmpermanentpen} (Alt+Cmd+T MACen) arkatz iraunkorra aktibatzeko/desaktibatzeko. '
				},
				{
					name : " Erabilerraztasunerako laguntza",
					legend : "Sakatu ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Oharra",
			items :
			[
				{	
					name : "",
					legend : "* Zure administratzaileak zenbait ezaugarri desgaitu ditzake."
				}
			]
		}
	],
	backspace: 'Atzera',
	tab: 'Tabuladorea',
	enter: 'Sartu',
	shift: 'Maius',
	ctrl: 'Ktrl',
	alt: 'Alt',
	pause: 'Pausa',
	capslock: 'Maius Blok',
	escape: 'Ihes',
	pageUp: 'Orrialdea gora',
	pageDown: 'Orrialdea behera',
	end: 'Amaiera',
	home: 'Hasiera',
	leftArrow: 'Ezkerrera gezia',
	upArrow: 'Gora gezia',
	rightArrow: 'Eskuinera gezia',
	downArrow: 'Behera gezia',
	insert: 'Txertatu',
	'delete': 'Ezabatu',
	leftWindowKey: 'Ezkerreko Windows tekla',
	rightWindowKey: 'Eskuineko Windows tekla',
	selectKey: 'Hautatu tekla',
	numpad0: 'Teklatu numerikoko 0',
	numpad1: 'Teklatu numerikoko 1',
	numpad2: 'Teklatu numerikoko 2',
	numpad3: 'Teklatu numerikoko 3',
	numpad4: 'Teklatu numerikoko 4',
	numpad5: 'Teklatu numerikoko 5',
	numpad6: 'Teklatu numerikoko 6',
	numpad7: 'Teklatu numerikoko 7',
	numpad8: 'Teklatu numerikoko 8',
	numpad9: 'Teklatu numerikoko 9',
	multiply: 'Biderkatu',
	add: 'Gehitu',
	subtract: 'Kendu',
	decimalPoint: 'Hamartarren koma',
	divide: 'Zatitu',
	f1: 'F1',
	f2: 'F2',
	f3: 'F3',
	f4: 'F4',
	f5: 'F5',
	f6: 'F6',
	f7: 'F7',
	f8: 'F8',
	f9: 'F9',
	f10: 'F10',
	f11: 'F11',
	f12: 'F12',
	numLock: 'Blok Zenb',
	scrollLock: 'Blok Korr',
	semiColon: 'Puntu eta koma',
	equalSign: 'Berdin',
	comma: 'Koma',
	dash: 'Marratxoa',
	period: 'Puntua',
	forwardSlash: 'Barra',
	graveAccent: 'Azentu kamutsa',
	openBracket: 'Ireki parentesia',
	backSlash: 'Alderantzizko barra',
	closeBracket: 'Itxi parentesia',
	singleQuote: 'Komatxo bakuna',
	
	ibm :
	{
		helpLinkDescription : "Laguntza gai gehiago leiho berri batean ireki.",
		helpLink : "Laguntza gai gehiago"
	}

});

