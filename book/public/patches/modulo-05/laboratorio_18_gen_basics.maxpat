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
		"description": "Laboratorio 18: Fundamentos de gen~ y Compilacion JIT",
		"digest": "",
		"tags": "Max MSP gen gen~ JIT LLVM history feedback",
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
					"text": "LABORATORIO 18: FUNDAMENTOS DE GEN~ (JIT COMPILATION & SINGLE-SAMPLE HISTORY)",
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
					"text": "Demostración práctica del paradigma gen~ compilado con LLVM en caliente.\nEl operador interno [history] permite retroalimentación exacta de una sola muestra (z^-1).\nImplementa un filtro analógico virtual no lineal con saturación por tangente hiperbólica (tanh)."
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
					"text": "EXCITADOR DE ENTRADA",
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
					"text": "PARÁMETROS JIT ATÓMICOS",
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
					"minimum": 0.001,
					"maximum": 0.999
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
						61,
						22
					],
					"text": "cutoff $1"
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
					"minimum": 0,
					"maximum": 5
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
						56,
						22
					],
					"text": "drive $1"
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
							150,
							150,
							600,
							450
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
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										150,
										20,
										120,
										22
									],
									"text": "param cutoff 0.2"
								}
							},
							{
								"box": {
									"id": "obj-gen-3",
									"maxclass": "newobj",
									"numinlets": 0,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										300,
										20,
										100,
										22
									],
									"text": "param drive 1.5"
								}
							},
							{
								"box": {
									"id": "obj-gen-4",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										30,
										70,
										289,
										22
									],
									"text": "*"
								}
							},
							{
								"box": {
									"id": "obj-gen-5",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										30,
										110,
										39,
										22
									],
									"text": "tanh"
								}
							},
							{
								"box": {
									"id": "obj-gen-6",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										100,
										170,
										60,
										22
									],
									"text": "history y"
								}
							},
							{
								"box": {
									"id": "obj-gen-7",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										30,
										170,
										139,
										22
									],
									"text": "*"
								}
							},
							{
								"box": {
									"id": "obj-gen-8",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										180,
										170,
										35,
										22
									],
									"text": "!- 1."
								}
							},
							{
								"box": {
									"id": "obj-gen-9",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										100,
										220,
										99,
										22
									],
									"text": "*"
								}
							},
							{
								"box": {
									"id": "obj-gen-10",
									"maxclass": "newobj",
									"numinlets": 2,
									"numoutlets": 1,
									"outlettype": [
										""
									],
									"patching_rect": [
										30,
										260,
										89,
										22
									],
									"text": "+"
								}
							},
							{
								"box": {
									"id": "obj-gen-11",
									"maxclass": "newobj",
									"numinlets": 1,
									"numoutlets": 0,
									"patching_rect": [
										30,
										310,
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
										"obj-gen-4",
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
										"obj-gen-7",
										1
									],
									"order": 1,
									"source": [
										"obj-gen-2",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-8",
										0
									],
									"order": 0,
									"source": [
										"obj-gen-2",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-4",
										1
									],
									"source": [
										"obj-gen-3",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-5",
										0
									],
									"source": [
										"obj-gen-4",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-7",
										0
									],
									"source": [
										"obj-gen-5",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-9",
										0
									],
									"source": [
										"obj-gen-6",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-10",
										0
									],
									"source": [
										"obj-gen-7",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-9",
										1
									],
									"source": [
										"obj-gen-8",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-10",
										1
									],
									"source": [
										"obj-gen-9",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-6",
										0
									],
									"midpoints": [
										39.5,
										292,
										84,
										292,
										84,
										160,
										109.5,
										160
									],
									"order": 0,
									"source": [
										"obj-gen-10",
										0
									]
								}
							},
							{
								"patchline": {
									"destination": [
										"obj-gen-11",
										0
									],
									"order": 1,
									"source": [
										"obj-gen-10",
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
					"text": "0.2"
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
					"text": "1.5"
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