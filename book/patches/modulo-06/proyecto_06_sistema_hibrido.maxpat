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
		"rect" : [ 60.0, 60.0, 1100.0, 800.0 ],
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
		"description" : "Proyecto Integrador 06: Sistema Hibrido Multicapa (JS + N4M + DSP)",
		"digest" : "",
		"tags" : "MaxMSP, Node for Max, JS, DSP, Hybrid, Architecture",
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
					"patching_rect" : [ 30.0, 20.0, 800.0, 27.0 ],
					"text" : "PROYECTO INTEGRADOR 06: Sistema Híbrido Multicapa (Node for Max + JS + MSP)"
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
					"text" : "Integra un servidor asíncrono en Node for Max (N4M) que recibe parámetros remotos vía IPC, modula el motor generativo de JavaScript [js] (Bjorklund Euclidean) y controla un motor de síntesis sustractiva/FM con protecciones anti-clipping (-12 dB)."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-start-n4m",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 120.0, 65.0, 22.0 ],
					"text" : "script start"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-iniciar",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 105.0, 120.0, 72.0, 22.0 ],
					"text" : "iniciar 8080"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-n4m-core",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 30.0, 160.0, 175.0, 22.0 ],
					"text" : "node.script servidor_analisis.js"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-route-sensor",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 30.0, 200.0, 105.0, 22.0 ],
					"text" : "route sensor_data"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-unpack-data",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "float", "float", "float" ],
					"patching_rect" : [ 30.0, 235.0, 90.0, 22.0 ],
					"text" : "unpack 0. 0. 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-metro-clk",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 250.0, 160.0, 69.0, 22.0 ],
					"text" : "metro 120"
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
					"patching_rect" : [ 250.0, 120.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-js-engine",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 250.0, 220.0, 170.0, 22.0 ],
					"text" : "js algoritmo_euclidiano.js"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sel-gate",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 401.0, 260.0, 34.0, 22.0 ],
					"text" : "sel 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-button-hit",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 401.0, 300.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-synth-env",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 401.0, 340.0, 90.0, 22.0 ],
					"text" : "line~ 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-env",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 401.0, 310.0, 95.0, 22.0 ],
					"text" : "0.25, 0. 120 -0.8"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-osc-synth",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 320.0, 340.0, 66.0, 22.0 ],
					"text" : "cycle~ 180"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-mult-amp",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 320.0, 380.0, 34.0, 22.0 ],
					"text" : "*~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-headroom-attenuation",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 320.0, 420.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-meter-master",
					"maxclass" : "live.meter~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "hidden" ],
					"patching_rect" : [ 380.0, 450.0, 16.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 320.0, 480.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-n4m-core", 0 ],
					"source" : [ "obj-msg-start-n4m", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-n4m-core", 0 ],
					"source" : [ "obj-msg-iniciar", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-route-sensor", 0 ],
					"source" : [ "obj-n4m-core", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-unpack-data", 0 ],
					"source" : [ "obj-route-sensor", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-metro-clk", 0 ],
					"source" : [ "obj-metro-toggle", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-js-engine", 0 ],
					"source" : [ "obj-metro-clk", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sel-gate", 0 ],
					"source" : [ "obj-js-engine", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-button-hit", 0 ],
					"source" : [ "obj-sel-gate", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-msg-env", 0 ],
					"source" : [ "obj-button-hit", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-synth-env", 0 ],
					"source" : [ "obj-msg-env", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-mult-amp", 0 ],
					"source" : [ "obj-osc-synth", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-mult-amp", 1 ],
					"source" : [ "obj-synth-env", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-headroom-attenuation", 0 ],
					"source" : [ "obj-mult-amp", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-headroom-attenuation", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 2,
					"source" : [ "obj-headroom-attenuation", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-meter-master", 0 ],
					"order" : 0,
					"source" : [ "obj-headroom-attenuation", 0 ]
				}

			}
 ]
	}

}
