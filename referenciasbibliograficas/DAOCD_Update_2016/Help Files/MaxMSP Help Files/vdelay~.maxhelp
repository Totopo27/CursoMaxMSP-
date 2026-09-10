{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 97.0, 72.0, 454.0, 388.0 ],
		"bglocked" : 0,
		"defrect" : [ 97.0, 72.0, 454.0, 388.0 ],
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
					"text" : "vdelay~ is an interpolating delayline with feedback, \nwhere the delay time can be as short as one sample",
					"linecount" : 2,
					"patching_rect" : [ 30.0, 345.0, 293.0, 34.0 ],
					"fontname" : "Arial",
					"id" : "obj-19",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadmess 301",
					"patching_rect" : [ 30.0, 30.0, 85.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-14",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "vdelay~",
					"frgb" : [ 0.317647, 0.043137, 0.223529, 1.0 ],
					"patching_rect" : [ 105.0, 225.0, 120.0, 35.0 ],
					"fontname" : "Cambria",
					"textcolor" : [ 0.317647, 0.043137, 0.223529, 1.0 ],
					"id" : "obj-12",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 24.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "published by A-R Editions, Inc.\nhttp://www.areditions.com/",
					"linecount" : 2,
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"patching_rect" : [ 105.0, 300.0, 196.0, 39.0 ],
					"fontname" : "Cambria",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"id" : "obj-5",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 14.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "from Designing Audio Objects\nby Eric Lyon",
					"linecount" : 2,
					"frgb" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"patching_rect" : [ 105.0, 255.0, 241.0, 49.0 ],
					"fontname" : "Cambria",
					"textcolor" : [ 0.082353, 0.25098, 0.431373, 1.0 ],
					"id" : "obj-23",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 18.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "panel",
					"patching_rect" : [ 90.0, 225.0, 273.0, 118.0 ],
					"border" : 3,
					"rounded" : 1,
					"bgcolor" : [ 1.0, 0.905882, 0.733333, 1.0 ],
					"id" : "obj-33",
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "feedback amount",
					"patching_rect" : [ 330.0, 60.0, 103.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-17",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "flange speed",
					"patching_rect" : [ 225.0, 15.0, 79.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-16",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "saw frequency",
					"patching_rect" : [ 90.0, 60.0, 88.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-15",
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 30.0, 60.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-13",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"patching_rect" : [ 225.0, 45.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-11",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"patching_rect" : [ 30.0, 285.0, 45.0, 45.0 ],
					"id" : "obj-10",
					"numinlets" : 2,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"patching_rect" : [ 30.0, 195.0, 34.0, 55.0 ],
					"id" : "obj-9",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "saw~",
					"patching_rect" : [ 30.0, 90.0, 39.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-8",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "vdelay~ 13 1. 0.3",
					"patching_rect" : [ 150.0, 180.0, 102.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-7",
					"numinlets" : 3,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"minimum" : -0.99,
					"maximum" : 0.99,
					"patching_rect" : [ 330.0, 90.0, 50.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-6",
					"numinlets" : 1,
					"numoutlets" : 2,
					"fontsize" : 12.0,
					"outlettype" : [ "float", "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "sig~ 0.3",
					"patching_rect" : [ 330.0, 120.0, 53.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-4",
					"numinlets" : 1,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+~ 6",
					"patching_rect" : [ 225.0, 135.0, 35.0, 20.0 ],
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
					"maxclass" : "newobj",
					"text" : "*~ 5.95",
					"patching_rect" : [ 225.0, 105.0, 49.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-2",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 0.01",
					"patching_rect" : [ 225.0, 75.0, 72.0, 20.0 ],
					"fontname" : "Arial",
					"id" : "obj-1",
					"numinlets" : 2,
					"numoutlets" : 1,
					"fontsize" : 12.0,
					"outlettype" : [ "signal" ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 143.5, 159.5, 143.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 129.5, 39.5, 129.5 ]
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
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-13", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-10", 1 ],
					"hidden" : 0,
					"midpoints" : [ 39.5, 258.5, 65.5, 258.5 ]
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
					"midpoints" : [ 234.5, 162.0, 201.0, 162.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 159.5, 209.0, 93.0, 209.0, 93.0, 178.0, 39.5, 178.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-7", 2 ],
					"hidden" : 0,
					"midpoints" : [ 339.5, 172.5, 242.5, 172.5 ]
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
