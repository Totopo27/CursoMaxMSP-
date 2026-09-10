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
		"rect" : [ 100.0, 100.0, 950.0, 700.0 ],
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
		"description" : "Laboratorio 24: Concepto y Arquitectura de un External en C SDK",
		"digest" : "",
		"tags" : "MaxMSP, C SDK, External, C++, Architecture",
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
					"text" : "LABORATORIO 24: Arquitectura del SDK de C de Max y Objetos Externos Nativos"
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
					"text" : "Este laboratorio ilustra cómo se traduce el diseño de un external de C ('mi_objeto_externo.c') al patcher de Max. La lógica de acumulador interno con despacho de tipos se simula con objetos nativos para comparación didáctica con el código fuente en C."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-c-code",
					"linecount" : 6,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 120.0, 400.0, 87.0 ],
					"text" : "// Equivalente C en ext_main():\n// class_addmethod(c, (method)mi_objeto_bang, 'bang', 0);\n// class_addmethod(c, (method)mi_objeto_int, 'int', A_LONG, 0);\n//\n// El inlet izquierdo recibe números o 'bang'.\n// El outlet derecho emite un bang de sincronía; el izquierdo el resultado."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-num-input",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 230.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-bang-in",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 100.0, 230.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-reset",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 145.0, 230.0, 47.0, 22.0 ],
					"text" : "reset"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-simulacion-c",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "bang" ],
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
						"rect" : [ 200.0, 200.0, 400.0, 350.0 ],
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
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-inlet-sub",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 40.0, 30.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-accum",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 40.0, 120.0, 60.0, 22.0 ],
									"text" : "accum 0"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-route-reset",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 40.0, 80.0, 69.0, 22.0 ],
									"text" : "route reset"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-msg-zero",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 40.0, 160.0, 29.5, 22.0 ],
									"text" : "set 0"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-bang-out",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 150.0, 220.0, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-data",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 40.0, 260.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-bang",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 150.0, 260.0, 30.0, 30.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-route-reset", 0 ],
									"source" : [ "obj-inlet-sub", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-msg-zero", 0 ],
									"source" : [ "obj-route-reset", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-accum", 0 ],
									"source" : [ "obj-route-reset", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-accum", 0 ],
									"source" : [ "obj-msg-zero", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-data", 0 ],
									"order" : 1,
									"source" : [ "obj-accum", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-bang-out", 0 ],
									"order" : 0,
									"source" : [ "obj-accum", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-bang", 0 ],
									"source" : [ "obj-bang-out", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 30.0, 280.0, 185.0, 22.0 ],
					"text" : "p simulacion_mi_objeto_externo"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-res-display",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 330.0, 70.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-bang-display",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 196.0, 330.0, 24.0, 24.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-simulacion-c", 0 ],
					"source" : [ "obj-num-input", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-simulacion-c", 0 ],
					"source" : [ "obj-bang-in", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-simulacion-c", 0 ],
					"source" : [ "obj-msg-reset", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-res-display", 0 ],
					"source" : [ "obj-simulacion-c", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-bang-display", 0 ],
					"source" : [ "obj-simulacion-c", 1 ]
				}

			}
 ]
	}

}
