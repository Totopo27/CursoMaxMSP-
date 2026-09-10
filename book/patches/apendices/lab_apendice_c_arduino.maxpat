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
		"description" : "Laboratorio Apendice C: Lectura Serial Robusta con Arduino para Instalaciones",
		"digest" : "",
		"tags" : "MaxMSP, Arduino, Serial, Physical Computing, Hardware, Installation",
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
					"text" : "APÉNDICE C: Lectura Serial Robusta de Microcontroladores (Arduino a 115200 baudios)"
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
					"text" : "Receptor serial a prueba de fallos para instalaciones interactivas. Decodifica tramas ASCII delimitadas por salto de línea [sel 13 10], reconstruye los enteros analógicos con [zl.group] e [itoa], y modula la síntesis de audio sin desincronización por pérdida de bytes."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-toggle-poll",
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
					"id" : "obj-metro-serial",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 30.0, 160.0, 63.0, 22.0 ],
					"text" : "metro 10"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-print-ports",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 120.0, 160.0, 39.0, 22.0 ],
					"text" : "print"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-serial-port",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "" ],
					"patching_rect" : [ 30.0, 210.0, 125.0, 22.0 ],
					"text" : "serial c 115200"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sel-delimiters",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 3,
					"outlettype" : [ "bang", "bang", "" ],
					"patching_rect" : [ 30.0, 260.0, 68.0, 22.0 ],
					"text" : "sel 13 10"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-zl-group",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 79.0, 310.0, 75.0, 22.0 ],
					"text" : "zl.group 100"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-itoa",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 79.0, 350.0, 40.0, 22.0 ],
					"text" : "itoa"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-fromsymbol",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 79.0, 390.0, 71.0, 22.0 ],
					"text" : "fromsymbol"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-unpack-sensors",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "int", "int", "int" ],
					"patching_rect" : [ 79.0, 430.0, 80.0, 22.0 ],
					"text" : "unpack 0 0 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-num-s1",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 40.0, 480.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-num-s2",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 100.0, 480.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-num-s3",
					"maxclass" : "number",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 160.0, 480.0, 50.0, 22.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-scale-audio",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 40.0, 520.0, 137.0, 22.0 ],
					"text" : "scale 0 1023 100. 800."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sig-synth",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 40.0, 560.0, 66.0, 22.0 ],
					"text" : "cycle~ 220"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-atten-headroom",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 40.0, 600.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 650.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-metro-serial", 0 ],
					"source" : [ "obj-toggle-poll", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-serial-port", 0 ],
					"source" : [ "obj-metro-serial", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-serial-port", 0 ],
					"source" : [ "obj-msg-print-ports", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sel-delimiters", 0 ],
					"source" : [ "obj-serial-port", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-zl-group", 0 ],
					"source" : [ "obj-sel-delimiters", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-zl-group", 0 ],
					"source" : [ "obj-sel-delimiters", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-itoa", 0 ],
					"source" : [ "obj-zl-group", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-fromsymbol", 0 ],
					"source" : [ "obj-itoa", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-unpack-sensors", 0 ],
					"source" : [ "obj-fromsymbol", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-num-s1", 0 ],
					"source" : [ "obj-unpack-sensors", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-num-s2", 0 ],
					"source" : [ "obj-unpack-sensors", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-num-s3", 0 ],
					"source" : [ "obj-unpack-sensors", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-scale-audio", 0 ],
					"source" : [ "obj-num-s1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sig-synth", 0 ],
					"source" : [ "obj-scale-audio", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-atten-headroom", 0 ],
					"source" : [ "obj-sig-synth", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 0,
					"source" : [ "obj-atten-headroom", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-atten-headroom", 0 ]
				}

			}
 ]
	}

}
