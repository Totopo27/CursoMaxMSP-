{
	"patcher" : 	{
		"rect" : [ 512., 167., 640., 506. ],
		"bgcolor" : [ 1., 1., 1., 1. ],
		"bglocked" : 0,
		"defrect" : [ 512., 167., 640., 506. ],
		"openinpresentation" : 0,
		"default_fontsize" : 10.,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15., 15. ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxfadetime" : 200,
		"boxanimatetime" : 200,
		"scrollanimatetime" : 200,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "delay varies from 0.1 to 9.9 milliseconds",
					"linecount" : 2,
					"presentation_rect" : [ 287., 281., 0., 0. ],
					"patching_rect" : [ 239., 226., 140., 33. ],
					"fontname" : "Arial",
					"id" : "obj-12",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "flange speed",
					"presentation_rect" : [ 362., 48., 0., 0. ],
					"patching_rect" : [ 289., 95., 83., 20. ],
					"fontname" : "Arial",
					"id" : "obj-11",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "feedback gain",
					"presentation_rect" : [ 316., 39., 0., 0. ],
					"patching_rect" : [ 229., 40., 83., 20. ],
					"fontname" : "Arial",
					"id" : "obj-7",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "cheap sawtooth wave",
					"patching_rect" : [ 55., 60., 150., 20. ],
					"fontname" : "Arial",
					"id" : "obj-2",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "+~ 5.",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 289.75882, 192.851212, 37., 20. ],
					"fontname" : "Arial",
					"id" : "obj-16",
					"numinlets" : 2,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~ 4.9",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 289.75882, 168.809143, 41., 20. ],
					"fontname" : "Arial",
					"id" : "obj-15",
					"numinlets" : 2,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~ 0.18",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 289.75882, 145.518387, 70., 20. ],
					"fontname" : "Arial",
					"id" : "obj-14",
					"numinlets" : 2,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"presentation_rect" : [ 289.75882, 117.956421, 0., 0. ],
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 289.75882, 117.956421, 50., 20. ],
					"fontname" : "Arial",
					"id" : "obj-13",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"outlettype" : [ "float", "bang" ],
					"patching_rect" : [ 227.399689, 63.110443, 50., 20. ],
					"fontname" : "Arial",
					"id" : "obj-10",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "*~",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 215.348602, 102.455284, 30.470589, 20. ],
					"fontname" : "Arial",
					"id" : "obj-9",
					"numinlets" : 2,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tapout~ 10",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 152.238159, 172.819672, 66., 20. ],
					"fontname" : "Arial",
					"id" : "obj-8",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "tapin~ 10",
					"outlettype" : [ "tapconnect" ],
					"patching_rect" : [ 152.238159, 141.26445, 59., 20. ],
					"fontname" : "Arial",
					"id" : "obj-6",
					"numinlets" : 1,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "-~ 0.5",
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 54.064617, 112.413223, 40., 20. ],
					"fontname" : "Arial",
					"id" : "obj-5",
					"numinlets" : 2,
					"fontsize" : 10.,
					"numoutlets" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "phasor~ 301",
					"outlettype" : [ "signal", "" ],
					"patching_rect" : [ 54.064617, 85.413223, 75., 20. ],
					"fontname" : "Arial",
					"id" : "obj-4",
					"numinlets" : 2,
					"fontsize" : 10.,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"outlettype" : [ "signal", "int" ],
					"patching_rect" : [ 153.486847, 220.175064, 18., 70. ],
					"id" : "obj-3",
					"numinlets" : 2,
					"numoutlets" : 2
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"patching_rect" : [ 152.486847, 306.175049, 45., 45. ],
					"id" : "obj-1",
					"numinlets" : 2,
					"numoutlets" : 0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-1", 1 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [ 63.564617, 140., 140., 140., 140., 130., 161.738159, 130. ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [ 63.564617, 210.931625, 161.486847, 210.931625 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [ 161.738159, 199.849731, 265.965424, 199.849731, 265.965424, 94.665657, 224.848602, 94.665657 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [ 224.848602, 130., 161.738159, 130. ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-9", 1 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-16", 0 ],
					"hidden" : 0
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [ 299.25882, 219.383911, 284.748291, 219.383911, 284.748291, 166.79187, 161.738159, 166.79187 ]
				}

			}
 ]
	}

}
