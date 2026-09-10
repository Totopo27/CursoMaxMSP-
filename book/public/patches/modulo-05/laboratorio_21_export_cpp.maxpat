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
		"description" : "Laboratorio 21: Exportacion C++ de gen~ para Microcontroladores y Plugins",
		"digest" : "",
		"tags" : "MaxMSP, Gen~, C++, Exportcode, Daisy, Embedded DSP",
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
					"patching_rect" : [ 30.0, 20.0, 650.0, 27.0 ],
					"text" : "LABORATORIO 21: Exportación C++ y Despliegue de Algoritmos gen~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-desc",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 55.0, 750.0, 47.0 ],
					"text" : "Este laboratorio demuestra el uso del mensaje 'exportcode' para extraer el código fuente C++ ISO del algoritmo gen~ embebido. El objeto implementa un filtro de retroalimentación no lineal saturado y saturador tanh con control de 'drive' y 'damping'."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-export",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 60.0, 130.0, 75.0, 22.0 ],
					"text" : "exportcode"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-export",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 145.0, 130.0, 420.0, 22.0 ],
					"text" : "<-- Hacé click para generar la carpeta de archivos C++ nativos (.cpp, .h, genlib)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-noise",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 180.0, 44.0, 22.0 ],
					"text" : "noise~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gain-in",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 220.0, 40.0, 22.0 ],
					"text" : "*~ 0.1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-att-drive",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 150.0, 220.0, 150.0, 22.0 ],
					"attr" : "drive"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-att-damping",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 310.0, 220.0, 150.0, 22.0 ],
					"attr" : "damping"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gen-core",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 270.0, 300.0, 22.0 ],
					"text" : "gen~ @title SaturatorDSP",
					"saved_object_attributes" : 					{
						"exportfolder" : ""
					}
,
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
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-g-in1",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 40.0, 30.0, 28.0, 22.0 ],
									"text" : "in 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-codebox",
									"linecount" : 10,
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 40.0, 70.0, 420.0, 160.0 ],
									"text" : "codebox",
									"code" : "Param drive(1.5, min=0.1, max=10.0);\r\nParam damping(0.7, min=0.0, max=0.99);\r\nHistory fb(0);\r\n\r\n// Entrada con ganancia no-lineal y retroalimentacion filtrada\r\nx = in1 * drive + (fb * damping);\r\n// Saturacion tanh analoga aproximada\r\ny = tanh(x);\r\n// Filtro polo simple en el lazo de realimentacion para estabilidad\r\nfb = dcblock(y);\r\n\r\nout1 = y * 0.5;"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-g-out1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 40.0, 260.0, 35.0, 22.0 ],
									"text" : "out 1"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-codebox", 0 ],
									"source" : [ "obj-g-in1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-g-out1", 0 ],
									"source" : [ "obj-codebox", 0 ]
								}

							}
 ]
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gain-master",
					"maxclass" : "gain~",
					"multichannelvariant" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 320.0, 140.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-scope",
					"maxclass" : "scope~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 220.0, 320.0, 200.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 370.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-core", 0 ],
					"source" : [ "obj-msg-export", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-in", 0 ],
					"source" : [ "obj-noise", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-core", 0 ],
					"source" : [ "obj-gain-in", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-core", 0 ],
					"source" : [ "obj-att-drive", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-core", 0 ],
					"source" : [ "obj-att-damping", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-master", 0 ],
					"order" : 1,
					"source" : [ "obj-gen-core", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-scope", 0 ],
					"order" : 0,
					"source" : [ "obj-gen-core", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 0,
					"source" : [ "obj-gain-master", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-gain-master", 0 ]
				}

			}
 ]
	}

}
