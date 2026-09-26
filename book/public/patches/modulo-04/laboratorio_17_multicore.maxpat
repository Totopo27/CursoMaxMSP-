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
			880
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
		"description": "Laboratorio 17: Procesamiento Multicore Paralelo con poly~ @parallel 1",
		"digest": "",
		"tags": "Max MSP poly parallel multicore benchmark SMP",
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
						780,
						30
					],
					"text": "LABORATORIO 17: PROCESAMIENTO PARALELO MULTICORE (POLY~ @PARALLEL 1)",
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
						880,
						47
					],
					"text": "Banco de pruebas comparativo de multiprocesamiento simétrico (SMP).\nEjecución de 16 voces con filtros cuádruples no lineales en serie.\nComparación directa de estabilidad y balance de carga entre procesamiento Monohilo vs Multihilo Paralelo."
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
						250,
						20
					],
					"text": "GENERADOR DE ACORDE MASIVO (16 NOTAS)",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						35,
						150,
						35,
						35
					]
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						75,
						158,
						180,
						20
					],
					"text": "Disparar Acorde de 16 Notas"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						35,
						200,
						310,
						22
					],
					"text": "36 100, 40 100, 43 100, 47 100, 48 100, 52 100, 55 100, 59 100"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						35,
						230,
						310,
						22
					],
					"text": "60 100, 64 100, 67 100, 71 100, 72 100, 76 100, 79 100, 83 100"
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						35,
						270,
						150,
						20
					],
					"text": "CONMUTADOR A/B",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "radiogroup",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						35,
						300,
						250,
						34
					],
					"size": 2,
					"value": 1
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						300,
						200,
						20
					],
					"text": "0: Monohilo Serial (poly~ 16)"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						70,
						315,
						240,
						20
					],
					"text": "1: Multihilo (@parallel 1 @threadcount 4)"
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						360,
						150,
						22
					],
					"text": "poly~ voz_dsp_pesada 16"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						250,
						360,
						275,
						22
					],
					"text": "poly~ voz_dsp_pesada 16 @parallel 1 @threadcount 4"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						420,
						78,
						22
					],
					"text": "selector~ 2 2"
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						35,
						390,
						29.5,
						22
					],
					"text": "+ 1"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						460,
						47,
						22
					],
					"text": "*~ 0.2"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "gain~",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						""
					],
					"parameter_enable": 0,
					"patching_rect": [
						35,
						500,
						130,
						25
					]
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						35,
						545,
						45,
						45
					]
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "spectroscope~",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400,
						440,
						480,
						170
					]
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400,
						410,
						260,
						20
					],
					"text": "MONITOREO DE ESPECTRO COMBINADO",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-4-trig",
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
						"obj-12",
						0
					],
					"order": 1,
					"source": [
						"obj-6",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-13",
						0
					],
					"order": 0,
					"source": [
						"obj-6",
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
					"order": 1,
					"source": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-13",
						0
					],
					"order": 0,
					"source": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-15",
						0
					],
					"source": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-14",
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
						"obj-14",
						2
					],
					"source": [
						"obj-13",
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
						"obj-14",
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
						"obj-15",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-17",
						0
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
						"obj-19",
						0
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
						"obj-18",
						1
					],
					"order": 0,
					"source": [
						"obj-17",
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
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-4-trig",
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
						"obj-7",
						0
					],
					"source": [
						"obj-4-trig",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-6",
						0
					],
					"source": [
						"obj-4-trig",
						0
					]
				}
			}
		]
	}
}