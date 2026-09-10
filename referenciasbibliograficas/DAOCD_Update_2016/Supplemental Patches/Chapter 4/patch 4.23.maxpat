{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 97.0, 72.0, 490.0, 258.0 ],
		"bglocked" : 0,
		"defrect" : [ 97.0, 72.0, 490.0, 258.0 ],
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
					"text" : "feedback amount",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 330.0, 75.0, 103.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-17",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "flange speed",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 255.0, 30.0, 79.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-16",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "saw frequency",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 90.0, 45.0, 88.0, 20.0 ],
					"numoutlets" : 0,
					"id" : "obj-15",
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 30.0, 45.0, 50.0, 20.0 ],
					"numoutlets" : 2,
					"id" : "obj-13",
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 195.0, 30.0, 50.0, 20.0 ],
					"numoutlets" : 2,
					"id" : "obj-11",
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"patching_rect" : [ 30.0, 195.0, 45.0, 45.0 ],
					"numoutlets" : 0,
					"id" : "obj-10"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"numinlets" : 2,
					"patching_rect" : [ 30.0, 120.0, 34.0, 55.0 ],
					"numoutlets" : 2,
					"id" : "obj-9",
					"outlettype" : [ "signal", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "saw~ 301",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 30.0, 75.0, 62.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-8",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "vdelay~ 13 1. 0.3",
					"fontname" : "Arial",
					"numinlets" : 3,
					"patching_rect" : [ 150.0, 165.0, 102.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-7",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 270.0, 75.0, 50.0, 20.0 ],
					"numoutlets" : 2,
					"minimum" : -0.99,
					"id" : "obj-6",
					"fontsize" : 12.0,
					"maximum" : 0.99,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sig~ 0.3",
					"fontname" : "Arial",
					"numinlets" : 1,
					"patching_rect" : [ 270.0, 105.0, 53.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-4",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+~ 6",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 195.0, 120.0, 35.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-3",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 5.95",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 195.0, 90.0, 49.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-2",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 0.01",
					"fontname" : "Arial",
					"numinlets" : 2,
					"patching_rect" : [ 195.0, 60.0, 72.0, 20.0 ],
					"numoutlets" : 1,
					"id" : "obj-1",
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 114.5, 39.5, 114.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-10", 1 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 184.5, 65.5, 184.5 ]
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
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-7", 1 ],
					"hidden" : 0,
					"midpoints" : [ 204.5, 152.0, 201.0, 152.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 194.0, 93.0, 194.0, 93.0, 111.0, 39.5, 111.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 102.5, 159.5, 102.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-7", 2 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 144.5, 242.5, 144.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
