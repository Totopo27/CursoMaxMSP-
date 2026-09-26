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
			80,
			80,
			1100,
			720
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
		"description": "Curso Max/MSP - Laboratorio 01 Expandido: 3 Escenarios Clave de Inlets y Trigger",
		"digest": "",
		"tags": "curso max fundamentos trigger cold-hot",
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
						700,
						29
					],
					"text": "Laboratorio 01: Inlets Fríos vs Calientes — 3 Escenarios de la Vida Real"
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
						800,
						33
					],
					"text": "Compara el patrón incorrecto (dependencia visual / valores desactualizados) vs el patrón arquitectónico correcto (orquestación con [trigger])."
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
						300,
						22
					],
					"text": "ESCENARIO 1: Operaciones Aritméticas (+)"
				}
			},
			{
				"box": {
					"id": "obj-101",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40,
						135,
						130,
						20
					],
					"text": "🔴 Incorrecto (Riesgo)",
					"textcolor": [
						0.8,
						0.2,
						0.2,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-102",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						160,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-103",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						40,
						200,
						31,
						22
					],
					"text": "+ 0"
				}
			},
			{
				"box": {
					"id": "obj-104",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						235,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-105",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						190,
						135,
						150,
						20
					],
					"text": "🟢 Correcto ([t i i])",
					"textcolor": [
						0.2,
						0.7,
						0.2,
						1
					]
				}
			},
			{
				"box": {
					"id": "obj-106",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						190,
						160,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-107",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						190,
						195,
						48,
						22
					],
					"text": "t i i"
				}
			},
			{
				"box": {
					"id": "obj-108",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						190,
						230,
						48,
						22
					],
					"text": "+"
				}
			},
			{
				"box": {
					"id": "obj-109",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						190,
						265,
						50,
						22
					]
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
						310,
						22
					],
					"text": "ESCENARIO 2: Registro de Estado ([int] / [i])"
				}
			},
			{
				"box": {
					"id": "obj-201",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400,
						135,
						310,
						33
					],
					"text": "Inlet derecho guarda sin disparar. Inlet izquierdo (bang o int) dispara el contenido hacia el outlet."
				}
			},
			{
				"box": {
					"id": "obj-202",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						490,
						180,
						45,
						22
					],
					"text": "set 100"
				}
			},
			{
				"box": {
					"id": "obj-203",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						550,
						180,
						50,
						22
					]
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
						410,
						180,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-205",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"patching_rect": [
						410,
						225,
						159,
						22
					],
					"text": "i 0"
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
						410,
						265,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-207",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						580,
						220,
						170,
						47
					],
					"text": "Modifica el número derecho o pulsa 'set 100': nada sale hasta que presionas el bang."
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
						360,
						360,
						22
					],
					"text": "ESCENARIO 3: Formateo Dinámico de Mensajes ($1)"
				}
			},
			{
				"box": {
					"id": "obj-301",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40,
						385,
						320,
						33
					],
					"text": "Al cambiar el canal MIDI y la nota, ¿cómo aseguramos que el mensaje salga con los dos valores correctos?"
				}
			},
			{
				"box": {
					"id": "obj-302",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						40,
						430,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-303",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						95,
						430,
						80,
						20
					],
					"text": "Nota (0-127)"
				}
			},
			{
				"box": {
					"id": "obj-304",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						40,
						470,
						100,
						22
					],
					"text": "t i i"
				}
			},
			{
				"box": {
					"id": "obj-305",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						40,
						520,
						100,
						22
					],
					"text": "pack 0 100"
				}
			},
			{
				"box": {
					"id": "obj-306",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						40,
						560,
						130,
						22
					],
					"text": "note $1 vel $2"
				}
			},
			{
				"box": {
					"id": "obj-307",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						40,
						600,
						95,
						22
					],
					"text": "print MIDI_OUT"
				}
			},
			{
				"box": {
					"id": "obj-308",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						150,
						470,
						220,
						47
					],
					"text": "[pack] tiene inlets fríos a la derecha y caliente a la izquierda. [t i i] orquesta la llegada exacta sin desfasajes."
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
						360,
						370,
						22
					],
					"text": "ESCENARIO 4: Puertas Lógicas Condicionales ([gate])"
				}
			},
			{
				"box": {
					"id": "obj-401",
					"linecount": 2,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						400,
						385,
						360,
						33
					],
					"text": "Inlet izquierdo = Estado (0/1). Inlet derecho = Datos de paso. La anatomía invertida que confunde a todo novato."
				}
			},
			{
				"box": {
					"id": "obj-402",
					"maxclass": "toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"parameter_enable": 0,
					"patching_rect": [
						400,
						430,
						24,
						24
					]
				}
			},
			{
				"box": {
					"id": "obj-403",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						460,
						430,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-404",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						400,
						480,
						79,
						22
					],
					"text": "gate"
				}
			},
			{
				"box": {
					"id": "obj-405",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						400,
						520,
						50,
						22
					]
				}
			},
			{
				"box": {
					"id": "obj-406",
					"linecount": 3,
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						500,
						480,
						250,
						47
					],
					"text": "Al cambiar el toggle (izq), NO sale nada. Solo cuando entra un dato por la derecha y el gate está abierto (1), el dato fluye."
				}
			},
			{
				"box": {
					"id": "obj-102-trig",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"patching_rect": [
						40,
						185,
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
						"obj-107",
						0
					],
					"source": [
						"obj-106",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-108",
						0
					],
					"source": [
						"obj-107",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-108",
						1
					],
					"source": [
						"obj-107",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-109",
						0
					],
					"source": [
						"obj-108",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-205",
						0
					],
					"source": [
						"obj-202",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-205",
						1
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
						"obj-205",
						0
					],
					"source": [
						"obj-204",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-206",
						0
					],
					"source": [
						"obj-205",
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
						"obj-302",
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
						"obj-305",
						1
					],
					"source": [
						"obj-304",
						1
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-306",
						0
					],
					"source": [
						"obj-305",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-307",
						0
					],
					"source": [
						"obj-306",
						0
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
						"obj-402",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-404",
						1
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
						"obj-102-trig",
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
						"obj-103",
						1
					],
					"source": [
						"obj-102-trig",
						1
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
						"obj-102-trig",
						0
					]
				}
			}
		]
	}
}