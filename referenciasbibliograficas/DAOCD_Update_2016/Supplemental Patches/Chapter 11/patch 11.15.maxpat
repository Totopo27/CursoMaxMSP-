{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 543.0, 328.0, 640.0, 480.0 ],
		"bglocked" : 0,
		"defrect" : [ 543.0, 328.0, 640.0, 480.0 ],
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
					"text" : "trigger ramp and record it",
					"numinlets" : 1,
					"patching_rect" : [ 45.0, 90.0, 150.0, 20.0 ],
					"id" : "obj-16",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "adstatus sr",
					"numinlets" : 2,
					"patching_rect" : [ 225.0, 105.0, 69.0, 20.0 ],
					"id" : "obj-14",
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "", "int" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"patching_rect" : [ 225.0, 135.0, 66.0, 20.0 ],
					"id" : "obj-13",
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "1",
					"numinlets" : 2,
					"patching_rect" : [ 105.0, 150.0, 32.5, 18.0 ],
					"id" : "obj-11",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "record~ recordme",
					"numinlets" : 3,
					"patching_rect" : [ 135.0, 240.0, 106.0, 20.0 ],
					"id" : "obj-9",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"patching_rect" : [ 75.0, 300.0, 45.0, 45.0 ],
					"id" : "obj-8",
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"patching_rect" : [ 150.0, 120.0, 20.0, 20.0 ],
					"id" : "obj-7",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sig~ 44100",
					"numinlets" : 1,
					"patching_rect" : [ 225.0, 165.0, 70.0, 20.0 ],
					"id" : "obj-5",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "waveform~",
					"numinlets" : 5,
					"patching_rect" : [ 255.0, 210.0, 335.0, 220.0 ],
					"id" : "obj-4",
					"textcolor" : [  ],
					"numoutlets" : 6,
					"outlettype" : [ "float", "float", "float", "float", "list", "" ],
					"buffername" : "recordme"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "click~",
					"numinlets" : 1,
					"patching_rect" : [ 150.0, 165.0, 41.0, 20.0 ],
					"id" : "obj-3",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "ramp~",
					"numinlets" : 2,
					"patching_rect" : [ 150.0, 195.0, 45.0, 20.0 ],
					"id" : "obj-2",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "buffer~ recordme 1000",
					"numinlets" : 1,
					"patching_rect" : [ 225.0, 75.0, 132.0, 20.0 ],
					"id" : "obj-1",
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 12.0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-14", 1 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [ 284.5, 129.5, 234.5, 129.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 114.5, 203.5, 144.5, 203.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 144.5, 114.5, 144.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 227.0, 144.5, 227.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-2", 1 ],
					"hidden" : 0,
					"midpoints" : [ 234.5, 189.5, 185.5, 189.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
