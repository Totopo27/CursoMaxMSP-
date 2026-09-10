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
		"rect" : [ 80.0, 80.0, 1050.0, 750.0 ],
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
		"description" : "Proyecto Integrador 05: Sintetizador Waveguide Resonator en gen~",
		"digest" : "",
		"tags" : "MaxMSP, Gen~, Waveguide, Physical Modeling, Digital Audio",
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
					"text" : "PROYECTO INTEGRADOR 05: Sintetizador de Modelado Físico (Waveguide Mesh en gen~)"
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
					"text" : "Implementación de una guía de onda acústica bidireccional (Digital Waveguide) en gen~ con dispersión dependiente de la frecuencia (stiffness), filtro de pérdidas de alta frecuencia (brightness) y atenuador anti-clipping de seguridad de -12 dB."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-kslider",
					"maxclass" : "kslider",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "int", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 30.0, 115.0, 336.0, 53.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-mtof",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 180.0, 34.0, 22.0 ],
					"text" : "mtof"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-msg-freq",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 30.0, 215.0, 50.0, 22.0 ],
					"text" : "freq $1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-bang-pluck",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 150.0, 180.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-click",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 215.0, 41.0, 22.0 ],
					"text" : "click~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-pluck-shape",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 250.0, 72.0, 22.0 ],
					"text" : "lores~ 1200 0.8"
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
					"patching_rect" : [ 380.0, 140.0, 150.0, 22.0 ],
					"attr" : "damping"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-att-bright",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 380.0, 170.0, 150.0, 22.0 ],
					"attr" : "brightness"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-att-stiff",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 380.0, 200.0, 150.0, 22.0 ],
					"attr" : "stiffness"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-att-pickup",
					"maxclass" : "attrui",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 380.0, 230.0, 150.0, 22.0 ],
					"attr" : "pickup_pos"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-gen-waveguide",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 150.0, 310.0, 250.0, 22.0 ],
					"text" : "gen~ @title WaveguideCore",
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
						"rect" : [ 100.0, 100.0, 650.0, 500.0 ],
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
									"id" : "obj-wg-in1",
									"maxclass" : "newobj",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 30.0, 20.0, 28.0, 22.0 ],
									"text" : "in 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-wg-codebox",
									"linecount" : 18,
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 30.0, 60.0, 550.0, 270.0 ],
									"text" : "codebox",
									"code" : "Param freq(220, min=20, max=5000);\r\nParam damping(0.985, min=0.5, max=0.9999);\r\nParam brightness(0.5, min=0.01, max=0.99);\r\nParam stiffness(0.2, min=-0.8, max=0.8);\r\nParam pickup_pos(0.3, min=0.05, max=0.95);\r\n\r\nHistory d_right_hist(0);\r\nHistory d_left_hist(0);\r\nHistory loss_hist(0);\r\nHistory ap_x1(0);\r\nHistory ap_y1(0);\r\n\r\nin_sig = in1;\r\nsr = samplerate();\r\nperiod_samples = max(4, sr / freq);\r\ndelay_len = max(2, period_samples * 0.5);\r\n\r\nright_wave = delay(in_sig + d_left_hist, delay_len, interp=\"spline\");\r\nloss_filter = right_wave * (1 - brightness) + loss_hist * brightness;\r\nloss_hist = loss_filter;\r\n\r\nap_in = loss_filter * damping;\r\nap_out = (ap_in * stiffness) + ap_x1 - (stiffness * ap_y1);\r\nap_x1 = ap_in;\r\nap_y1 = ap_out;\r\n\r\nleft_wave = delay(-ap_out, delay_len, interp=\"spline\");\r\nd_right_hist = right_wave;\r\nd_left_hist = tanh(left_wave);\r\n\r\nout1 = (right_wave * pickup_pos) + (left_wave * (1.0 - pickup_pos));\r\nout2 = (right_wave * (1.0 - pickup_pos)) + (left_wave * pickup_pos);"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-wg-out1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 30.0, 360.0, 35.0, 22.0 ],
									"text" : "out 1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-wg-out2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 150.0, 360.0, 35.0, 22.0 ],
									"text" : "out 2"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-wg-codebox", 0 ],
									"source" : [ "obj-wg-in1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-wg-out1", 0 ],
									"source" : [ "obj-wg-codebox", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-wg-out2", 0 ],
									"source" : [ "obj-wg-codebox", 1 ]
								}

							}
 ]
					}

				}

			}
, 			{
				"box" : 				{
					"id" : "obj-headroom-L",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 360.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-headroom-R",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 250.0, 360.0, 47.0, 22.0 ],
					"text" : "*~ 0.25"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-meter-L",
					"maxclass" : "live.meter~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "hidden" ],
					"patching_rect" : [ 210.0, 400.0, 16.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-meter-R",
					"maxclass" : "live.meter~",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "hidden" ],
					"patching_rect" : [ 310.0, 400.0, 16.0, 100.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-ezdac",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 150.0, 440.0, 45.0, 45.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-mtof", 0 ],
					"source" : [ "obj-kslider", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-bang-pluck", 0 ],
					"source" : [ "obj-kslider", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-msg-freq", 0 ],
					"source" : [ "obj-mtof", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-waveguide", 0 ],
					"source" : [ "obj-msg-freq", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-click", 0 ],
					"source" : [ "obj-bang-pluck", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-pluck-shape", 0 ],
					"source" : [ "obj-click", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-waveguide", 0 ],
					"source" : [ "obj-pluck-shape", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-waveguide", 0 ],
					"source" : [ "obj-att-damping", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-waveguide", 0 ],
					"source" : [ "obj-att-bright", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-waveguide", 0 ],
					"source" : [ "obj-att-stiff", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-gen-waveguide", 0 ],
					"source" : [ "obj-att-pickup", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-headroom-L", 0 ],
					"source" : [ "obj-gen-waveguide", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-headroom-R", 0 ],
					"source" : [ "obj-gen-waveguide", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 0 ],
					"order" : 1,
					"source" : [ "obj-headroom-L", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-meter-L", 0 ],
					"order" : 0,
					"source" : [ "obj-headroom-L", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-ezdac", 1 ],
					"order" : 1,
					"source" : [ "obj-headroom-R", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-meter-R", 0 ],
					"order" : 0,
					"source" : [ "obj-headroom-R", 0 ]
				}

			}
 ]
	}

}
