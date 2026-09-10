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
		"description" : "Laboratorio Apendice B: Telemetria OSC de Max a TouchDesigner",
		"digest" : "",
		"tags" : "MaxMSP, TouchDesigner, OSC, UDP, Spout, Interoperability",
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
					"text" : "APÉNDICE B: Interoperabilidad Max/MSP y TouchDesigner (OSC sobre UDP)"
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
					"text" : "Emisor de telemetría de control en tiempo real hacia TouchDesigner mediante paquetes UDP / OSC en el puerto local 9000. Envía la energía RMS del audio analizado y el valor de pitch/frecuencia para modular parámetros visuales (CHOPs en TD)."
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
					"text" : "metro 33"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-metro",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 110.0, 160.0, 200.0, 22.0 ],
					"text" : "<-- Tasa de refresco a ~30 fps"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-audio-source",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 350.0, 120.0, 66.0, 22.0 ],
					"text" : "cycle~ 220"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-rms-meter",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 350.0, 160.0, 75.0, 22.0 ],
					"text" : "peakamp~ 33"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-slider-freq",
					"maxclass" : "slider",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 450.0, 120.0, 140.0, 20.0 ],
					"size" : 1000.0
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-pack-osc-rms",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 230.0, 150.0, 22.0 ],
					"text" : "pak /max/audio/rms 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-pack-osc-freq",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 200.0, 230.0, 150.0, 22.0 ],
					"text" : "pak /max/audio/pitch 220."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-udpsend",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 290.0, 150.0, 22.0 ],
					"text" : "udpsend 127.0.0.1 9000"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-td-info",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 220.0, 280.0, 400.0, 60.0 ],
					"text" : "En TouchDesigner:\n1. Agregá un operador 'OSC In CHOP'.\n2. Configurá Network Port: 9000.\n3. Verás los canales '/max/audio/rms' y '/max/audio/pitch' activos."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gain-mon",
					"maxclass" : "gain~",
					"multichannelvariant" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 350.0, 360.0, 140.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 350.0, 410.0, 45.0, 45.0 ]
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
					"destination" : [ "obj-pack-osc-rms", 0 ],
					"source" : [ "obj-metro", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-rms-meter", 0 ],
					"order" : 1,
					"source" : [ "obj-audio-source", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-mon", 0 ],
					"order" : 0,
					"source" : [ "obj-audio-source", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-pack-osc-rms", 1 ],
					"source" : [ "obj-rms-meter", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-audio-source", 0 ],
					"order" : 0,
					"source" : [ "obj-slider-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-pack-osc-freq", 1 ],
					"order" : 1,
					"source" : [ "obj-slider-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-udpsend", 0 ],
					"source" : [ "obj-pack-osc-rms", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-udpsend", 0 ],
					"source" : [ "obj-pack-osc-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 0,
					"source" : [ "obj-gain-mon", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-gain-mon", 0 ]
				}

			}
 ]
	}

}
