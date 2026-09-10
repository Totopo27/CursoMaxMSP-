{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 337.0, 44.0, 552.0, 360.0 ],
		"bglocked" : 0,
		"defrect" : [ 337.0, 44.0, 552.0, 360.0 ],
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
					"text" : "gain",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 195.0, 270.0, 33.0, 20.0 ],
					"id" : "obj-19",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 135.0, 270.0, 50.0, 20.0 ],
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-15",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "generate a new waveform",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 360.0, 180.0, 149.0, 20.0 ],
					"id" : "obj-13",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 150.0, 180.0, 60.0, 20.0 ],
					"outlettype" : [ "bang" ],
					"id" : "obj-4",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numoutlets" : 0,
					"patching_rect" : [ 60.0, 285.0, 45.0, 45.0 ],
					"id" : "obj-12",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.1",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 60.0, 240.0, 42.0, 20.0 ],
					"outlettype" : [ "signal" ],
					"id" : "obj-11",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "wave~ wavy",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 60.0, 210.0, 76.0, 20.0 ],
					"outlettype" : [ "signal" ],
					"id" : "obj-10",
					"fontname" : "Arial",
					"numinlets" : 3
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "phasor~ 450",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 60.0, 180.0, 78.0, 20.0 ],
					"outlettype" : [ "signal" ],
					"id" : "obj-9",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "linefunc1 12",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 270.0, 180.0, 75.0, 18.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-8",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"numoutlets" : 6,
					"patching_rect" : [ 60.0, 30.0, 339.0, 141.0 ],
					"outlettype" : [ "float", "float", "float", "float", "list", "" ],
					"id" : "obj-6",
					"textcolor" : [  ],
					"buffername" : "wavy",
					"numinlets" : 5
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "sizeinsamps 8192",
					"fontsize" : 12.0,
					"numoutlets" : 1,
					"patching_rect" : [ 150.0, 210.0, 107.0, 18.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-5",
					"fontname" : "Arial",
					"numinlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "poke~ wavy",
					"fontsize" : 12.0,
					"numoutlets" : 0,
					"patching_rect" : [ 270.0, 240.0, 74.0, 20.0 ],
					"id" : "obj-3",
					"fontname" : "Arial",
					"numinlets" : 3
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ wavy",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 150.0, 240.0, 79.0, 20.0 ],
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-2",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "js dssfunc",
					"fontsize" : 12.0,
					"numoutlets" : 2,
					"patching_rect" : [ 270.0, 210.0, 64.0, 20.0 ],
					"outlettype" : [ "", "" ],
					"id" : "obj-1",
					"fontname" : "Arial",
					"numinlets" : 1
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-11", 1 ],
					"hidden" : 0,
					"midpoints" : [ 144.5, 299.0, 126.0, 299.0, 126.0, 232.0, 92.5, 232.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 1 ],
					"destination" : [ "obj-3", 1 ],
					"hidden" : 0,
					"midpoints" : [ 324.5, 234.5, 307.0, 234.5 ]
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
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-12", 1 ],
					"hidden" : 0,
					"midpoints" : [ 69.5, 272.0, 95.5, 272.0 ]
				}

			}
 ]
	}

}
