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
		"openinpresentation" : 1,
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
		"devicewidth" : 540.0,
		"description" : "Laboratorio Apendice H: Max for Live y Live Object Model (LOM) — Disparo probabilistico de clips via LOM API",
		"digest" : "",
		"tags" : "MaxMSP, Max for Live, M4L, Ableton, LOM, Live Object Model, clips, probabilistic",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 		{
			"box" : 			{
				"fontsize" : 16.0,
				"fontface" : 1,
				"id" : "obj-title",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 15.0, 800.0, 24.0 ],
				"text" : "APENDICE H - Live Object Model (LOM): Secuenciador de Clips Probabilistico"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-desc",
				"linecount" : 4,
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 45.0, 900.0, 64.0 ],
				"text" : "CONCEPTO: Dispositivo M4L que navega la jerarquia canonica del LOM (live_set > tracks > clip_slots) para detectar la pista actual (canonical_parent via live.this_device), monitorear el transporte maestro (is_playing, tempo) y disparar clips segun reglas probabilisticas. Ref: Apendice H del Curso Max/MSP."
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-sep1",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 120.0, 700.0, 20.0 ],
				"text" : "--- BLOQUE 1: Transporte y Tempo Maestro de Ableton Live ---"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-lp-obs-playing",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 148.0, 260.0, 22.0 ],
				"text" : "live.observer @path live_set @property is_playing"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-lp-obs-tempo",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 300.0, 148.0, 260.0, 22.0 ],
				"text" : "live.observer @path live_set @property tempo"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-is-playing-num",
				"maxclass" : "number",
				"numinlets" : 1,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 180.0, 80.0, 22.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-is-playing-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 110.0, 183.0, 100.0, 20.0 ],
				"text" : "<- is_playing"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-tempo-display",
				"maxclass" : "flonum",
				"numinlets" : 1,
				"numoutlets" : 2,
				"patching_rect" : [ 300.0, 180.0, 80.0, 22.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-tempo-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 390.0, 183.0, 80.0, 20.0 ],
				"text" : "<- BPM"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-sep2",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 220.0, 700.0, 20.0 ],
				"text" : "--- BLOQUE 2: Identificacion de la Pista Actual (canonical_parent via live.this_device) ---"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-this-device",
				"maxclass" : "newobj",
				"numinlets" : 0,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 248.0, 150.0, 22.0 ],
				"text" : "live.this_device"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-get-parent",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 280.0, 150.0, 22.0 ],
				"text" : "live.object"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-get-name-msg",
				"maxclass" : "message",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 20.0, 313.0, 90.0, 22.0 ],
				"text" : "get name"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-track-name-display",
				"maxclass" : "newobj",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 120.0, 313.0, 200.0, 22.0 ],
				"text" : "print TRACK-ACTUAL"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-sep3",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 355.0, 700.0, 20.0 ],
				"text" : "--- BLOQUE 3: Disparo Probabilistico de Clip en Track 0, Slot 0 ---"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-prob-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 385.0, 130.0, 20.0 ],
				"text" : "Probabilidad (0-100):"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-prob-slider",
				"maxclass" : "slider",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 160.0, 382.0, 200.0, 22.0 ],
				"size" : 101,
				"parameter_enable" : 1,
				"saved_attribute_attributes" : 				{
					"valueof" : 					{
						"parameter_longname" : "Prob_Disparo",
						"parameter_shortname" : "Prob",
						"parameter_type" : 1,
						"parameter_mmin" : 0.0,
						"parameter_mmax" : 100.0,
						"parameter_initial_enable" : 1,
						"parameter_initial" : [ 70 ]
					}

				}

			}

		}
, 		{
			"box" : 			{
				"id" : "obj-prob-num",
				"maxclass" : "number",
				"numinlets" : 1,
				"numoutlets" : 2,
				"patching_rect" : [ 370.0, 385.0, 50.0, 22.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-trigger-btn",
				"maxclass" : "button",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 20.0, 422.0, 30.0, 30.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-trigger-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 60.0, 429.0, 220.0, 20.0 ],
				"text" : "Bang: evaluar probabilidad y disparar clip"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-random-gate",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 20.0, 465.0, 90.0, 22.0 ],
				"text" : "random 100"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-lt-prob",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 125.0, 465.0, 60.0, 22.0 ],
				"text" : "< 70"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-gate-clip",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 125.0, 498.0, 60.0, 22.0 ],
				"text" : "gate"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-fire-clip-msg",
				"maxclass" : "message",
				"numinlets" : 2,
				"numoutlets" : 1,
				"patching_rect" : [ 125.0, 531.0, 170.0, 22.0 ],
				"text" : "call fire_as_selected"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-clip-slot",
				"maxclass" : "newobj",
				"numinlets" : 2,
				"numoutlets" : 2,
				"patching_rect" : [ 125.0, 564.0, 300.0, 22.0 ],
				"text" : "live.object @path live_set tracks 0 clip_slots 0"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-fired-label",
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 20.0, 600.0, 170.0, 20.0 ],
				"text" : "Clip disparado (Track 0, Slot 0):"
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-fired-led",
				"maxclass" : "button",
				"numinlets" : 1,
				"numoutlets" : 1,
				"patching_rect" : [ 200.0, 597.0, 20.0, 20.0 ]
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-nota-arch",
				"linecount" : 5,
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 460.0, 148.0, 560.0, 80.0 ],
				"text" : "ARQUITECTURA M4L: Corre en el espacio de memoria de Ableton Live. [live.this_device] expone el path canonico de este dispositivo en la jerarquia LOM. [live.observer] suscribe cambios de propiedades sin polling (modelo push puro). Compatible con MIDI Effect y Audio Effect device type."
			}

		}
, 		{
			"box" : 			{
				"id" : "obj-nota-prob",
				"linecount" : 4,
				"maxclass" : "comment",
				"numinlets" : 1,
				"numoutlets" : 0,
				"patching_rect" : [ 460.0, 355.0, 560.0, 65.0 ],
				"text" : "MOTOR PROBABILISTICO: [random 100] genera entero uniforme en [0,99]. [< N] compara con el umbral del slider (0-100%). [gate] deja pasar el bang solo si la condicion se cumple. Prob=100% siempre dispara. Prob=0% nunca dispara. Cambia tracks/clip_slots index para otros slots."
			}

		}
],
		"lines" : [ 		{
			"patchline" : 			{
				"source" : [ "obj-lp-obs-playing", 0 ],
				"destination" : [ "obj-is-playing-num", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-lp-obs-tempo", 0 ],
				"destination" : [ "obj-tempo-display", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-this-device", 1 ],
				"destination" : [ "obj-get-parent", 1 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-get-parent", 0 ],
				"destination" : [ "obj-get-name-msg", 1 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-get-name-msg", 0 ],
				"destination" : [ "obj-track-name-display", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-prob-slider", 0 ],
				"destination" : [ "obj-prob-num", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-prob-slider", 0 ],
				"destination" : [ "obj-lt-prob", 1 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-trigger-btn", 0 ],
				"destination" : [ "obj-random-gate", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-random-gate", 0 ],
				"destination" : [ "obj-lt-prob", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-lt-prob", 0 ],
				"destination" : [ "obj-gate-clip", 1 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-trigger-btn", 0 ],
				"destination" : [ "obj-gate-clip", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-gate-clip", 0 ],
				"destination" : [ "obj-fire-clip-msg", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-gate-clip", 0 ],
				"destination" : [ "obj-fired-led", 0 ]
			}

		}
, 		{
			"patchline" : 			{
				"source" : [ "obj-fire-clip-msg", 0 ],
				"destination" : [ "obj-clip-slot", 0 ]
			}

		}
]
	}

}
