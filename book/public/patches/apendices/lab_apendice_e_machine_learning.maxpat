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
		"description" : "Laboratorio Apendice E: Machine Learning y Mapeo Gestual Neuronal",
		"digest" : "",
		"tags" : "MaxMSP, Machine Learning, FluCoMa, nn~, Neural Network, AI",
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
					"text" : "APÉNDICE E: Inteligencia Artificial y Mapeo Gestual Neuronal (FluCoMa & nn~)"
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
					"text" : "Simula el entrenamiento e inferencia de un regresor neuronal MLP (Perceptrón Multicapa estilo FluCoMa). Mapea coordenadas continuas 2D (X, Y) hacia múltiples parámetros tímbricos de un sintetizador FM con saturación analógica suave y protección anti-clipping."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-nodes-pad",
					"maxclass" : "nodes",
					"nsize" : [ 0.2, 0.2, 0.2 ],
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 120.0, 180.0, 140.0 ],
					"xplace" : [ 0.2, 0.8, 0.5 ],
					"yplace" : [ 0.3, 0.2, 0.9 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-pad",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 220.0, 130.0, 250.0, 33.0 ],
					"text" : "<-- Espacio Gestual 2D (Entrada de red)\nMueve los puntos para inferir el timbre."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-unpack-weights",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "float", "float", "float" ],
					"patching_rect" : [ 30.0, 280.0, 90.0, 22.0 ],
					"text" : "unpack 0. 0. 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-neural-layer",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 2,
					"outlettype" : [ "float", "float" ],
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
						"rect" : [ 200.0, 200.0, 450.0, 350.0 ],
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
									"id" : "obj-in-w1",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "float" ],
									"patching_rect" : [ 30.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-in-w2",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "float" ],
									"patching_rect" : [ 120.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-in-w3",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "float" ],
									"patching_rect" : [ 210.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-expr-freq",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 90.0, 220.0, 22.0 ],
									"text" : "expr 150. + ($f1 * 120.) + ($f2 * 280.) + ($f3 * 450.)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-expr-index",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 140.0, 220.0, 22.0 ],
									"text" : "expr ($f1 * 0.5) + ($f2 * 3.5) + ($f3 * 6.0)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-freq",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 30.0, 220.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-index",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 120.0, 220.0, 30.0, 30.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-freq", 0 ],
									"order" : 1,
									"source" : [ "obj-in-w1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-index", 0 ],
									"order" : 0,
									"source" : [ "obj-in-w1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-freq", 1 ],
									"order" : 1,
									"source" : [ "obj-in-w2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-index", 1 ],
									"order" : 0,
									"source" : [ "obj-in-w2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-freq", 2 ],
									"order" : 1,
									"source" : [ "obj-in-w3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-expr-index", 2 ],
									"order" : 0,
									"source" : [ "obj-in-w3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-freq", 0 ],
									"source" : [ "obj-expr-freq", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-index", 0 ],
									"source" : [ "obj-expr-index", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 30.0, 330.0, 160.0, 22.0 ],
					"text" : "p inferencia_red_neuronal"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sig-carrier-freq",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 30.0, 370.0, 58.0, 22.0 ],
					"text" : "line~ 220."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-mod-osc",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 370.0, 66.0, 22.0 ],
					"text" : "cycle~ 110"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sig-mod-depth",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 410.0, 40.0, 22.0 ],
					"text" : "*~ 50."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sum-fm",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 440.0, 36.0, 22.0 ],
					"text" : "+~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-carrier-osc",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 480.0, 43.0, 22.0 ],
					"text" : "cycle~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gain-atten",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 520.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 570.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-unpack-weights", 0 ],
					"source" : [ "obj-nodes-pad", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-neural-layer", 0 ],
					"source" : [ "obj-unpack-weights", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-neural-layer", 1 ],
					"source" : [ "obj-unpack-weights", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-neural-layer", 2 ],
					"source" : [ "obj-unpack-weights", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sig-carrier-freq", 0 ],
					"source" : [ "obj-neural-layer", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sig-mod-depth", 1 ],
					"source" : [ "obj-neural-layer", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sum-fm", 0 ],
					"source" : [ "obj-sig-carrier-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sig-mod-depth", 0 ],
					"source" : [ "obj-mod-osc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sum-fm", 1 ],
					"source" : [ "obj-sig-mod-depth", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-carrier-osc", 0 ],
					"source" : [ "obj-sum-fm", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-atten", 0 ],
					"source" : [ "obj-carrier-osc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 0,
					"source" : [ "obj-gain-atten", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-gain-atten", 0 ]
				}

			}
 ]
	}

}
