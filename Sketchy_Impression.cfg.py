import os

datadir = '/home/ray/proj/geodata'
themedir= './themes/sketchy'
cachedir= os.path.join(themedir, 'cache')

tag='Sketchy_Impression'

impression = dict(\
    prototype='datasource.mapnik',
    cache=dict(prototype='metacache',
               root=os.path.join(cachedir, 'Impression'),
               data_format='png',
               ),                  
    theme=os.path.join(themedir, 'Impression.xml'),
    image_type='png',
    buffer_size=128,
    scale_factor=1,
    )



ROOT = dict(\
    prototype='root',
    renderer='impression',
    metadata=dict(
        tag='sketchy',
        description='sketchy',
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

