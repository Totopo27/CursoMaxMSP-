{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 6,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 50.0, 50.0, 1150.0, 850.0 ],
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
		"description" : "Curso Max/MSP - Laboratorio 06: Comunicación Remota, Espacios de Nombres y Enrutamiento Dinámico",
		"digest" : "",
		"tags" : "send receive forward pattrforward namespace",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"fontsize" : 22.0,
					"id" : "obj-1",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 20.0, 880.0, 31.0 ],
					"text" : "LABORATORIO 06: Comunicación Remota, Enrutamiento Dinámico y Espacios de Nombres"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 55.0, 880.0, 33.0 ],
					"text" : "Demostración de desacoplamiento seguro: Difusión con [send]/[receive], ruteo ultra-rápido en caliente con [forward], inyección jerárquica con [pattrforward] y prevención de colisiones globales."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 14.0,
					"id" : "obj-10",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 110.0, 340.0, 22.0 ],
					"text" : "1. DIFUSIÓN CLÁSICA CON [send] Y [receive]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 40.0, 145.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.2, 0.7, 0.3, 1.0 ],
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 185.0, 115.0, 22.0 ],
					"text" : "send bus_frecuencia"
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.2, 0.7, 0.3, 1.0 ],
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 230.0, 128.0, 22.0 ],
					"text" : "receive bus_frecuencia"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 40.0, 265.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.2, 0.7, 0.3, 1.0 ],
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 190.0, 230.0, 128.0, 22.0 ],
					"text" : "receive bus_frecuencia"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 190.0, 265.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 305.0, 360.0, 47.0 ],
					"text" : "⚠️ Gotcha Demostrado: Ambos [receive] capturan el número simultáneamente. Pero si requieres que el receptor 1 actúe antes que el 2, no puedes garantizarlo sin usar cables y [trigger]."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 14.0,
					"id" : "obj-30",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 460.0, 110.0, 380.0, 22.0 ],
					"text" : "2. ENRUTAMIENTO DINÁMICO CON [forward]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-31",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 460.0, 145.0, 75.0, 22.0 ],
					"text" : "send canal_1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-32",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 545.0, 145.0, 75.0, 22.0 ],
					"text" : "send canal_2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-33",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 640.0, 145.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.9, 0.5, 0.2, 1.0 ],
					"fontsize" : 13.0,
					"id" : "obj-34",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 460.0, 190.0, 75.0, 23.0 ],
					"text" : "forward"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-35",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 460.0, 235.0, 91.0, 22.0 ],
					"text" : "receive canal_1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-36",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 460.0, 270.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-37",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 570.0, 235.0, 91.0, 22.0 ],
					"text" : "receive canal_2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-38",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 570.0, 270.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-39",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 460.0, 305.0, 380.0, 47.0 ],
					"text" : "Conmuta el destino con 'send canal_1' o 'send canal_2' y envía números desde la caja de la derecha. El flujo se redirige instantáneamente sin crear 10 cables."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 14.0,
					"id" : "obj-50",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 390.0, 420.0, 22.0 ],
					"text" : "3. INYECCIÓN JERÁRQUICA CON [pattrforward]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-51",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 425.0, 160.0, 22.0 ],
					"text" : "send motor_dsp::filtro 440."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-52",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 210.0, 425.0, 165.0, 22.0 ],
					"text" : "send motor_dsp::filtro 1500."
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.7, 0.4, 0.9, 1.0 ],
					"id" : "obj-53",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 465.0, 75.0, 22.0 ],
					"text" : "pattrforward"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-54",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 500.0, 380.0, 47.0 ],
					"text" : "Mira cómo [pattrforward] inyecta el valor dentro del subpatcher [p motor_dsp] ubicado abajo, sin necesidad de tener un objeto [receive] adentro ni tirar cables hacia él."
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.9, 0.2, 0.2, 1.0 ],
					"fontsize" : 13.0,
					"id" : "obj-60",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 6,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 100.0, 100.0, 400.0, 300.0 ],
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
									"id" : "obj-1",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 40.0, 40.0, 220.0, 20.0 ],
									"text" : "SUBPATCHER AISLADO: motor_dsp"
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-2",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 40.0, 90.0, 80.0, 22.0 ],
									"varname" : "filtro"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"patching_rect" : [ 40.0, 140.0, 130.0, 22.0 ],
									"text" : "autopattr @autoname 1",
									"varname" : "u122001"
								}

							}
 ],
						"lines" : [  ]
					}
,
					"patching_rect" : [ 40.0, 560.0, 140.0, 23.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p motor_dsp",
					"varname" : "motor_dsp"
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontsize" : 14.0,
					"id" : "obj-70",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 460.0, 390.0, 440.0, 22.0 ],
					"text" : "4. MONITOREO DE AUDIO Y BUS GLOBAL DE PÁNICO"
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.9, 0.2, 0.2, 1.0 ],
					"id" : "obj-71",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 460.0, 425.0, 35.0, 35.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-72",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 505.0, 432.0, 160.0, 20.0 ],
					"text" : "PANIC GLOBAL (Silenciar)"
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.9, 0.2, 0.2, 1.0 ],
					"id" : "obj-73",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 460.0, 475.0, 105.0, 22.0 ],
					"text" : "send global_panic"
				}

			}
, 			{
				"box" : 				{
					"color" : [ 0.9, 0.2, 0.2, 1.0 ],
					"id" : "obj-74",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 460.0, 520.0, 118.0, 22.0 ],
					"text" : "receive global_panic"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-75",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 460.0, 555.0, 29.5, 22.0 ],
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-76",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 520.0, 555.0, 66.0, 22.0 ],
					"text" : "cycle~ 330"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-77",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 520.0, 595.0, 40.0, 22.0 ],
					"text" : "*~ 0.2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-78",
					"maxclass" : "gain~",
					"multichannelvariant" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 520.0, 630.0, 35.0, 80.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-79",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 520.0, 730.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-80",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 585.0, 730.0, 340.0, 47.0 ],
					"text" : "Instrucciones de Audio:\n1. Enciende el altavoz del dac~.\n2. Sube la ganancia para escuchar el tono.\n3. Presiona el botón rojo PANIC para silenciarlo vía bus remoto."
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 0 ],
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"source" : [ "obj-32", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-36", 0 ],
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"source" : [ "obj-37", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 0 ],
					"source" : [ "obj-51", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 0 ],
					"source" : [ "obj-52", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 0 ],
					"source" : [ "obj-71", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 0 ],
					"source" : [ "obj-74", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-78", 0 ],
					"source" : [ "obj-75", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 0 ],
					"source" : [ "obj-76", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-78", 0 ],
					"source" : [ "obj-77", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 1 ],
					"order" : 0,
					"source" : [ "obj-78", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 0 ],
					"order" : 1,
					"source" : [ "obj-78", 0 ]
				}

			}
 ]
	}

}