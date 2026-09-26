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
		"description": "Laboratorio 19: Programacion Textual en GenExpr y Codebox",
		"digest": "",
		"tags": "Max MSP gen gen~ GenExpr codebox text DSP",
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
					"text": "LABORATORIO 19: PROGRAMACIÓN TEXTUAL EN GENEXPR (CODEBOX DSP KERNELS)",
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
					"text": "Sustitución de cajas visuales por algoritmos en GenExpr dentro de [codebox].\nImplementación de funciones personalizadas de saturación y bucles muestra a muestra.\nPermite esculpir armónicos analógicos no lineales con eficiencia compilada nativa."
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
						180,
						20
					],
					"text": "EXCITADOR DE AUDIO",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						150,
						66,
						22
					],
					"text": "saw~ 130."
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						250,
						120,
						280,
						20
					],
					"text": "PARÁMETROS GENEXPR (EN TIEMPO REAL)",
					"fontname": "Arial Bold"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						250,
						150,
						60,
						22
					],
					"minimum": 0.5,
					"maximum": 8
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
						250,
						185,
						56,
						22
					],
					"text": "drive $1"
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"bang"
					],
					"parameter_enable": 0,
					"patching_rect": [
						350,
						150,
						60,
						22
					],
					"minimum": 0.01,
					"maximum": 0.95
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						350,
						185,
						61,
						22
					],
					"text": "cutoff $1"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patcher": {
						"fileversion": 1,
						"appversion": {
							"major": 9,
							"minor": 0,
							"revision": 0,
							"architecture": "x64",
							"modernui": 1
						},
						"classnamespace": "dsp.gen",
						"rect": [
							120,
							120,
							650,
							500
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
						"boxes": [
							{
								"box": {
									"id": "obj-gen-1",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										30,
										20,
										30,
										22
									],
									"text": "in 1"
								}
							},
							{
								"box": {
									"id": "obj-gen-2",
									"maxclass": "codebox",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										30,
										60,
										550,
										340
									],
									"text": "Param drive(1.5);\r\nParam cutoff(0.25);\r\nHistory y1(0.0);\r\n\r\n// Funcion pura de saturacion suave\r\nsoft_saturate(val, d) {\r\n    x = val * d;\r\n    return tanh(x);\r\n}\r\n\r\n// Procesamiento de señal\r\nsat = soft_saturate(in1, drive);\r\n\r\n// Filtro IIR Leaky de 1 polo en GenExpr\r\ny = sat * cutoff + y1 * (1.0 - cutoff);\r\ny1 = y;\r\n\r\nout1 = y;"
								}
							},
							{
								"box": {
									"id": "obj-gen-3",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										30,
										420,
										38,
										22
									],
									"text": "out 1"
								}
							}
						],
						"lines": [
							{
								"patchline": {
									"destination": [
										"obj-gen-2",
										0
									],
									"source": [
										"obj-gen-1",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-3",
										0
									],
									"source": [
										"obj-gen-2",
										0
									]
								}
							}
						]
					},
					"patching_rect": [
						35,
						240,
						234,
						22
					],
					"text": "gen~"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "spectroscope~",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						350,
						270,
						480,
						170
					]
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"patching_rect": [
						35,
						300,
						47,
						22
					],
					"text": "*~ 0.3"
				}
			},
			{
				"box": {
					"id": "obj-13",
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
						340,
						120,
						25
					]
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "ezdac~",
					"numinlets": 2,
					"numoutlets": 0,
					"patching_rect": [
						35,
						385,
						45,
						45
					]
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"patching_rect": [
						250,
						90,
						60,
						22
					],
					"text": "loadbang"
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						250,
						120,
						32,
						22
					],
					"text": "2.0"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "message",
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"patching_rect": [
						350,
						120,
						32,
						22
					],
					"text": "0.3"
				}
			},
			{
				"box": {
					"id": "obj-15-trig",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"bang",
						"bang"
					],
					"patching_rect": [
						40,
						150,
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
						"obj-10",
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
						"obj-6",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-10",
						0
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
						0
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
						"obj-10",
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
						"obj-11",
						0
					],
					"order": 0,
					"source": [
						"obj-10",
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
						"obj-10",
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
						1
					],
					"order": 0,
					"source": [
						"obj-13",
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
					"order": 1,
					"source": [
						"obj-13",
						0
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
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-8",
						0
					],
					"source": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"destination": [
						"obj-15-trig",
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
					"source": [
						"obj-15-trig",
						1
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
						"obj-15-trig",
						0
					]
				}
			}
		]
	}
}