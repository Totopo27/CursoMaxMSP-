{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 578.0, 224.0, 640.0, 506.0 ],
		"bglocked" : 0,
		"defrect" : [ 578.0, 224.0, 640.0, 506.0 ],
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
					"maxclass" : "newobj",
					"text" : "noise~",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 285.0, 45.0, 46.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-12",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"buffername" : "samps",
					"numinlets" : 5,
					"patching_rect" : [ 15.0, 120.0, 256.0, 64.0 ],
					"numoutlets" : 6,
					"id" : "obj-11",
					"textcolor" : [  ],
					"outlettype" : [ "float", "float", "float", "float", "list", "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"patching_rect" : [ 405.0, 135.0, 45.0, 45.0 ],
					"numoutlets" : 0,
					"id" : "obj-10"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numinlets" : 1,
					"patching_rect" : [ 360.0, 75.0, 20.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-9",
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number~",
					"mode" : 2,
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 285.0, 165.0, 56.0, 20.0 ],
					"numoutlets" : 2,
					"id" : "obj-7",
					"fontsize" : 12.0,
					"outlettype" : [ "signal", "float" ],
					"sig" : 0.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.25",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 285.0, 75.0, 49.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-6",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "record~ samps 1",
					"fontname" : "Arial",
					"numinlets" : 3,
					"patching_rect" : [ 285.0, 120.0, 100.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-5",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "normalize",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 15.0, 60.0, 63.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-4",
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "bed samps",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 15.0, 90.0, 69.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-2",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ samps 2000",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 135.0, 90.0, 117.0, 20.0 ],
					"numoutlets" : 2,
					"id" : "obj-1",
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [ 369.5, 107.0, 294.5, 107.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
