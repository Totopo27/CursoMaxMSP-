{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 5,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 100.0, 100.0, 950.0, 750.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "Laboratorio Apendice D: Arquitectura Min-DevKit C++17 en Max",
		"digest" : "",
		"tags" : "MaxMSP, Min-DevKit, C++17, Modern C++, Architecture",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"fontsize" : 18.0,
					"id" : "obj-title",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 20.0, 750.0, 27.0 ],
					"text" : "APÉNDICE D: Desarrollo en C++17 Declarativo con Cycling '74 Min-DevKit"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-desc",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 55.0, 850.0, 47.0 ],
					"text" : "Este laboratorio ilustra el flujo de trabajo del external moderno 'mi_objeto_min.cpp'. Simula la arquitectura declarativa de inlets/outlets y atributos con rango de Min-DevKit, aplicando escalamiento y saturación analógica suave (tanh) en tiempo de ejecución."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-num-in",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 130.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-factor",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 100.0, 130.0, 80.0, 22.0 ],
					"text" : "factor $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-num-factor",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 100.0, 95.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sim-min",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 5,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 150.0, 150.0, 450.0, 350.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-in1",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 40.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-in2",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 180.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-route-factor",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 40.0, 70.0, 71.0, 22.0 ],
									"text" : "route factor"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-expr-min",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 40.0, 120.0, 159.0, 22.0 ],
									"text" : "expr tanh($f1 * $f2)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out1",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 40.0, 240.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out2",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 150.0, 240.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-bang-pulse",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 150.0, 180.0, 24.0, 24.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-route-factor", 0 ],
									"source" : [ "obj-in1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-min", 0 ],
									"source" : [ "obj-route-factor", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-min", 1 ],
									"source" : [ "obj-route-factor", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-min", 1 ],
									"source" : [ "obj-in2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out1", 0 ],
									"order" : 1,
									"source" : [ "obj-expr-min", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-bang-pulse", 0 ],
									"order" : 0,
									"source" : [ "obj-expr-min", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out2", 0 ],
									"source" : [ "obj-bang-pulse", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 30.0, 190.0, 160.0, 22.0 ],
					"text" : "p simulacion_min_external"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-res-val",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 240.0, 60.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-bang-sync",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 171.0, 240.0, 24.0, 24.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-sim-min", 0 ],
					"source" : [ "obj-num-in", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-msg-factor", 0 ],
					"source" : [ "obj-num-factor", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sim-min", 0 ],
					"source" : [ "obj-msg-factor", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-res-val", 0 ],
					"source" : [ "obj-sim-min", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-bang-sync", 0 ],
					"source" : [ "obj-sim-min", 1 ]
				}

			}
 ]
	}

}
