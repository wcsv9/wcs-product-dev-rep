/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/licensePortions Copyright IBM Corp., 2009-2015.
 */

CKEDITOR.plugins.setLang( 'a11yhelp', 'nl',
{
	//do not translate anything with the form ${xxx} 
	
	title : "Help",
	contents : "Inhoudsopgave Help. Druk op Esc om dit venster te sluiten.",
	legend :
	[
		{
			name : "Toegankelijkheidsinstructies",
			items :
			[
				{
					name : "Werkbalk van editor",
					legend: "Druk op ${toolbarFocus} om naar de werkbalk te gaan. " +
						"Ga naar de volgende of vorige werkbalkgroep met de toets(en) Tab en Shift+Tab. " +
						"Ga naar de volgende of vorige werkbalkknop met de pijl naar rechts of links. " +
						"Druk op de spatiebalk of op Enter om de werkbalkknop te activeren.button."
				},

				{
					name: "Editorvenster",
					legend:
						"In een venster drukt u op de tabtoets om naar het volgende dialoogelement te gaan. Druk op Shift+Tab om naar het vorige element te gaan. Druk op Enter om de venstergegevens te verzenden en druk op Esc om het venster te annuleren. " +
						"Wanneer een venster meerdere tabs bevat, opent u de tablijst met Alt+F10 of met de tabtoets als onderdeel van de tabvolgorde voor het venster. " +
						"Als de tablijst is geopend, gebruikt u de pijlen naar links en naar rechts om naar het voorgaande en het volgende tabblad te gaan."
				},

				{
					name : "Contextmenu in editor",
					legend :
						"Druk op ${contextMenu} of op de toepassingssleutel om het contextmenu te openen. " +
						"Ga vervolgens naar de volgende menuoptie met de tabtoets of de pijl omlaag. " +
						"Ga naar een voorgaande optie met Shift+Tab of de pijl omhoog. " +
						"Druk op de spatiebalk of op Enter om de menuoptie te selecteren. " +
						"Open het submenu van de huidige optie met de spatietoets, de Enter-toets of de pijl naar rechts. " +
						"Ga terug naar de bovenliggende menuoptie met Esc of de pijl naar links. " +
						"Sluit het contextmenu met Esc."
				},

				{
					name : "Keuzelijst in editor",
					legend :
						"In een keuzelijst gaat u naar het volgende item in de lijst met de tabtoets of de pijl omlaag. " +
						"Ga naar het voorgaande lijstitem met Shift + Tab of de pijl omhoog. " +
						"Druk op de spatiebalk of op Enter om de lijstoptie te selecteren. " +
						"Druk op ESC om de keuzelijst te sluiten."
				},

				{
					name : "Balk voor elementenpad in editor (indien beschikbaar*)",
					legend :
						"Druk op ${elementsPathFocus} om naar de balk voor het elementenpad te gaan. " +
						"Ga naar de knop voor het volgende element met de tabtoets of de pijl naar rechts. " +
						"Ga naar de voorgaande knop met Shift+Tab of de pijl naar links. " +
						"Druk op de spatiebalk of op Enter om het element in de editor te selecteren."
				}
			]
		},
		{
			name : "Opdrachten",
			items :
			[
				{
					name : "  Ongedaan maken",
					legend : "Druk op ${undo}"
				},
				{
					name : "  Opnieuw uitvoeren",
					legend : "Druk op ${redo}"
				},
				{
					name : "  Vet weergeven",
					legend : "Druk op ${bold}"
				},
				{
					name : "  Cursief weergeven",
					legend : "Druk op ${italic}"
				},
				{
					name : "  Onderstrepen",
					legend : "Druk op ${underline}"
				},
				{
					name : "  Koppelen",
					legend : "Druk op ${link}"
				},
				{
					name : "  Werkbalk samenvouwen (indien beschikbaar*)",
					legend : "Druk op ${toolbarCollapse}"
				},
				{
					name: '  Naar voorliggende focuspositie',
					legend: 'Druk op ${accessPreviousSpace} om meteen vóór de cursor ruimte in te voegen in een onbereikbare focusruimte. ' +
						'Een onbereikbare focusruimte is een plaats in de editor waar u de cursor niet kunt plaatsen via ' + 
						'de muis of het toetsenbord. Gebruik deze opdracht bijvoorbeeld om content toe te voegen tussen twee aangrenzende tabelelementen.'
				},
				{
					name: '  Naar achterliggende focuspositie',
					legend: 'Druk op ${accessNextSpace} om meteen achter de cursor ruimte in te voegen in een onbereikbare focusruimte. ' +
						'Een onbereikbare focusruimte is een plaats in de editor waar u de cursor niet kunt plaatsen via ' +
						'de muis of het toetsenbord. Gebruik deze opdracht bijvoorbeeld om content toe te voegen tussen twee aangrenzende tabelelementen.'
				},
				{
					name : " Inspringing vergroten",
					legend : "Druk op ${indent}"
				},
				{
					name : " Inspringing verkleinen",
					legend : "Druk op ${outdent}"
				},				
				{
					name : " Tekstrichting van links naar rechts",
					legend : "Druk op ${bidiltr}"
				},
				{
					name : " Tekstrichting van rechts naar links",
					legend : "Druk op ${bidirtl}"
				},
				{
					name: ' Permanente pen',
					legend: 'Druk op ${ibmpermanentpen} (Alt+Cmd+T op MAC) in de editor om de permanente pen te (de)activeren.'
				},
				{
					name : "  Help bij toegankelijkheid",
					legend : "Druk op ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Opmerking",
			items :
			[
				{	
					name : "",
					legend : "* Sommige functies kunnen zijn uitgeschakeld door de beheerder."
				}
			]
		}
	],
	backspace: 'Spatie-terug',
	tab: 'Tab',
	enter: 'Enter',
	shift: 'Shift',
	ctrl: 'Ctrl',
	alt: 'Alt',
	pause: 'Pauze',
	capslock: 'Caps Lock',
	escape: 'Escape',
	pageUp: 'Page Up',
	pageDown: 'Page Down',
	end: 'End',
	home: 'Home',
	leftArrow: 'Pijl naar links',
	upArrow: 'Pijl omhoog',
	rightArrow: 'Pijl naar rechts',
	downArrow: 'Pijl omlaag',
	insert: 'Insert',
	'delete': 'Delete',
	leftWindowKey: 'Linker Windows-toets',
	rightWindowKey: 'Rechter Windows-toets',
	selectKey: 'Select-toets',
	numpad0: 'Numpad 0',
	numpad1: 'Numpad 1',
	numpad2: 'Numpad 2',
	numpad3: 'Numpad 3',
	numpad4: 'Numpad 4',
	numpad5: 'Numpad 5',
	numpad6: 'Numpad 6',
	numpad7: 'Numpad 7',
	numpad8: 'Numpad 8',
	numpad9: 'Numpad 9',
	multiply: 'Vermenigvuldigen',
	add: 'Optellen',
	subtract: 'Aftrekken',
	decimalPoint: 'Decimaalteken',
	divide: 'Delen',
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
	numLock: 'Num Lock',
	scrollLock: 'Scroll Lock',
	semiColon: 'Puntkomma',
	equalSign: 'Gelijkteken',
	comma: 'Komma',
	dash: 'Streepje',
	period: 'Punt',
	forwardSlash: 'Schuine streep naar voren',
	graveAccent: 'Accent naar linksonder',
	openBracket: 'Vierkant haakje openen',
	backSlash: 'Schuine streep naar links',
	closeBracket: 'Vierkant haakje sluiten',
	singleQuote: 'Enkel aanhalingsteken',
	
	ibm :
	{
		helpLinkDescription : "Meer Help-onderwerpen openen in een nieuw venster",
		helpLink : "Meer Help-onderwerpen"
	}

});

