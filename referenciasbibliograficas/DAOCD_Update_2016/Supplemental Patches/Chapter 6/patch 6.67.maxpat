{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ -7.0, 44.0, 1287.0, 730.0 ],
		"bglocked" : 0,
		"defrect" : [ -7.0, 44.0, 1287.0, 730.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
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
					"text" : "display line envelope data",
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-34",
					"patching_rect" : [ 225.0, 300.0, 149.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "gain",
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-32",
					"patching_rect" : [ 125.0, 295.0, 33.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 12.0,
					"id" : "obj-30",
					"patching_rect" : [ 125.0, 315.0, 50.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 0.1",
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0,
					"id" : "obj-27",
					"patching_rect" : [ 70.0, 280.0, 42.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0. 0. 1. 250. 0.4 150. 0.4 100. 0. 200.",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-28",
					"patching_rect" : [ 225.0, 320.0, 314.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"triscale" : 0.9,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-1",
					"patching_rect" : [ 90.0, 90.0, 40.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "sustain_amplitude $1",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-2",
					"patching_rect" : [ 90.0, 120.0, 137.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"outlettype" : [ "int" ],
					"id" : "obj-3",
					"patching_rect" : [ 120.0, 30.0, 20.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "elastic_sustain $1",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-4",
					"patching_rect" : [ 120.0, 60.0, 120.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"triscale" : 0.9,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-5",
					"patching_rect" : [ 465.0, 90.0, 42.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"triscale" : 0.9,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-6",
					"patching_rect" : [ 420.0, 90.0, 42.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"triscale" : 0.9,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-7",
					"patching_rect" : [ 375.0, 90.0, 40.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"triscale" : 0.9,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-8",
					"patching_rect" : [ 330.0, 90.0, 40.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "adsr 14. 30. 110. 319.",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-9",
					"patching_rect" : [ 330.0, 210.0, 127.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b b",
					"fontname" : "Arial",
					"outlettype" : [ "bang", "bang" ],
					"fontsize" : 12.0,
					"id" : "obj-10",
					"patching_rect" : [ 296.0, 126.0, 36.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set adsr",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-11",
					"patching_rect" : [ 330.0, 180.0, 110.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pack f f f f",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-12",
					"patching_rect" : [ 330.0, 150.0, 154.0, 20.0 ],
					"numinlets" : 4,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "152 205 338 346 229 156 296 255 238 301 73 170 238 222 471 205",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-13",
					"patching_rect" : [ 146.0, 266.0, 374.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "adsr 5 50 100 100",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-14",
					"patching_rect" : [ 270.0, 60.0, 124.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"offgradcolor1" : [ 1.0, 0.0, 0.0, 1.0 ],
					"ongradcolor1" : [ 0.054902, 0.909804, 0.223529, 1.0 ],
					"id" : "obj-15",
					"patching_rect" : [ 70.0, 315.0, 29.0921, 29.0921 ],
					"numinlets" : 2,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~",
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0,
					"id" : "obj-16",
					"patching_rect" : [ 70.0, 250.0, 32.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"fontname" : "Arial",
					"outlettype" : [ "float", "bang" ],
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"triscale" : 0.9,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 12.0,
					"id" : "obj-17",
					"patching_rect" : [ 45.0, 15.0, 40.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "tempo $1",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-18",
					"patching_rect" : [ 45.0, 45.0, 66.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "adsr 250 150 100 200",
					"fontname" : "Arial",
					"outlettype" : [ "" ],
					"fontsize" : 12.0,
					"id" : "obj-19",
					"patching_rect" : [ 255.0, 30.0, 148.0, 18.0 ],
					"numinlets" : 2,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "line~",
					"fontname" : "Arial",
					"outlettype" : [ "signal", "bang" ],
					"fontsize" : 12.0,
					"id" : "obj-20",
					"patching_rect" : [ 270.0, 210.0, 38.0, 20.0 ],
					"numinlets" : 2,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "oscil~ 440 16384 square 12",
					"fontname" : "Arial",
					"outlettype" : [ "signal" ],
					"fontsize" : 12.0,
					"id" : "obj-21",
					"patching_rect" : [ 70.0, 200.0, 181.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "retroseq~",
					"fontname" : "Arial",
					"outlettype" : [ "signal", "list" ],
					"fontsize" : 12.0,
					"id" : "obj-22",
					"patching_rect" : [ 70.0, 170.0, 69.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "soft envelope",
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-23",
					"patching_rect" : [ 405.0, 30.0, 90.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "hard envelope",
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-24",
					"patching_rect" : [ 405.0, 60.0, 92.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "or roll your own",
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-25",
					"patching_rect" : [ 510.0, 90.0, 93.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "frequency/duration list",
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-26",
					"patching_rect" : [ 147.0, 249.0, 150.0, 20.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [ 79.5, 309.5, 79.5, 309.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-15", 1 ],
					"hidden" : 0,
					"midpoints" : [ 79.5, 308.394714, 89.592102, 308.394714 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 155.5, 293.013275, 187.815857, 293.013275, 187.815857, 354.079071, 62.092129, 354.079071, 62.092129, 165.750061, 79.5, 165.750061 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 99.5, 154.0, 79.5, 154.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 129.5, 81.0, 79.5, 81.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 84.0, 79.5, 84.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-18", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 54.5, 80.0, 79.5, 80.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 264.5, 84.0, 79.5, 84.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-20", 0 ],
					"destination" : [ "obj-16", 1 ],
					"hidden" : 0,
					"midpoints" : [ 279.5, 234.842102, 92.5, 234.842102 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-4", 0 ],
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
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [ 474.5, 120.0, 305.5, 120.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [ 384.5, 120.0, 305.5, 120.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [ 339.5, 120.0, 305.5, 120.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [ 429.5, 120.0, 305.5, 120.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 1 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 322.5, 148.0, 339.5, 148.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
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
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-12", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-12", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-12", 3 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 1 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [ 129.5, 198.815781, 279.5, 198.815781 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-27", 1 ],
					"hidden" : 0,
					"midpoints" : [ 134.5, 343.421051, 115.092102, 343.421051, 115.092102, 276.5, 102.5, 276.5 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 339.5, 234.0, 311.0, 234.0, 311.0, 164.276306, 79.5, 164.276306 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 305.5, 160.0, 318.0, 160.0, 318.0, 201.0, 339.5, 201.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 1 ],
					"destination" : [ "obj-28", 1 ],
					"hidden" : 0,
					"midpoints" : [ 129.5, 196.302628, 308.0, 196.302628, 308.0, 242.0, 529.5, 242.0 ]
				}

			}
 ]
	}

}
