{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 8,
			"minor": 6,
			"revision": 0,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			60,
			60,
			1150,
			780
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
		"description": "Curso Max/MSP - Laboratorio 02: Timing, Scheduler, Delay vs Pipe, Deferlow",
		"digest": "",
		"tags": "curso max timing scheduler metro delay pipe deferlow",
		"style": "",
		"subpatcher_template": "",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"fontsize": 20,
					"id": "obj-1",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30,
						20,
						750,
						29
					],
					"text": "Laboratorio 02: El Scheduler de Max, Timing y Manejo de Colas"
				}
			},
			{
				"box": {
					"id": "obj-2",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						30,
						55,
						850,
						33
					],
					"text": "Explora los 4 escenarios de arquitectura temporal: Medición de Jitter, Pérdida de eventos en [delay] vs encolado en [pipe], Desacople de UI con [deferlow] y Sincronía polirrítmica limpia."
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontsize": 14,
					"id": "obj-100",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40,
						110,
						320,
						22
					],
					"text": "ESCENARIO 1: Medición de Jitter con [timer]"
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						140,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						40,
						180,
						69,
						22
					],
					"text": "metro 100"
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						40,
						215,
						48,
						22
					],
					"text": "t b b"
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"float",
						""
					],
					"patching_rect": [
						40,
						255,
						48,
						22
					],
					"text": "timer"
				}
			},
			{
				"box": {
					"format": 6,
					"id": "obj-105",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						295,
						65,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-106",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						115,
						280,
						190,
						47
					],
					"text": "Delta real en ms entre ticks. Con Overdrive encendido debería oscilar muy cerca de 100.0 ms."
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontsize": 14,
					"id": "obj-200",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400,
						110,
						360,
						22
					],
					"text": "ESCENARIO 2: Pérdida en [delay] vs Memoria en [pipe]"
				}
			},
			{
				"box": {
					"id": "obj-201",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						400,
						140,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-202",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						430,
						140,
						220,
						20
					],
					"text": "¡Presiona este botón 4 veces rápido!"
				}
			},
			{
				"box": {
					"id": "obj-203",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						400,
						185,
						71,
						22
					],
					"text": "delay 1000"
				}
			},
			{
				"box": {
					"id": "obj-204",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						400,
						225,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-205",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						430,
						225,
						180,
						20
					],
					"text": "[delay]: Solo sale 1 bang (los otros se cancelan)"
				}
			},
			{
				"box": {
					"id": "obj-206",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						650,
						140,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-207",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						650,
						185,
						68,
						22
					],
					"text": "pipe 0 1000"
				}
			},
			{
				"box": {
					"id": "obj-208",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						650,
						225,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-209",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						710,
						220,
						200,
						33
					],
					"text": "[pipe]: Salen todos los números con su cadencia y orden exactos."
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontsize": 14,
					"id": "obj-300",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40,
						380,
						370,
						22
					],
					"text": "ESCENARIO 3: Desacople de UI Pesada con [deferlow]"
				}
			},
			{
				"box": {
					"id": "obj-301",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						410,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-302",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						40,
						445,
						56,
						22
					],
					"text": "metro 20"
				}
			},
			{
				"box": {
					"id": "obj-303",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						40,
						480,
						48,
						22
					],
					"text": "t b b"
				}
			},
			{
				"box": {
					"id": "obj-304",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						40,
						520,
						54,
						22
					],
					"text": "deferlow"
				}
			},
			{
				"box": {
					"id": "obj-305",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						560,
						30,
						30
					]
				}
			},
			{
				"box": {
					"id": "obj-306",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						80,
						550,
						260,
						47
					],
					"text": "El botón gráfico parpadea sin bloquear el Scheduler rápido de 20 ms porque [deferlow] manda la orden de dibujo a la cola baja (qelem)."
				}
			},
			{
				"box": {
					"fontface": 1,
					"fontsize": 14,
					"id": "obj-400",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400,
						380,
						410,
						22
					],
					"text": "ESCENARIO 4: Reloj Polirrítmico por Subdivisión de Módulo"
				}
			},
			{
				"box": {
					"id": "obj-401",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						400,
						410,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-402",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						400,
						445,
						69,
						22
					],
					"text": "metro 125"
				}
			},
			{
				"box": {
					"id": "obj-403",
					"maxclass": "newobj",
					"numinlets": 5,
					"numoutlets": 4,
					"outlettype": [
						"int",
						"",
						"",
						"int"
					],
					"patching_rect": [
						400,
						480,
						75,
						22
					],
					"text": "counter 0 11"
				}
			},
			{
				"box": {
					"id": "obj-404",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						400,
						520,
						36,
						22
					],
					"text": "% 3"
				}
			},
			{
				"box": {
					"id": "obj-405",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						400,
						555,
						34,
						22
					],
					"text": "sel 0"
				}
			},
			{
				"box": {
					"id": "obj-406",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						400,
						590,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-407",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						430,
						590,
						150,
						20
					],
					"text": "Pulso 3 (Tresillo / Vals)"
				}
			},
			{
				"box": {
					"id": "obj-408",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						600,
						520,
						36,
						22
					],
					"text": "% 4"
				}
			},
			{
				"box": {
					"id": "obj-409",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						""
					],
					"patching_rect": [
						600,
						555,
						34,
						22
					],
					"text": "sel 0"
				}
			},
			{
				"box": {
					"id": "obj-410",
					"maxclass": "button",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						600,
						590,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-411",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						630,
						590,
						160,
						20
					],
					"text": "Pulso 4 (Cuaternario)"
				}
			},
			{
				"box": {
					"id": "obj-403-trig",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						400,
						505,
						45,
						22
					],
					"text": "t i i"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"destination": [
						"obj-102",
						0
					],
					"source": [
						"obj-101",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-103",
						0
					],
					"source": [
						"obj-102",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-104",
						0
					],
					"source": [
						"obj-103",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-104",
						1
					],
					"source": [
						"obj-103",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-105",
						0
					],
					"source": [
						"obj-104",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-203",
						0
					],
					"source": [
						"obj-201",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-204",
						0
					],
					"source": [
						"obj-203",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-207",
						0
					],
					"source": [
						"obj-206",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-208",
						0
					],
					"source": [
						"obj-207",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-302",
						0
					],
					"source": [
						"obj-301",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-303",
						0
					],
					"source": [
						"obj-302",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-304",
						0
					],
					"source": [
						"obj-303",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-305",
						0
					],
					"source": [
						"obj-304",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-402",
						0
					],
					"source": [
						"obj-401",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-403",
						0
					],
					"source": [
						"obj-402",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-405",
						0
					],
					"source": [
						"obj-404",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-406",
						0
					],
					"source": [
						"obj-405",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-409",
						0
					],
					"source": [
						"obj-408",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-410",
						0
					],
					"source": [
						"obj-409",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-403-trig",
						0
					],
					"source": [
						"obj-403",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-408",
						0
					],
					"source": [
						"obj-403-trig",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-404",
						0
					],
					"source": [
						"obj-403-trig",
						0
					]
				}
			}
		]
	}
}