{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 192.0, 128.0, 947.0, 704.0 ],
		"bglocked" : 0,
		"defrect" : [ 192.0, 128.0, 947.0, 704.0 ],
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
					"text" : "4. paste the chunk to another buffer",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 105.0, 240.0, 200.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-21",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "3. cut the chunk",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 210.0, 210.0, 95.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-13",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "1. load sound file",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 90.0, 60.0, 101.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-10",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"buffername" : "receiver",
					"numinlets" : 5,
					"patching_rect" : [ 300.0, 135.0, 182.0, 67.0 ],
					"numoutlets" : 6,
					"id" : "obj-8",
					"textcolor" : [  ],
					"outlettype" : [ "float", "float", "float", "float", "list", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ receiver 2000 2",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 75.0, 165.0, 134.0, 20.0 ],
					"numoutlets" : 2,
					"id" : "obj-5",
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "cut 1177.936523 1221.020508",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 315.0, 210.0, 187.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-22",
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend cut",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 225.0, 165.0, 74.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-20",
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pack f f",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 225.0, 135.0, 49.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-19",
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "replace $1",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 75.0, 105.0, 67.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-18",
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "dropfile",
					"numinlets" : 1,
					"types" : [  ],
					"patching_rect" : [ 75.0, 45.0, 132.0, 46.0 ],
					"numoutlets" : 2,
					"id" : "obj-15",
					"outlettype" : [ "", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "2. drag over it to select a region to cut",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 229.0, 20.0, 211.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-16",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"buffername" : "samps",
					"numinlets" : 5,
					"setmode" : 1,
					"patching_rect" : [ 225.0, 45.0, 231.0, 62.0 ],
					"numoutlets" : 6,
					"id" : "obj-11",
					"textcolor" : [  ],
					"outlettype" : [ "float", "float", "float", "float", "list", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "bed samps",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 330.0, 300.0, 69.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-2",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ samps 2 2",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 75.0, 135.0, 107.0, 20.0 ],
					"numoutlets" : 2,
					"id" : "obj-1",
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "paste receiver",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 105.0, 270.0, 86.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-14",
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [ 84.5, 128.5, 84.5, 128.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [ 324.5, 259.5, 339.5, 259.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-22", 1 ],
					"hidden" : 0,
					"midpoints" : [ 234.5, 206.0, 492.5, 206.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 2 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [ 319.299988, 116.5, 234.5, 116.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 3 ],
					"destination" : [ "obj-19", 1 ],
					"hidden" : 0,
					"midpoints" : [ 361.700012, 120.5, 264.5, 120.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [ 114.5, 293.0, 339.5, 293.0 ]
				}

			}
 ]
	}

}
