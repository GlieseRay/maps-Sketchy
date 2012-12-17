import os

datadir = '/Users/Kotaimen/proj/geodata'
themedir= './themes/Sketchy'
cachedir= os.path.join(themedir, 'cache')

tag='Sketch_Labels'

label = dict(\
    prototype='datasource.mapnik',
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'Label'),
               data_format='png',
               ),                  
    theme=os.path.join(themedir, 'Label.xml'),
    image_type='png',
    buffer_size=384,
    scale_factor=1,
    )

label_halo = dict(\
    prototype='datasource.mapnik',
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'LabelHalo'),
               data_format='png',
               ),                  
    theme=os.path.join(themedir, 'Label_Halo.xml'),
    image_type='png',
    buffer_size=384,
    scale_factor=1,
    )

composer = dict(\
     prototype='composite.imagemagick',
#      cache=dict(prototype='metacache',
#                root=os.path.join(cachedir, '%s' % tag),
#                data_format='png',
#                ),                  
     sources=['label', 'label_halo'],
     command=''' 
      $1
      $2        
      -compose Over -composite
     ''',
     format='png',
     )

ROOT = dict(\
    prototype='root',
    renderer='composer',
    metadata=dict(
        tag='sketchy',
        description='Sketchy',
        attribution=''),
    pyramid=dict(
        levels=range(3, 9),
        format='png',
        buffer=16,
        tile_size=256,
        zoom=5,
        center=(35,0),
        ),
#     cache=dict(prototype='filesystem',
#                root=os.path.join(cachedir, 'export', '%s' % tag),
#                data_format='jpg',
#                simple=True
#               ),    
)

