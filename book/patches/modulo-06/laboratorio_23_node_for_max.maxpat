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
		"description" : "Laboratorio 23: Node for Max [node.script] y Comunicacion IPC Asincrona",
		"digest" : "",
		"tags" : "MaxMSP, Node for Max, N4M, IPC, Node.js, HTTP, REST",
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
					"text" : "LABORATORIO 23: Node for Max (N4M) y Comunicación Asíncrona IPC"
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
					"text" : "Este laboratorio lanza un proceso independiente de Node.js administrado por [node.script]. Permite iniciar un servidor HTTP local en segundo plano que recibe datos externos y modula la frecuencia de un sintetizador FM sin bloquear el Scheduler de Max."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-start",
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
					"id" : "obj-msg-stop",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 105.0, 120.0, 64.0, 22.0 ],
					"text" : "script stop"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-iniciar-srv",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 185.0, 120.0, 72.0, 22.0 ],
					"text" : "iniciar 8080"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-detener-srv",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 265.0, 120.0, 50.0, 22.0 ],
					"text" : "detener"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-node-script",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 30.0, 170.0, 175.0, 22.0 ],
					"text" : "node.script servidor_analisis.js"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-route-ipc",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 30.0, 215.0, 170.0, 22.0 ],
					"text" : "route sensor_data status"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-unpack-xyz",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "float", "float", "float" ],
					"patching_rect" : [ 30.0, 260.0, 90.0, 22.0 ],
					"text" : "unpack 0. 0. 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-status-print",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 140.0, 260.0, 150.0, 22.0 ],
					"text" : "status ..."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-scale-freq",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 310.0, 125.0, 22.0 ],
					"text" : "scale 0. 100. 150. 800."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-sig-freq",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "bang" ],
					"patching_rect" : [ 30.0, 350.0, 58.0, 22.0 ],
					"text" : "line~ 220."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-carrier",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 30.0, 390.0, 43.0, 22.0 ],
					"text" : "cycle~"
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
					"patching_rect" : [ 30.0, 435.0, 140.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 30.0, 485.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-node-script", 0 ],
					"source" : [ "obj-msg-start", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-node-script", 0 ],
					"source" : [ "obj-msg-stop", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-node-script", 0 ],
					"source" : [ "obj-msg-iniciar-srv", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-node-script", 0 ],
					"source" : [ "obj-msg-detener-srv", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-route-ipc", 0 ],
					"source" : [ "obj-node-script", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-unpack-xyz", 0 ],
					"source" : [ "obj-route-ipc", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-status-print", 1 ],
					"source" : [ "obj-route-ipc", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-scale-freq", 0 ],
					"source" : [ "obj-unpack-xyz", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-sig-freq", 0 ],
					"source" : [ "obj-scale-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-carrier", 0 ],
					"source" : [ "obj-sig-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-master", 0 ],
					"source" : [ "obj-carrier", 0 ]
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
