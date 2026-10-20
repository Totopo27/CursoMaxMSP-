{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 9,
			"minor": 0,
			"revision": 0,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			80,
			80,
			1150,
			850
		],
		"bglocked": 0,
		"openinpresentation": 0,
		"default_fontsize": 12,
		"default_fontface": 0,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [
			15,
			15
		],
		"gridsnaponopen": 1,
		"objectsnaponopen": 1,
		"statusbarvisible": 2,
		"toolbarvisible": 1,
		"lefttoolbarpinned": 0,
		"toptoolbarpinned": 0,
		"righttoolbarpinned": 0,
		"bottomtoolbarpinned": 0,
		"toolbars_unpinned_last_save": 0,
		"tallnewobj": 0,
		"boxanimatetime": 200,
		"enablehscroll": 1,
		"enablevscroll": 1,
		"devicewidth": 0,
		"description": "Laboratorio 12: Filtrado Digital (biquad~, lores~, svf~)",
		"digest": "",
		"tags": "Max MSP Filters biquad lores svf filtergraph",
		"style": "",
		"subpatcher_template": "",
		"assistshowspreset": 0,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						25,
						20,
						750,
						30
					],
					"text": "LABORATORIO 12: FILTRADO DIGITAL (BIQUAD~, LORES~, SVF~)",
					"fontname": "Arial Bold",
					"fontsize": 18
				}
			},
			{
				"box": {
					"id": "obj-2",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						25,
						55,
						850,
						47
					],
					"text": "Procesamiento sustractivo en tiempo real con 3 topologías de filtro.\n1. filtergraph~ + biquad~: Filtro IIR paramétrico universal (Paso-bajo, Paso-alto, Pasa-banda, Notch).\n2. lores~: Filtro resonante analógico de 2 polos capaz de auto-oscilación senoidal pura.\n3. svf~: State Variable Filter de Chamberlin con 4 salidas de fase coherente simultáneas."
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						35,
						120,
						150,
						20
					],
					"text": "FUENTE DE AUDIO",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "radiogroup",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						35,
						145,
						120,
						34
					],
					"size": 2,
					"value": 0
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						145,
						140,
						20
					],
					"text": "0: Sierra (saw~ 130Hz)"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						160,
						140,
						20
					],
					"text": "1: Ruido Blanco"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						200,
						66,
						22
					],
					"text": "saw~ 130."
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						120,
						200,
						44,
						22
					],
					"text": "noise~"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						240,
						78,
						22
					],
					"text": "selector~ 2 1"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						250,
						120,
						220,
						20
					],
					"text": "1. BIQUAD~ + FILTERGRAPH~",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"autoout": 1,
					"fontname": "Arial",
					"id": "obj-11",
					"maxclass": "filtergraph~",
					"nfilters": 1,
					"numinlets": 8,
					"numoutlets": 7,
					"outlettype": [
						"list",
						"float",
						"float",
						"float",
						"float",
						"list",
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						250,
						145,
						280,
						140
					],
					"setfilter": [
						0,
						1,
						1,
						0,
						0,
						800,
						1,
						2.5,
						0,
						0,
						0,
						0,
						0,
						0
					]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						250,
						305,
						71.5,
						22
					],
					"text": "biquad~"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						570,
						120,
						220,
						20
					],
					"text": "2. LORES~ (Auto-Oscilación)",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						570,
						145,
						70,
						22
					],
					"minimum": 20,
					"maximum": 10000
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						645,
						145,
						95,
						20
					],
					"text": "Frecuencia (Hz)"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						570,
						180,
						60,
						22
					],
					"minimum": 0,
					"maximum": 0.9999
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						635,
						180,
						140,
						20
					],
					"text": "Resonancia (0. - 0.999)"
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						570,
						220,
						95,
						22
					],
					"text": "lores~ 800. 0.8"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						820,
						120,
						250,
						20
					],
					"text": "3. SVF~ (STATE VARIABLE FILTER)",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 4,
					"outlettype": [
						"signal",
						"signal",
						"signal",
						"signal"
					],
					"patching_rect": [
						820,
						220,
						110,
						22
					],
					"text": "svf~ 1200. 0.5"
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						820,
						255,
						270,
						20
					],
					"text": "Outs: 1:Lowpass, 2:Highpass, 3:Bandpass, 4:Notch"
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						35,
						360,
						250,
						20
					],
					"text": "SELECTOR DE TOPOLOGÍA AUDIBLE",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "radiogroup",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						35,
						390,
						150,
						50
					],
					"size": 3,
					"value": 0
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						390,
						110,
						20
					],
					"text": "0: biquad~"
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						405,
						110,
						20
					],
					"text": "1: lores~"
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						420,
						110,
						20
					],
					"text": "2: svf~ (Lowpass)"
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"numinlets": 4,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						250,
						450,
						100,
						22
					],
					"text": "selector~ 3 1"
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						35,
						450,
						29.5,
						22
					],
					"text": "+ 1"
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "spectroscope~",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400,
						500,
						500,
						180
					]
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						250,
						500,
						47,
						22
					],
					"text": "*~ 0.3"
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "gain~",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						250,
						540,
						120,
						25
					]
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						250,
						580,
						45,
						45
					]
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						570,
						95,
						60,
						22
					],
					"text": "loadbang"
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						570,
						120,
						45,
						22
					],
					"text": "800."
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						640,
						120,
						32,
						22
					],
					"text": "0.8"
				}
			},
			{
				"box": {
					"id": "obj-33-trig",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						40,
						140,
						45,
						22
					],
					"text": "t b b"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [
						"obj-9",
						0
					],
					"source": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-9",
						1
					],
					"source": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-9",
						2
					],
					"source": [
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-12",
						0
					],
					"order": 2,
					"source": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						0
					],
					"order": 1,
					"source": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-20",
						0
					],
					"order": 0,
					"source": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-12",
						0
					],
					"source": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						1
					],
					"source": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						1
					],
					"order": 1,
					"source": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-20",
						1
					],
					"order": 0,
					"source": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-18",
						2
					],
					"order": 1,
					"source": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-20",
						2
					],
					"order": 0,
					"source": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						2
					],
					"source": [
						"obj-18",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						3
					],
					"source": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-28",
						0
					],
					"source": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-27",
						0
					],
					"source": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-30",
						0
					],
					"source": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-29",
						0
					],
					"order": 0,
					"source": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-31",
						0
					],
					"order": 1,
					"source": [
						"obj-30",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-32",
						1
					],
					"order": 0,
					"source": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-32",
						0
					],
					"order": 1,
					"source": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-14",
						0
					],
					"source": [
						"obj-34",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-16",
						0
					],
					"source": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-33-trig",
						0
					],
					"source": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-35",
						0
					],
					"source": [
						"obj-33-trig",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-34",
						0
					],
					"source": [
						"obj-33-trig",
						0
					]
				}
			}
		]
	}
}