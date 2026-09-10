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
		"rect" : [ 80.0, 80.0, 1000.0, 750.0 ],
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
		"description" : "Laboratorio Apendice F: Espacializacion 3D Cuadrafonica y Simulacion Acustica",
		"digest" : "",
		"tags" : "MaxMSP, Spatial Audio, 3D Audio, Quadraphonic, Panning, Spat",
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
					"text" : "APÉNDICE F: Espacialización Sonora 3D Cuadrafónica y Acústica Virtual"
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
					"text" : "Demuestra la rotación y paneo de una fuente acústica en un espacio cuadrafónico bidimensional (Altavoces 1 a 4). Calcula ganancias trigonométricas preservando la potencia acústica constante y aplica atenuación general de -12 dB anti-clipping."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-audio-source",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 120.0, 66.0, 22.0 ],
					"text" : "cycle~ 330"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-orbit-lfo",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 120.0, 70.0, 22.0 ],
					"text" : "phasor~ 0.2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-lfo",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 230.0, 120.0, 220.0, 22.0 ],
					"text" : "<-- Órbita circular a 0.2 Hz (1 vuelta / 5s)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-quad-core",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 4,
					"outlettype" : [ "signal", "signal", "signal", "signal" ],
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
						"rect" : [ 150.0, 150.0, 500.0, 400.0 ],
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
									"id" : "obj-in-audio",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 30.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-in-phase",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 200.0, 20.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-cos-ch1",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 60.0, 100.0, 43.0, 22.0 ],
									"text" : "cycle~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-cos-ch2",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 140.0, 100.0, 43.0, 22.0 ],
									"text" : "cycle~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-mult-ch1",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 30.0, 180.0, 34.0, 22.0 ],
									"text" : "*~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-mult-ch2",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 110.0, 180.0, 34.0, 22.0 ],
									"text" : "*~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-spk1",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 30.0, 260.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-spk2",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 110.0, 260.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-spk3",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 190.0, 260.0, 30.0, 30.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-out-spk4",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 270.0, 260.0, 30.0, 30.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-cos-ch1", 1 ],
									"order" : 1,
									"source" : [ "obj-in-phase", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-cos-ch2", 1 ],
									"order" : 0,
									"source" : [ "obj-in-phase", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-mult-ch1", 0 ],
									"order" : 3,
									"source" : [ "obj-in-audio", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-mult-ch2", 0 ],
									"order" : 2,
									"source" : [ "obj-in-audio", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-spk3", 0 ],
									"order" : 1,
									"source" : [ "obj-in-audio", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-spk4", 0 ],
									"order" : 0,
									"source" : [ "obj-in-audio", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-mult-ch1", 1 ],
									"source" : [ "obj-cos-ch1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-mult-ch2", 1 ],
									"source" : [ "obj-cos-ch2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-spk1", 0 ],
									"source" : [ "obj-mult-ch1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-out-spk2", 0 ],
									"source" : [ "obj-mult-ch2", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 30.0, 180.0, 200.0, 22.0 ],
					"text" : "p panner_cuadrafonico_virtual"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-atten-quad-1",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 240.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-atten-quad-2",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 90.0, 240.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-meter-quad-1",
					"maxclass" : "live.meter~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "hidden" ],
					"patching_rect" : [ 30.0, 280.0, 16.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-meter-quad-2",
					"maxclass" : "live.meter~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "hidden" ],
					"patching_rect" : [ 90.0, 280.0, 16.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 420.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-quad-core", 0 ],
					"source" : [ "obj-audio-source", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-quad-core", 1 ],
					"source" : [ "obj-orbit-lfo", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-atten-quad-1", 0 ],
					"source" : [ "obj-quad-core", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-atten-quad-2", 0 ],
					"source" : [ "obj-quad-core", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-meter-quad-1", 0 ],
					"order" : 1,
					"source" : [ "obj-atten-quad-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 0,
					"source" : [ "obj-atten-quad-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-meter-quad-2", 0 ],
					"order" : 1,
					"source" : [ "obj-atten-quad-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 0,
					"source" : [ "obj-atten-quad-2", 0 ]
				}

			}
 ]
	}

}
