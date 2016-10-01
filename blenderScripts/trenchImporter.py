# This stub runs a python script relative to the currently open
# blend file, useful when editing scripts externally.

import bpy
import os

print("Importing Trench XML")

from xml.etree import cElementTree as ElementTree

xmlPath = 'L:\Projekt - Bibliothek\Processing Sketches\trench_generator\data\trench.xml'

xmlPath = 'L:/Projekt - Bibliothek/Processing Sketches/trench_generator/data/trench.xml'


xmlRoot = ElementTree.parse(xmlPath).getroot()


    
for outline in xmlRoot.iter('outline'):  
    
    i = 0
    
    name = outline.find("name").text
    
    # Create mesh and object
    me = bpy.data.meshes.new(name+'Mesh')
    ob = bpy.data.objects.new(name, me)
    ob.location = location=(0,0,0)
    #ob.show_name = True
     
    # Link object to scene and make active
    scn = bpy.context.scene
    scn.objects.link(ob)
    scn.objects.active = ob
    ob.select = True 
    
    verticies = []
    faces = []
    faces.append([])
      
    for positionVector in outline.iter('positionVector'):
        
        xPos = float(positionVector[0].text) * 0.01
        yPos = float(positionVector[1].text) * 0.01
        zPos = float(positionVector[2].text) * 0.01
        
        verticies.append([xPos,yPos,zPos])
        faces[0].append(i)
        
        #bpy.ops.mesh.primitive_cube_add(location=(xPos,yPos,zPos))
        
        #selectedObject = bpy.context.selected_objects
        #selectedObject[0].name = 'pixelcube.%s' % i
        #selectedObject[0].scale = 0.05, 0.05, 0.05    
        
       
        
        i = i + 1        
  
    
    me.from_pydata(verticies,[],faces)
    
    #me.verts.extend(verticies) 
    #me.faces.extend(faces)     
    
    #for outline in child.iter('outline'):
    #    for positionVector in outline:
    #        print(positionVector)