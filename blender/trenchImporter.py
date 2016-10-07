# TRENCH XML IMPORTER
# 0.2
# 
# CREATES A WORLD WAR ONE TRENCH MADE WITH THE TRENCH GENERATOR 
# 
# https://github.com/dasparadoxon/trench-generator
#
# PUBLIC DOMAIN 

import bpy
import os

import math
import mathutils
import random

objects = bpy.data.objects
materials = bpy.data.materials

frontFloor = None

#def palettes():

def duplicateObject(scene, name, copyobj):

    # Create new mesh
    mesh = bpy.data.meshes.new(name)

    # Create new object associated with the mesh
    ob_new = bpy.data.objects.new(name, mesh)

    # Copy data block from the old object into the new object
    ob_new.data = copyobj.data.copy()
    ob_new.scale = copyobj.scale
    ob_new.location = copyobj.location

    # Link new object to the given scene and select it
    scene.objects.link(ob_new)
    ob_new.select = True

    return ob_new

def putPalettesOnFloor():
    
    frontFloorPointIndex = 0 
    
    for frontFloorPoint in frontFloor.iter('positionVector'):
        
        print(frontFloorPoint)
        
        xCenterPosition = float(frontFloorPoint[0].text) * 0.01
        yCenterPosition = float(frontFloorPoint[1].text) * 0.01
        zCcenterPosition = float(frontFloorPoint[2].text) * 0.01          
 
        scn = bpy.context.scene
        
        newFloorPalette = duplicateObject(scn,"FLOORPALETTE_"+str(frontFloorPointIndex),bpy.data.objects['PALETTE'])
        
        newFloorPalette.location = (xCenterPosition,yCenterPosition,zCcenterPosition)        
        
        frontFloorPointIndex += 1
        
        if(len(frontFloor)/2 < frontFloorPointIndex):
           break

def createWoodWalls():
    
    woodWallElementIndex = 0
    
    woodWallElements = xmlRoot.find('woodWallElements');
    
    for woodWallElement in woodWallElements:
        
        centerPos = woodWallElement.find('positionVector')
 
        xCenterPosition = float(centerPos[0].text) * 0.01
        yCenterPosition = float(centerPos[1].text) * 0.01
        zCcenterPosition = float(centerPos[2].text) * 0.01    
        
        roationXMLElement = woodWallElement.find('rotation')
        rotation = float(roationXMLElement.text)   
        
        lengthXMLElement = woodWallElement.find('lengthOfElement')
        lengthOfElement = float(lengthXMLElement.text)*0.01325
        
        randomWoodWallType = random.randint(1,2)

        
        scn = bpy.context.scene
        
        randomWoodWallElement = random.randint(1,3)
        
        newWoodWallElement = duplicateObject(scn,"WOODWALLELEMENT"+str(woodWallElementIndex),bpy.data.objects['WOODWALLELEMENT'+str(randomWoodWallElement)])
        
        newWoodWallElement.location = (xCenterPosition,yCenterPosition,zCcenterPosition)
        
        newWoodWallElement.rotation_euler = (0,0,rotation)
        
        newWoodWallElement.scale = (1.3,lengthOfElement,1.5)
     
        woodWallElementIndex = woodWallElementIndex + 1     
        
        # second additional woodWallElement, not from XML
        
        newWoodWallElement = duplicateObject(scn,"WOODWALLELEMENT"+str(woodWallElementIndex),bpy.data.objects['WOODWALLELEMENT'+str(randomWoodWallElement)])
        
        newWoodWallElement.location = (xCenterPosition,yCenterPosition,zCcenterPosition - 0.07)
        
        newWoodWallElement.rotation_euler = (0,0,rotation)
        
        newWoodWallElement.scale = (1.3,lengthOfElement,1.5)
     
        woodWallElementIndex = woodWallElementIndex + 1              
               

def createSandbags():
    
    sandbagIndex = 0
        
    sandbags = xmlRoot.find('sandbags');    
    
    for sandbag in sandbags:
        
        # Getting parameters
            
        xCenterPosition = float(sandbag[0].text) * 0.01
        yCenterPosition = float(sandbag[1].text) * 0.01
        zCcenterPosition = float(sandbag[2].text) * 0.01    
        
        rotation = float(sandbag[3].text)
        
        material = sandbag[4].text
        
        scn = bpy.context.scene
        
        randomSackType = random.randint(1,3)
        
        newSandbag = duplicateObject(scn,"SANDBAGCLONE_"+str(sandbagIndex),bpy.data.objects['SANDBAG'+str(randomSackType)])
        
        newSandbag.location = (xCenterPosition,yCenterPosition,zCcenterPosition)
        
        newSandbag.scale = (0.125,0.191,0.174)
        
        newSandbag.rotation_euler = (0,0,rotation)
     
        sandbagIndex = sandbagIndex + 1


print("Importing Trench XML")

from xml.etree import cElementTree as ElementTree

xmlPath = 'L:/Projekt - Bibliothek/Processing Sketches/trench_generator/data/trench.xml'

xmlRoot = ElementTree.parse(xmlPath).getroot()

outsideGroundMat = bpy.data.materials.get("outsideGround")
trenchWallMat = bpy.data.materials.get("trenchWallMaterial")

    
for outline in xmlRoot.iter('outline'):  
    
    if(outline.get("type") == "floor"):
        frontFloor = outline
    
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

createWoodWalls()

#putPalettesOnFloor()

def cloneTrysForArchive():
    
    #for item in bpy.context.selectable_objects:  
        #   item.select = False        
        
        #bpy.ops.object.select_all(action="DESELECT")
        
        #bpy.context.scene.objects.active = bpy.data.objects['ORIGINAL']

        #duplicate = bpy.ops.object.duplicate()
        
        #duplicate.data.name = "ORIGINAL"+str(sandbagIndex)

        #bpy.ops.transform.resize(value=(2,2,2))
        
        

        #bpy.context.scene.objects.active = bpy.data.objects['Sphere.017']
        
        # clone and setsetting acc
        
        #ob = bpy.data.objects['SANDBAG1']
        
        #bpy.ops.object.duplicate()
        
        #scn = bpy.context.scene
        
        #scn.objects.link(ob)
        #scn.objects.active = ob
        #ob.select = True    
        
        #bpy.ops.object.duplicate()     
            
        
        #bpy.ops.mesh.primitive_cube_add(location=(xCenterPosition,yCenterPosition,zCcenterPosition))
        
        #ob = bpy.context.object 
        
        #ob.name= "Sandbag "  +str(sandbagIndex)  
        
        #ob.data.materials.append(bpy.data.materials.get(material))         
        
        #bpy.ops.transform.resize( value=(0.072,0.11,0.1) )
        
        #bpy.ops.transform.rotate(value = rotation, axis=(False, False, True))
        
        print("Jo")