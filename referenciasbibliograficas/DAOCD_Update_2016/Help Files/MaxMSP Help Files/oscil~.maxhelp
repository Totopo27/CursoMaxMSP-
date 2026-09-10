{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 150.0, 44.0, 509.0, 391.0 ],
		"bglocked" : 0,
		"defrect" : [ 150.0, 44.0, 509.0, 391.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "pulse",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 313.0, 105.0, 41.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-1"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "sawtooth",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 244.0, 105.0, 65.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-2"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "square",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 187.0, 105.0, 50.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-3"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "triangle",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 125.0, 105.0, 57.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-4"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "sine",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 81.0, 105.0, 33.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-5"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 59.0, 319.0, 33.0, 33.0 ],
					"id" : "obj-6"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "int" ],
					"patching_rect" : [ 60.0, 240.0, 23.0, 65.0 ],
					"id" : "obj-7",
					"orientation" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p more_messages",
					"numinlets" : 0,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 135.0, 165.0, 117.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-8",
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 20.0, 74.0, 392.0, 370.0 ],
						"bglocked" : 0,
						"defrect" : [ 20.0, 74.0, 392.0, 370.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "flonum",
									"numinlets" : 1,
									"fontname" : "Arial",
									"triscale" : 0.9,
									"numoutlets" : 2,
									"outlettype" : [ "float", "bang" ],
									"patching_rect" : [ 86.0, 202.0, 55.0, 20.0 ],
									"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
									"fontsize" : 12.0,
									"id" : "obj-1",
									"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "fadetime $1",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 86.0, 252.0, 82.0, 18.0 ],
									"fontsize" : 12.0,
									"id" : "obj-2"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "2 - equal power fade",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"patching_rect" : [ 210.0, 150.0, 120.0, 20.0 ],
									"fontsize" : 12.0,
									"id" : "obj-3"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "1 - linear fade",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"patching_rect" : [ 210.0, 135.0, 97.0, 20.0 ],
									"fontsize" : 12.0,
									"id" : "obj-4"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "number",
									"numinlets" : 1,
									"fontname" : "Arial",
									"triscale" : 0.9,
									"numoutlets" : 2,
									"outlettype" : [ "int", "bang" ],
									"patching_rect" : [ 123.0, 95.0, 37.0, 20.0 ],
									"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
									"fontsize" : 12.0,
									"id" : "obj-5",
									"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "fadetype $1",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 123.0, 118.0, 82.0, 18.0 ],
									"fontsize" : 12.0,
									"id" : "obj-6"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "toggle",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 45.0, 45.0, 20.0, 20.0 ],
									"id" : "obj-7"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "mute $1",
									"numinlets" : 2,
									"fontname" : "Arial",
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 45.0, 75.0, 54.0, 18.0 ],
									"fontsize" : 12.0,
									"id" : "obj-8"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 45.0, 285.0, 25.0, 25.0 ],
									"id" : "obj-9",
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "set fade type with the following arguments:",
									"linecount" : 2,
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"patching_rect" : [ 165.0, 75.0, 125.0, 34.0 ],
									"fontsize" : 12.0,
									"id" : "obj-10"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "0 - no fade",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"patching_rect" : [ 210.0, 120.0, 75.0, 20.0 ],
									"fontsize" : 12.0,
									"id" : "obj-11"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "specify fade time in milliseconds. (default is 50 ms)",
									"linecount" : 2,
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"patching_rect" : [ 150.0, 195.0, 200.0, 34.0 ],
									"fontsize" : 12.0,
									"id" : "obj-12"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "mute object and save some CPU cycles",
									"numinlets" : 1,
									"fontname" : "Arial",
									"numoutlets" : 0,
									"patching_rect" : [ 75.0, 45.0, 223.0, 20.0 ],
									"fontsize" : 12.0,
									"id" : "obj-13"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [ 54.5, 194.0, 54.5, 194.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [ 132.5, 187.0, 54.5, 187.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [ 95.5, 273.0, 54.5, 273.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"default_fontsize" : 12.0,
						"fontname" : "Arial",
						"fontface" : 0,
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"globalpatchername" : ""
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0 1 0.5 0 0 0.3 0.1",
					"numinlets" : 2,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 105.0, 135.0, 126.0, 18.0 ],
					"fontsize" : 12.0,
					"id" : "obj-9"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"fontname" : "Arial",
					"triscale" : 0.9,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 15.0, 150.0, 40.0, 20.0 ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-10",
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "oscil~ 85 16384 sawtooth 16",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 60.0, 210.0, 164.0, 20.0 ],
					"fontsize" : 12.0,
					"color" : [ 1.0, 0.360784, 0.682353, 1.0 ],
					"id" : "obj-11"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "specify waveform by name",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 90.0, 75.0, 174.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-12"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "or harmonic weighting",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 240.0, 135.0, 143.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-13"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "args: frequency, table length, waveform, harmonic count",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 106.0, 227.0, 359.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-14"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "oscil~ is an oscillator that provides some features not found in cycle~. oscil~ wavetables can be of any length between 4 - 1048576. Waveforms can be specified by name or with a list of harmonic weights, starting with the DC component. oscil~ can also execute a customizable crossfade when its waveform is changed.",
					"linecount" : 6,
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 131.0, 258.0, 352.0, 89.0 ],
					"fontsize" : 12.0,
					"id" : "obj-15"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Oscil~ a fun new oscillator",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 90.0, 30.0, 315.0, 34.0 ],
					"fontsize" : 24.0,
					"id" : "obj-16"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "frequency",
					"numinlets" : 1,
					"fontname" : "Arial",
					"numoutlets" : 0,
					"patching_rect" : [ 15.0, 120.0, 63.0, 20.0 ],
					"fontsize" : 12.0,
					"id" : "obj-17"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 322.5, 126.0, 69.5, 126.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 253.5, 126.0, 69.5, 126.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 196.5, 126.0, 69.5, 126.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 134.5, 126.0, 69.5, 126.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 90.5, 126.0, 69.5, 126.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 24.5, 187.0, 69.5, 187.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 114.5, 195.0, 69.5, 195.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 144.5, 201.0, 69.5, 201.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-6", 1 ],
					"hidden" : 0,
					"midpoints" : [ 69.5, 312.0, 82.5, 312.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
