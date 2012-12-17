import os

datadir = '/home/ray/proj/geodata'
themedir= './themes/sketchy'
cachedir= os.path.join(themedir, 'cache')

tag='Sketch_Background'

background = dict(\
    prototype='datasource.mapnik',
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'Background'),
               data_format='png',
               ),                  
    theme=os.path.join(themedir, 'Background.xml'),
    image_type='png',
    buffer_size=0,
    scale_factor=1,
    )



ROOT = dict(\
    prototype='root',
    renderer='background',
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

