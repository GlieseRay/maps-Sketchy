import os

themedir= './themes/Sketchy'
cachedir= os.path.join(themedir, 'cache')

tag='Sketchy'

background = dict(\
    prototype='datasource.storage',
    storage_type='metacache',
    root=os.path.join(cachedir, 'Background'),
    data_format='png',
    )

impression = dict(\
    prototype='datasource.storage',
    storage_type='metacache',
    root=os.path.join(cachedir, 'Impression'),
    data_format='png',
    )
  
sketch = dict(\
    prototype='datasource.storage',
    storage_type='metacache',
    root=os.path.join(cachedir, 'Sketch'),
    data_format='png',
    )

label = dict(\
    prototype='datasource.storage',
    storage_type='metacache',
    root=os.path.join(cachedir, 'Label'),
    data_format='png',
    )

label_halo = dict(\
    prototype='datasource.storage',
    storage_type='metacache',
    root=os.path.join(cachedir, 'LabelHalo'),
    data_format='png',
    )

composer = dict(\
     prototype='composite.imagemagick',
      cache=dict(prototype='metacache',
                root=os.path.join(cachedir, '%s' % tag),
                data_format='jpg',
                ),                  
     sources=['background', 'impression', 'sketch', 'label_halo', 'label'],
     command=''' 
      ( $1 )
      $2 -compose Multiply -composite
      ( $3 $4 -compose DstOut -composite ) -compose Multiply -composite
      ( $4 -channel RGBA -blur 0.7 +channel ) -compose Multiply -composite
      $5 -compose Multiply -composite      
#      ( $5 -channel A -morphology HMT LineJunctions +channel ) -compose Multiply -composite      
#      -unsharp 0x0.3
      -attenuate 0.8 +noise Gaussian
#      -brightness-contras t -5%x+2%
      -gamma 1.4
      -modulate 100,50,98
      -quality 90
     ''',
     format='jpg',
     )

ROOT = dict(\
    prototype='root',
    renderer='composer',
    metadata=dict(
        tag='sketchy',
        description='A Sketchy Map',
        attribution=''),
    pyramid=dict(
        levels=range(3, 9),
        format='png',
        buffer=16,
        tile_size=256,
        zoom=5,
        center=(35,0),
        ),
     cache=dict(prototype='filesystem',
                root=os.path.join(cachedir, 'export', '%s' % tag),
                data_format='jpg',
                simple=True
               ),    
)

