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
		"description" : "Laboratorio Apendice A: Visualizacion Reactiva 3D con Jitter y jit.world",
		"digest" : "",
		"tags" : "MaxMSP, Jitter, OpenGL, 3D, Audio Reactive, jit.world",
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
					"text" : "APÉNDICE A: Computación Visual Reactiva 3D con Jitter (jit.world & GPU)"
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
					"text" : "Demuestra el pipeline acelerado por GPU en Jitter. El audio de un oscilador es analizado en tiempo real por [jit.catch~] para modular la escala y rotación de un objeto geométrico tridimensional (Toroide) dentro de un contexto de renderizado [jit.world]."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-world-toggle",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 120.0, 30.0, 30.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-comment-world",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 70.0, 125.0, 250.0, 22.0 ],
					"text" : "<-- Activar Contexto Gráfico 3D (jit.world)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-world",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "jit_matrix", "bang", "" ],
					"patching_rect" : [ 30.0, 170.0, 280.0, 22.0 ],
					"text" : "jit.world ctx_apendice_a @floating 1 @size 400 300"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-osc-audio",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 380.0, 120.0, 66.0, 22.0 ],
					"text" : "cycle~ 110"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-peak-amp",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"patching_rect" : [ 380.0, 170.0, 81.0, 22.0 ],
					"text" : "peakamp~ 20"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-scale-mod",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 380.0, 210.0, 115.0, 22.0 ],
					"text" : "scale 0. 1. 0.4 1.2"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-scale",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 380.0, 250.0, 105.0, 22.0 ],
					"text" : "scale $1 $1 $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-render-bang",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 160.0, 210.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-accum-rot",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"patching_rect" : [ 160.0, 250.0, 60.0, 22.0 ],
					"text" : "accum 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-rot",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 160.0, 285.0, 110.0, 22.0 ],
					"text" : "rotatexyz $1 $1 0."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gl-shape",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "jit_matrix", "" ],
					"patching_rect" : [ 160.0, 340.0, 420.0, 22.0 ],
					"text" : "jit.gl.gridshape ctx_apendice_a @shape torus @lighting_enable 1 @smooth_shading 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gain-audio",
					"maxclass" : "gain~",
					"multichannelvariant" : 0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 380.0, 390.0, 140.0, 25.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 380.0, 440.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-world", 0 ],
					"source" : [ "obj-world-toggle", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-render-bang", 0 ],
					"source" : [ "obj-world", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-accum-rot", 0 ],
					"source" : [ "obj-render-bang", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-msg-rot", 0 ],
					"source" : [ "obj-accum-rot", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-peak-amp", 0 ],
					"order" : 1,
					"source" : [ "obj-osc-audio", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gain-audio", 0 ],
					"order" : 0,
					"source" : [ "obj-osc-audio", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-scale-mod", 0 ],
					"source" : [ "obj-peak-amp", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-msg-scale", 0 ],
					"source" : [ "obj-scale-mod", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gl-shape", 0 ],
					"source" : [ "obj-msg-rot", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gl-shape", 0 ],
					"source" : [ "obj-msg-scale", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 0,
					"source" : [ "obj-gain-audio", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-gain-audio", 0 ]
				}

			}
 ]
	}

}
