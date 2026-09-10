{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 25.0, 69.0, 928.0, 602.0 ],
		"bglocked" : 0,
		"defrect" : [ 25.0, 69.0, 928.0, 602.0 ],
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
					"maxclass" : "comment",
					"text" : "initialize waveform",
					"id" : "obj-33",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 150.0, 75.0, 109.0, 20.0 ],
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "set frequency extremes",
					"id" : "obj-31",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 555.0, 75.0, 135.0, 20.0 ],
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "directly set frequency",
					"id" : "obj-29",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 480.0, 45.0, 124.0, 20.0 ],
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "duration dev",
					"id" : "obj-27",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 375.0, 45.0, 77.0, 20.0 ],
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "extremity dev",
					"id" : "obj-24",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 270.0, 45.0, 82.0, 20.0 ],
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "display current frequency",
					"id" : "obj-17",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 435.0, 195.0, 145.0, 20.0 ],
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "freqbounds 440 880",
					"outlettype" : [ "" ],
					"presentation_rect" : [ 326.0, 24.0, 0.0, 0.0 ],
					"id" : "obj-10",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 555.0, 105.0, 117.0, 18.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-25",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 480.0, 75.0, 50.0, 20.0 ],
					"numoutlets" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-18",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 375.0, 75.0, 50.0, 20.0 ],
					"minimum" : 0.0,
					"numoutlets" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "y_deviation $1",
					"outlettype" : [ "" ],
					"id" : "obj-20",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 375.0, 105.0, 88.0, 18.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-19",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 270.0, 75.0, 50.0, 20.0 ],
					"minimum" : 0.0,
					"numoutlets" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"outlettype" : [ "bang" ],
					"id" : "obj-6",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 420.0, 255.0, 60.0, 20.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"outlettype" : [ "int" ],
					"id" : "obj-15",
					"numinlets" : 1,
					"patching_rect" : [ 135.0, 195.0, 20.0, 20.0 ],
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"outlettype" : [ "float", "float", "float", "float", "list", "" ],
					"id" : "obj-13",
					"buffername" : "showme",
					"numinlets" : 5,
					"patching_rect" : [ 135.0, 345.0, 634.0, 76.0 ],
					"numoutlets" : 6,
					"textcolor" : [  ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "record~ showme",
					"outlettype" : [ "signal" ],
					"id" : "obj-12",
					"fontname" : "Arial",
					"numinlets" : 3,
					"patching_rect" : [ 165.0, 240.0, 100.0, 20.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "sizeinsamps 512",
					"outlettype" : [ "" ],
					"id" : "obj-11",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 420.0, 285.0, 107.0, 18.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ showme",
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-9",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 420.0, 315.0, 96.0, 20.0 ],
					"numoutlets" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-8",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 285.0, 195.0, 50.0, 20.0 ],
					"numoutlets" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"id" : "obj-5",
					"numinlets" : 2,
					"patching_rect" : [ 270.0, 285.0, 45.0, 45.0 ],
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "meter~",
					"outlettype" : [ "float" ],
					"id" : "obj-4",
					"numinlets" : 1,
					"patching_rect" : [ 330.0, 315.0, 80.0, 13.0 ],
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.01",
					"outlettype" : [ "signal" ],
					"id" : "obj-3",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 270.0, 225.0, 50.0, 20.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number~",
					"outlettype" : [ "signal", "float" ],
					"id" : "obj-2",
					"fontname" : "Arial",
					"numinlets" : 2,
					"sig" : 0.0,
					"patching_rect" : [ 375.0, 195.0, 56.0, 20.0 ],
					"numoutlets" : 2,
					"mode" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "dynstoch~",
					"outlettype" : [ "signal", "signal" ],
					"id" : "obj-1",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 270.0, 150.0, 66.0, 20.0 ],
					"numoutlets" : 2,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "x_deviation $1",
					"outlettype" : [ "" ],
					"id" : "obj-16",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 270.0, 105.0, 86.0, 18.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "initwave",
					"outlettype" : [ "" ],
					"id" : "obj-21",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 150.0, 105.0, 52.0, 18.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "setfreq $1",
					"outlettype" : [ "" ],
					"id" : "obj-22",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 480.0, 105.0, 64.0, 18.0 ],
					"numoutlets" : 1,
					"fontsize" : 12.0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 564.5, 136.0, 279.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 1 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 264.5, 305.5, 264.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 249.5, 339.5, 249.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-3", 1 ],
					"hidden" : 0,
					"midpoints" : [ 294.5, 219.5, 310.5, 219.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 489.5, 136.0, 279.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 384.5, 136.0, 279.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 136.0, 279.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 144.5, 227.0, 174.5, 227.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 209.5, 174.5, 209.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 1 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [ 326.5, 182.0, 384.5, 182.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 136.0, 279.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-25", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
