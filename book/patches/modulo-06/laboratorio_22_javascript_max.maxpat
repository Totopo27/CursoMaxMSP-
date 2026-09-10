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
		"description" : "Laboratorio 22: Algoritmos en JavaScript [js] integrados con DSP en Max/MSP",
		"digest" : "",
		"tags" : "MaxMSP, JavaScript, js, V8, Euclidean Rhythms, Bjorklund",
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
					"text" : "LABORATORIO 22: Algoritmos en JavaScript [js] y Síntesis de Percusión Euclidiana"
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
					"text" : "Este laboratorio ilustra la integración del motor JavaScript de Max ejecutando el script 'algoritmo_euclidiano.js' (Algoritmo de Bjorklund). Genera patrones rítmicos generativos euclidianos y dispara un sintetizador de percusión analógica virtual en tiempo real."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-metro-toggle",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 120.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-metro",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 30.0, 160.0, 69.0, 22.0 ],
					"text" : "metro 125"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-metro",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 110.0, 160.0, 150.0, 22.0 ],
					"text" : "<-- Reloj a semicorcheas"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-pattern1",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 250.0, 120.0, 110.0, 22.0 ],
					"text" : "5 16 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-pattern2",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 370.0, 120.0, 110.0, 22.0 ],
					"text" : "7 16 2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-pattern3",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 490.0, 120.0, 110.0, 22.0 ],
					"text" : "3 8 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-presets",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 250.0, 95.0, 300.0, 22.0 ],
					"text" : "Presets Euclidianos: [Pulsos, Pasos, Rotación]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-js-node",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 30.0, 220.0, 170.0, 22.0 ],
					"text" : "js algoritmo_euclidiano.js"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-display-pattern",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 270.0, 320.0, 22.0 ],
					"text" : "1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sel-hit",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 181.0, 270.0, 34.0, 22.0 ],
					"text" : "sel 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-hit-button",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 181.0, 310.0, 28.0, 28.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-click-trig",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 181.0, 360.0, 41.0, 22.0 ],
					"text" : "click~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-drum-synth",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 181.0, 400.0, 100.0, 22.0 ],
					"text" : "reson~ 2.5 160 25"
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
					"patching_rect" : [ 181.0, 450.0, 140.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-scope",
					"maxclass" : "scope~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 450.0, 180.0, 90.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 181.0, 500.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-metro", 0 ],
					"source" : [ "obj-metro-toggle", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-js-node", 0 ],
					"source" : [ "obj-metro", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-js-node", 0 ],
					"source" : [ "obj-msg-pattern1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-js-node", 0 ],
					"source" : [ "obj-msg-pattern2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-js-node", 0 ],
					"source" : [ "obj-msg-pattern3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-display-pattern", 1 ],
					"source" : [ "obj-js-node", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sel-hit", 0 ],
					"source" : [ "obj-js-node", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-hit-button", 0 ],
					"source" : [ "obj-sel-hit", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-click-trig", 0 ],
					"source" : [ "obj-hit-button", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-drum-synth", 0 ],
					"source" : [ "obj-click-trig", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-master", 0 ],
					"order" : 1,
					"source" : [ "obj-drum-synth", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-scope", 0 ],
					"order" : 0,
					"source" : [ "obj-drum-synth", 0 ]
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
