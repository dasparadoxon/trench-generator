# TRENCH XML IMPORTER
# 0.1
# 
# CREATES A WORLD WAR ONE TRENCH MADE WITH THE TRENCH GENERATOR 
# 
# https://github.com/dasparadoxon/trench-generator
#
# PUBLIC DOMAIN 

import bpy
import os

objects = bpy.data.objects
materials = bpy.data.materials

def createSandbags():
    
    sandbagIndex = 0
    
    
        
    sandbags = xmlRoot.find('sandbags');    
    
    for sandbag in sandbags:
            
        xCenterPosition = float(sandbag[0].text) * 0.01
        yCenterPosition = float(sandbag[1].text) * 0.01
        zCcenterPosition = float(sandbag[2].text) * 0.01    
        
        rotation = float(sandbag[3].text)
        
        material = sandbag[4].text

            
        bpy.ops.mesh.primitive_cube_add(location=(xCenterPosition,yCenterPosition,zCcenterPosition))
        
        ob = bpy.context.object 
        
        ob.name= "Sandbag "  +str(sandbagIndex)  
        
        ob.data.materials.append(bpy.data.materials.get(material))         
        
        bpy.ops.transform.resize( value=(0.08,0.15,0.1) )
        
        bpy.ops.transform.rotate(value = rotation, axis=(False, False, True))

        sandbagIndex = sandbagIndex + 1


print("Importing Trench XML")

from xml.etree import cElementTree as ElementTree

xmlPath = 'L:/Projekt - Bibliothek/Processing Sketches/trench_generator/data/trench.xml'

xmlRoot = ElementTree.parse(xmlPath).getroot()

outsideGroundMat = bpy.data.materials.get("outsideGround")
trenchWallMat = bpy.data.materials.get("trenchWallMaterial")

    
for outline in xmlRoot.iter('outline'):  
    
    i = 0
    
    name = outline.find("name").text
    
    material = outline.find("material").text
    
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
        
        i = i + 1        
    
    me.from_pydata(verticies,[],faces)
    
    me.materials.append(bpy.data.materials.get(material))

    
createSandbags()