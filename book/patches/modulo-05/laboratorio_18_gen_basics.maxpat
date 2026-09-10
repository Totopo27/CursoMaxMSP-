{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 80.0, 80.0, 1150.0, 850.0 ],
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
		"description" : "Laboratorio 18: Fundamentos de gen~ y Compilacion JIT",
		"digest" : "",
		"tags" : "Max MSP gen gen~ JIT LLVM history feedback",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspreset" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 25.0, 20.0, 780.0, 30.0 ],
					"text" : "LABORATORIO 18: FUNDAMENTOS DE GEN~ (JIT COMPILATION & SINGLE-SAMPLE HISTORY)",
					"fontname" : "Arial Bold",
					"fontsize" : 18.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 25.0, 55.0, 880.0, 47.0 ],
					"text" : "Demostración práctica del paradigma gen~ compilado con LLVM en caliente.\nEl operador interno [history] permite retroalimentación exacta de una sola muestra (z^-1).\nImplementa un filtro analógico virtual no lineal con saturación por tangente hiperbólica (tanh)."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 35.0, 120.0, 180.0, 20.0 ],
					"text" : "EXCITADOR DE ENTRADA",
					"fontname" : "Arial Bold"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 35.0, 150.0, 66.0, 22.0 ],
					"text" : "saw~ 130."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 250.0, 120.0, 280.0, 20.0 ],
					"text" : "PARÁMETROS JIT ATÓMICOS",
					"fontname" : "Arial Bold"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 250.0, 150.0, 60.0, 22.0 ],
					"minimum" : 0.001,
					"maximum" : 0.999
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-7",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 250.0, 185.0, 61.0, 22.0 ],
					"text" : "cutoff $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 350.0, 150.0, 60.0, 22.0 ],
					"minimum" : 0.0,
					"maximum" : 5.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 350.0, 185.0, 56.0, 22.0 ],
					"text" : "drive $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 9,
							"minor" : 0,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "dsp.gen",
						"rect" : [ 150.0, 150.0, 600.0, 450.0 ],
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
									"id" : "obj-gen-1",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 20.0, 30.0, 22.0 ],
									"text" : "in 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-2",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 150.0, 20.0, 120.0, 22.0 ],
									"text" : "param cutoff 0.2"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-3",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 300.0, 20.0, 100.0, 22.0 ],
									"text" : "param drive 1.5"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-4",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 70.0, 289.0, 22.0 ],
									"text" : "*"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 110.0, 39.0, 22.0 ],
									"text" : "tanh"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-6",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 100.0, 170.0, 60.0, 22.0 ],
									"text" : "history y"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-7",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 170.0, 139.0, 22.0 ],
									"text" : "*"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-8",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 180.0, 170.0, 35.0, 22.0 ],
									"text" : "!- 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-9",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 100.0, 220.0, 99.0, 22.0 ],
									"text" : "*"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-10",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 260.0, 89.0, 22.0 ],
									"text" : "+"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-gen-11",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 30.0, 310.0, 38.0, 22.0 ],
									"text" : "out 1"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-4", 0 ],
									"source" : [ "obj-gen-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-7", 1 ],
									"order" : 1,
									"source" : [ "obj-gen-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-8", 0 ],
									"order" : 0,
									"source" : [ "obj-gen-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-4", 1 ],
									"source" : [ "obj-gen-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-5", 0 ],
									"source" : [ "obj-gen-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-7", 0 ],
									"source" : [ "obj-gen-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-9", 0 ],
									"source" : [ "obj-gen-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-10", 0 ],
									"source" : [ "obj-gen-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-9", 1 ],
									"source" : [ "obj-gen-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-10", 1 ],
									"source" : [ "obj-gen-9", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-6", 0 ],
									"midpoints" : [ 39.5, 292.0, 84.0, 292.0, 84.0, 160.0, 109.5, 160.0 ],
									"order" : 0,
									"source" : [ "obj-gen-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-gen-11", 0 ],
									"order" : 1,
									"source" : [ "obj-gen-10", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 35.0, 240.0, 234.0, 22.0 ],
					"text" : "gen~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "spectroscope~",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 350.0, 270.0, 480.0, 170.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 35.0, 300.0, 47.0, 22.0 ],
					"text" : "*~ 0.3"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "gain~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 35.0, 340.0, 120.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 35.0, 385.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 250.0, 90.0, 60.0, 22.0 ],
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 250.0, 120.0, 32.0, 22.0 ],
					"text" : "0.2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 350.0, 120.0, 32.0, 22.0 ],
					"text" : "1.5"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-11", 0 ],
					"order" : 0,
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"order" : 1,
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 1 ],
					"order" : 0,
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"order" : 1,
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"order" : 1,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"order" : 0,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"source" : [ "obj-17", 0 ]
				}

			}
 ]
	}

}
