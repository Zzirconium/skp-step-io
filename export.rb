mod = Sketchup.active_model # Open model
ent = mod.entities # All entities in model
sel = mod.selection # Current selection
#UI.messagebox( 'In Martins Sketch Talk' )

filename = 'c:\\Users\\Christophe\\Documents\\export.stp'
f = File.open(filename, 'w')

f.puts "ISO-10303-21;" 
f.puts "HEADER;"
f.puts "FILE_DESCRIPTION(('Sketchup Quick STEP Exchange'),'2;1');"
f.puts "FILE_NAME('C:\\\\Users\\\\Administrator\\\\Desktop\\\\twobodies2.stp','2016-11-30T22:06:22+00:00',('none'),('none'),'Sketchup 2014','STEP AP203','none');"
f.puts "FILE_SCHEMA(('CONFIG_CONTROL_DESIGN'));"
f.puts "ENDSEC;"
f.puts "DATA;"
f.puts "#1=APPLICATION_CONTEXT('configuration controlled 3D design of mechanical parts and assemblies') ;"
f.puts "#2=MECHANICAL_CONTEXT(' ',#1,'mechanical') ;"
f.puts "#3=DESIGN_CONTEXT(' ',#1,'design') ;"
f.puts "#4=APPLICATION_PROTOCOL_DEFINITION('international standard','config_control_design',1994,#1) ;"
f.puts "#5=PRODUCT('Part5','Part5','',(#2)) ;"
f.puts "#6=PRODUCT_DEFINITION_FORMATION_WITH_SPECIFIED_SOURCE('',' ',#5,.NOT_KNOWN.) ;"
f.puts "#7=PRODUCT_CATEGORY('part',$) ;"
f.puts "#8=PRODUCT_RELATED_PRODUCT_CATEGORY('detail',$,(#5)) ;"
f.puts "#9=PRODUCT_CATEGORY_RELATIONSHIP(' ',' ',#7,#8) ;"
f.puts "#10=COORDINATED_UNIVERSAL_TIME_OFFSET(0,0,.AHEAD.) ;"
f.puts "#11=CALENDAR_DATE(2016,30,11) ;"
f.puts "#12=LOCAL_TIME(23,6,22.,#10) ;"
f.puts "#13=DATE_AND_TIME(#11,#12) ;"
f.puts "#14=PRODUCT_DEFINITION('',' ',#6,#3) ;"
f.puts "#15=SECURITY_CLASSIFICATION_LEVEL('unclassified') ;"
f.puts "#16=SECURITY_CLASSIFICATION(' ',' ',#15) ;"
f.puts "#17=DATE_TIME_ROLE('classification_date') ;"
f.puts "#18=CC_DESIGN_DATE_AND_TIME_ASSIGNMENT(#13,#17,(#16)) ;"
f.puts "#19=APPROVAL_ROLE('APPROVER') ;"
f.puts "#20=APPROVAL_STATUS('not_yet_approved') ;"
f.puts "#21=APPROVAL(#20,' ') ;"
f.puts "#22=PERSON(' ',' ',' ',$,$,$) ;"
f.puts "#23=ORGANIZATION(' ',' ',' ') ;"
f.puts "#24=PERSONAL_ADDRESS(' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',(#22),' ') ;"
f.puts "#25=PERSON_AND_ORGANIZATION(#22,#23) ;"
f.puts "#26=PERSON_AND_ORGANIZATION_ROLE('classification_officer') ;"
f.puts "#27=CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT(#25,#26,(#16)) ;"
f.puts "#28=DATE_TIME_ROLE('creation_date') ;"
f.puts "#29=CC_DESIGN_DATE_AND_TIME_ASSIGNMENT(#13,#28,(#14)) ;"
f.puts "#30=CC_DESIGN_APPROVAL(#21,(#16,#6,#14)) ;"
f.puts "#31=APPROVAL_PERSON_ORGANIZATION(#25,#21,#19) ;"
f.puts "#32=APPROVAL_DATE_TIME(#13,#21) ;"
f.puts "#33=CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT(#25,#34,(#6)) ;"
f.puts "#34=PERSON_AND_ORGANIZATION_ROLE('design_supplier') ;"
f.puts "#35=CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT(#25,#36,(#6,#14)) ;"
f.puts "#36=PERSON_AND_ORGANIZATION_ROLE('creator') ;"
f.puts "#37=CC_DESIGN_PERSON_AND_ORGANIZATION_ASSIGNMENT(#25,#38,(#5)) ;"
f.puts "#38=PERSON_AND_ORGANIZATION_ROLE('design_owner') ;"
f.puts "#39=CC_DESIGN_SECURITY_CLASSIFICATION(#16,(#6)) ;"
f.puts "#40=PRODUCT_DEFINITION_SHAPE(' ',' ',#14) ;"
f.puts "#41=(LENGTH_UNIT()NAMED_UNIT(*)SI_UNIT(.MILLI.,.METRE.)) ;"
f.puts "#42=(NAMED_UNIT(*)PLANE_ANGLE_UNIT()SI_UNIT($,.RADIAN.)) ;"
f.puts "#43=(NAMED_UNIT(*)SI_UNIT($,.STERADIAN.)SOLID_ANGLE_UNIT()) ;"
f.puts "#44=UNCERTAINTY_MEASURE_WITH_UNIT(LENGTH_MEASURE(0.005),#41,'distance_accuracy_value','CONFUSED CURVE UNCERTAINTY') ;"
f.puts "#45=(GEOMETRIC_REPRESENTATION_CONTEXT(3)GLOBAL_UNCERTAINTY_ASSIGNED_CONTEXT((#44))GLOBAL_UNIT_ASSIGNED_CONTEXT((#41,#42,#43))REPRESENTATION_CONTEXT(' ',' ')) ;"
f.puts "#46=CARTESIAN_POINT(' ',(0.,0.,0.)) ;"
f.puts "#47=AXIS2_PLACEMENT_3D(' ',#46,$,$) ;"
f.puts "#48=SHAPE_REPRESENTATION(' ',(#47),#45) ;"
f.puts "#49=SHAPE_DEFINITION_REPRESENTATION(#40,#48) ;"

cpt=50

mod.selection().clear()
vertices = Hash.new
edges = Hash.new
solids = []
for e in mod.entities()
  if e.is_a?( Sketchup::ComponentInstance ) 
    tr  = e.transformation
    faces = e.definition.entities
    shell = []
    for face in faces
      if face.is_a?( Sketchup::Face )
        x = 0.0
        y = 0.0
        z = 0.0
        lx = 0.0
        ly = 0.0
        lz = 0.0
        loop=[]
        for edge in face.edges
          lx = x
          ly = y
          lz = z
          x = edge.end.position.x-edge.start.position.x
          y = edge.end.position.y-edge.start.position.y
          z = edge.end.position.z-edge.start.position.z
          puts z
          if (nil == edges[edge])
            sv = nil
            ev = nil
            if (nil == vertices[edge.start])
              cpt=cpt+1
              vertices[edge.start]=cpt;
              cpt=cpt+1
              #60=CARTESIAN_POINT('Vertex',(-40.,60.,0.)) ;
              f.puts("#"+(vertices[edge.start]-1).to_s+"=CARTESIAN_POINT('Vertex',("+("%f" % (edge.start.position.x*25.4))+","+("%f" % (edge.start.position.y*25.4))+","+("%f" % (edge.start.position.z*25.4))+")) ;")
              #61=VERTEX_POINT('',#60) ;
              f.puts("#"+vertices[edge.start].to_s+"=VERTEX_POINT('',#"+(vertices[edge.start]-1).to_s+") ;")
              #f.puts "add start vertice to hash"
            end
            if (nil == vertices[edge.end])
              cpt=cpt+1
              vertices[edge.end]=cpt;
              cpt=cpt+1
              #60=CARTESIAN_POINT('Vertex',(-40.,60.,0.)) ;
              f.puts("#"+(vertices[edge.end]-1).to_s+"=CARTESIAN_POINT('Vertex',("+("%f" % (edge.end.position.x*25.4))+","+("%f" % (edge.end.position.y*25.4))+","+("%f" % (edge.end.position.z*25.4))+")) ;")
              #61=VERTEX_POINT('',#60) ;
              f.puts("#"+vertices[edge.end].to_s+"=VERTEX_POINT('',#"+(vertices[edge.end]-1).to_s+") ;")
              #f.puts "add end vertice to hash"
            end

            #56=CARTESIAN_POINT('Line Origine',(-40.,60.,10.)) ;
            f.puts("#"+cpt.to_s+"=CARTESIAN_POINT('Line Origine',("+(25.4*(edge.start.position.x+edge.end.position.x)/2).to_s+","+(25.4*(edge.start.position.y+edge.end.position.y)/2).to_s+","+(25.4*(edge.start.position.z+edge.end.position.z)/2).to_s+")) ;")
            cpt = cpt+1
            #57=DIRECTION('Vector Direction',(0.,0.,1.)) ;
            f.puts("#"+cpt.to_s+"=DIRECTION('Vector Direction',("+(25.4*(edge.end.position.x-edge.start.position.x)).to_s+","+(25.4*(edge.end.position.y-edge.start.position.y)).to_s+","+(25.4*(edge.end.position.z-edge.start.position.z)).to_s+")) ;")
            cpt = cpt+1
            #58=VECTOR('Line Direction',#57,1.) ;
            f.puts("#"+cpt.to_s+"=VECTOR('Line Direction',#"+(cpt-1).to_s+",1.) ;")
            cpt = cpt+1
            #59=LINE('Line',#56,#58) ;
            f.puts("#"+cpt.to_s+"=LINE('Line',#"+(cpt-3).to_s+",#"+(cpt-1).to_s+") ;")
            cpt = cpt+1

            edges[edge] = cpt
            cpt=cpt+1
            #83=EDGE_CURVE('',#63,#77,#82,.T.) ;
            f.puts("#"+edges[edge].to_s+"=EDGE_CURVE('',#"+vertices[edge.start].to_s+",#"+vertices[edge.end].to_s+",#"+(edges[edge]-1).to_s+",.T.) ;")
          end
          #85=ORIENTED_EDGE('',*,*,#64,.F.) ;
          f.puts("#"+cpt.to_s+"=ORIENTED_EDGE('',*,*,#"+edges[edge].to_s+",.T.) ;")
          loop.push("#"+cpt.to_s)
          cpt = cpt+1          
        end
        #84=EDGE_LOOP('',(#85,#86,#87,#88)) ;
        f.puts("#"+cpt.to_s+"=EDGE_LOOP('',"+loop.to_s.gsub("\"","").gsub("[","(").gsub("]",")")+") ;")
        cpt=cpt+1
        #89=FACE_OUTER_BOUND('',#84,.T.) ;
        f.puts("#"+cpt.to_s+"=FACE_OUTER_BOUND('',#"+(cpt-1).to_s+") ;")
        face_id = cpt
        cpt = cpt+1
        
        #51=CARTESIAN_POINT('Axis2P3D Location',(-40.,60.,0.)) ;
        f.puts("#"+cpt.to_s+"=CARTESIAN_POINT('Axis2P3D Location',(0.,0.,0.)) ;")
        cpt = cpt+1
        
        #52=DIRECTION('Axis2P3D Direction',(-1.,0.,0.)) ;
        vx = y*lz-z*ly
        vy = z*lx-x*lz
        vz = x*ly-y*lx
        f.puts("#"+cpt.to_s+"=DIRECTION('Axis2P3D Direction',("+vx.to_s+","+vy.to_s+","+vz.to_s+")) ;")
        cpt = cpt+1
        
        #53=DIRECTION('Axis2P3D XDirection',(0.,-1.,0.)) ;
        f.puts("#"+cpt.to_s+"=DIRECTION('Axis2P3D XDirection',(0.,-1.,0.)) ;")
        cpt = cpt+1
        
        #54=AXIS2_PLACEMENT_3D('Plane Axis2P3D',#51,#52,#53) ;
        f.puts("#"+cpt.to_s+"=AXIS2_PLACEMENT_3D('Plane Axis2P3D',#"+(cpt-3).to_s+",#"+(cpt-2).to_s+",#"+(cpt-1).to_s+") ;")
        cpt = cpt+1
        
        #55=PLANE('',#54) ;
        f.puts("#"+cpt.to_s+"=PLANE('',#"+(cpt-1).to_s+") ;")
        cpt = cpt+1
        
        #90=ADVANCED_FACE('Corps principal',(#89),#55,.T.) ;
        f.puts("#"+cpt.to_s+"=ADVANCED_FACE('Corps principal',(#"+face_id.to_s+"),#"+(cpt-1).to_s+",.T.) ;")
        shell.push("#"+cpt.to_s)
        cpt = cpt+1
      end
    end
    #50=CLOSED_SHELL('Closed Shell',(#90,#121,#145,#169,#186,#198)) ;
    f.puts("#"+cpt.to_s+"=CLOSED_SHELL('Closed Shell',"+shell.to_s.gsub("\"","").gsub("[","(").gsub("]",")")+") ;")
    cpt=cpt+1
    
    #199=MANIFOLD_SOLID_BREP('Corps principal',#50) ;
    f.puts("#"+cpt.to_s+"=MANIFOLD_SOLID_BREP('Corps principal',#"+(cpt-1).to_s+") ;")
    solids.push("#"+cpt.to_s)
    cpt=cpt+1
    
  end
end

#200=ADVANCED_BREP_SHAPE_REPRESENTATION('NONE',(#199,#351),#45) ;
f.puts("#"+cpt.to_s+"=ADVANCED_BREP_SHAPE_REPRESENTATION('NONE',"+solids.to_s.gsub("\"","").gsub("[","(").gsub("]",")")+", #45) ;")
cpt=cpt+1

#201=SHAPE_REPRESENTATION_RELATIONSHIP(' ',' ',#48,#200) ;
f.puts("#"+cpt.to_s+"=SHAPE_REPRESENTATION_RELATIONSHIP(' ',' ',#48, #"+(cpt-1).to_s+") ;")
cpt=cpt+1

f.puts("ENDSEC;")
f.puts("END-ISO-10303-21;")

f.close
"ok"
