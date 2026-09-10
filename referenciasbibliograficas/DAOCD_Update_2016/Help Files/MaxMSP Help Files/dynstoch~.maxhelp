{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 25.0, 69.0, 722.0, 490.0 ],
		"bglocked" : 0,
		"defrect" : [ 25.0, 69.0, 722.0, 490.0 ],
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
					"text" : "dynstoch~ implements Iannis' Xenakis's dynamic stochastic synthesis scheme.",
					"patching_rect" : [ 15.0, 435.0, 429.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-11",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "freqbounds 50 8000",
					"patching_rect" : [ 450.0, 150.0, 135.0, 18.0 ],
					"fontname" : "Arial",
					"id" : "obj-34",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "initialize waveform",
					"patching_rect" : [ 45.0, 75.0, 109.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-33",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "set frequency extremes",
					"patching_rect" : [ 585.0, 105.0, 135.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-31",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "directly set frequency",
					"patching_rect" : [ 435.0, 75.0, 124.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-29",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "deviation of period length",
					"patching_rect" : [ 225.0, 15.0, 145.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-27",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "deviation of magnitudes of extrema",
					"patching_rect" : [ 255.0, 45.0, 197.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-24",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "display current frequency",
					"patching_rect" : [ 330.0, 195.0, 145.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-17",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "freqbounds 1200 1500",
					"patching_rect" : [ 450.0, 105.0, 132.0, 18.0 ],
					"fontname" : "Arial",
					"id" : "obj-10",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 375.0, 75.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-25",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"minimum" : 0.0,
					"patching_rect" : [ 195.0, 45.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-18",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "y_deviation $1",
					"patching_rect" : [ 270.0, 105.0, 88.0, 18.0 ],
					"fontname" : "Arial",
					"id" : "obj-20",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"minimum" : 0.0,
					"patching_rect" : [ 165.0, 15.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-19",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadmess sizeinsamps 512",
					"patching_rect" : [ 405.0, 285.0, 155.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-6",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"patching_rect" : [ 30.0, 195.0, 20.0, 20.0 ],
					"id" : "obj-15",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"buffername" : "showme",
					"patching_rect" : [ 15.0, 345.0, 634.0, 76.0 ],
					"textcolor" : [  ],
					"id" : "obj-13",
					"numinlets" : 5,
					"numoutlets" : 6,
					"outlettype" : [ "float", "float", "float", "float", "list", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "record~ showme",
					"patching_rect" : [ 60.0, 240.0, 100.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-12",
					"numinlets" : 3,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ showme",
					"patching_rect" : [ 405.0, 315.0, 96.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-9",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 180.0, 195.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-8",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"patching_rect" : [ 165.0, 285.0, 45.0, 45.0 ],
					"id" : "obj-5",
					"numinlets" : 2,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "meter~",
					"patching_rect" : [ 225.0, 315.0, 80.0, 13.0 ],
					"id" : "obj-4",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.01",
					"patching_rect" : [ 165.0, 225.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-3",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number~",
					"mode" : 2,
					"sig" : 0.0,
					"patching_rect" : [ 270.0, 195.0, 56.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-2",
					"numinlets" : 2,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "signal", "float" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "dynstoch~",
					"patching_rect" : [ 165.0, 150.0, 66.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-1",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "signal", "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "x_deviation $1",
					"patching_rect" : [ 165.0, 105.0, 86.0, 18.0 ],
					"fontname" : "Arial",
					"id" : "obj-16",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "initwave",
					"patching_rect" : [ 45.0, 105.0, 52.0, 18.0 ],
					"fontname" : "Arial",
					"id" : "obj-21",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "setfreq $1",
					"patching_rect" : [ 375.0, 105.0, 64.0, 18.0 ],
					"fontname" : "Arial",
					"id" : "obj-22",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 54.5, 136.0, 174.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 1 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [ 221.5, 182.0, 279.5, 182.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 174.5, 209.5, 69.5, 209.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 174.5, 136.0, 174.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 136.0, 174.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 384.5, 136.0, 174.5, 136.0 ]
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
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 459.5, 136.0, 174.5, 136.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 459.5, 177.0, 332.0, 177.0, 332.0, 140.0, 174.5, 140.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 1 ],
					"hidden" : 0,
					"midpoints" : [ 174.5, 264.5, 200.5, 264.5 ]
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
					"midpoints" : [ 174.5, 249.5, 234.5, 249.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-3", 1 ],
					"hidden" : 0,
					"midpoints" : [ 189.5, 219.5, 205.5, 219.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [ 204.5, 84.5, 279.5, 84.5 ]
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
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 227.0, 69.5, 227.0 ]
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
