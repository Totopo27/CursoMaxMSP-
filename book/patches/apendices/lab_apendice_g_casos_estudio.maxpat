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
		"rect" : [ 80.0, 80.0, 1050.0, 780.0 ],
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
		"description" : "Laboratorio Apendice G: Casos de Estudio y Ecosistema Creativo — AMI (Colasanto), Composicion Algoritmica Markov, jsui y mgraphics",
		"digest" : "",
		"tags" : "MaxMSP, Composicion Algoritmica, Markov, AMI, Colasanto, jsui, mgraphics, ecosistema creativo",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 		{
			"box" : 			{
				"fontsize" : 18.0,
				"fontface" : 1,
				"id" : "obj-title",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 15.0, 850.0, 27.0 ],
				"text" : "APENDICE G - Ecosistema Creativo: Composicion Algoritmica (AMI/Markov) + Render Visual (jsui)"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-desc",
				"linecount" : 4,
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 50.0, 900.0, 64.0 ],
				"text" : "CONCEPTO: Tres pilares del ecosistema creativo profesional de Max/MSP. BLOQUE 1: Motor de cadenas de Markov de primer orden para composicion algoritmica (inspirado en el sistema AMI de Francisco Colasanto / CMMAS-UNAM). BLOQUE 2: Parametro grabado/reproducido con [pattr]. BLOQUE 3: Render de particulas vectoriales en tiempo real con [jsui] y mgraphics API."
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-sep1",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 125.0, 700.0, 20.0 ],
				"text" : "--- BLOQUE 1: Cadena de Markov de 1er Orden para Melodia Algoritmica ---"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-metro",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 20.0, 153.0, 100.0, 22.0 ],
				"text" : "metro 400"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-toggle-metro",
				"maxclass" : "toggle",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 20.0, 123.0, 22.0, 22.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-scale-list",
				"maxclass" : "message",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 140.0, 153.0, 260.0, 22.0 ],
				"text" : "57 60 62 64 67 69 72 74 76"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-coll-markov",
				"maxclass" : "newobj",
				"numinlets" : 1,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 188.0, 200.0, 22.0 ],
				"text" : "coll markov_pentatonic"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-random-step",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 240.0, 188.0, 80.0, 22.0 ],
				"text" : "random 9"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-zl-lookup",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 220.0, 120.0, 22.0 ],
				"text" : "zl.lookup"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-pitch-out",
				"maxclass" : "number",
				"numinlets" : 1,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 252.0, 80.0, 22.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-pitch-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 110.0, 255.0, 150.0, 20.0 ],
				"text" : "<- MIDI Note (Pentatonica La)"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-noteout",
				"maxclass" : "newobj",
				"numinlets" : 3,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 285.0, 80.0, 22.0 ],
				"text" : "noteout"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-vel-msg",
				"maxclass" : "message",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 110.0, 285.0, 40.0, 22.0 ],
				"text" : "90"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-sep2",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 325.0, 700.0, 20.0 ],
				"text" : "--- BLOQUE 2: Grabacion y Reproduccion de Gesto con [pattr] (Parameter Recording) ---"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-slider-gesto",
				"maxclass" : "slider",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 20.0, 353.0, 200.0, 30.0 ],
				"size" : 128,
				"parameter_enable" : 1,
				"saved_attribute_attributes" : 				{
					"valueof" : 					{
						"parameter_longname" : "Gesto_Continuo",
						"parameter_shortname" : "Gesto",
						"parameter_type" : 1,
						"parameter_mmin" : 0.0,
						"parameter_mmax" : 127.0,
						"parameter_initial_enable" : 1,
						"parameter_initial" : [ 64 ]
					}

				}

			}

		}
, 		{
			"box" : 			{
				"id" : "obj-pattr-gesto",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 3,
				"patching_rect" : [ 240.0, 353.0, 160.0, 22.0 ],
				"text" : "pattrstorage gesto_storage"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-store-btn",
				"maxclass" : "button",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 240.0, 388.0, 30.0, 30.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-store-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 280.0, 395.0, 150.0, 20.0 ],
				"text" : "Guardar preset 1"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-store-msg",
				"maxclass" : "message",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 240.0, 430.0, 80.0, 22.0 ],
				"text" : "store 1"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-recall-msg",
				"maxclass" : "message",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 340.0, 430.0, 80.0, 22.0 ],
				"text" : "recall 1"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-sep3",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 475.0, 700.0, 20.0 ],
				"text" : "--- BLOQUE 3: Render Visual Vectorial en Tiempo Real con [jsui] y mgraphics ---"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-jsui-vis",
				"maxclass" : "jsui",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 20.0, 500.0, 300.0, 200.0 ],
				"parameter_enable" : 0,
				"file" : "visualizador_markov.js"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-jsui-note",
				"linecount" : 4,
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 340.0, 500.0, 500.0, 65.0 ],
				"text" : "JSUI: Visualizador vectorial que recibe el MIDI note y dibuja un circulo cuyo radio y color varían con el pitch. Usa mgraphics.set_source_rgba() y mgraphics.arc(). Crea el archivo 'visualizador_markov.js' en tu Max search path con el codigo incluido en el Apendice G del libro."
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-nota-markov",
				"linecount" : 5,
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 460.0, 153.0, 560.0, 80.0 ],
				"text" : "CADENA DE MARKOV: El objeto [coll markov_pentatonic] almacena las probabilidades de transicion P(S_t | S_{t-1}). La escala Pentatonica de La (MIDI 57,60,62,64,67,69,72,74,76) se usa como espacio de estados. [random 9] selecciona el proximo estado. Conecta [pitch-out] a un sintetizador MSP para audio. Inspirado en el sistema AMI de Francisco Colasanto (CMMAS/UNAM)."
			}

		}
],
		"lines" : [ 		{
			"patchline" : 			{
				"source" : [ "obj-toggle-metro", 0 ],
				"destination" : [ "obj-metro", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-metro", 0 ],
				"destination" : [ "obj-random-step", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-scale-list", 0 ],
				"destination" : [ "obj-zl-lookup", 1 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-random-step", 0 ],
				"destination" : [ "obj-zl-lookup", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-zl-lookup", 0 ],
				"destination" : [ "obj-pitch-out", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-pitch-out", 0 ],
				"destination" : [ "obj-noteout", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-pitch-out", 0 ],
				"destination" : [ "obj-jsui-vis", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-vel-msg", 0 ],
				"destination" : [ "obj-noteout", 1 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-store-btn", 0 ],
				"destination" : [ "obj-store-msg", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-store-msg", 0 ],
				"destination" : [ "obj-pattr-gesto", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-recall-msg", 0 ],
				"destination" : [ "obj-pattr-gesto", 0 ]
			}

		}
]
	}

}
