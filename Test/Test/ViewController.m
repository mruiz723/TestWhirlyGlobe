//
//  ViewController.m
//  Test
//
//  Created by mruiz723 on 4/23/16.
//  Copyright © 2016 nextU. All rights reserved.
//

#import "ViewController.h"
#import "MaplyMBTileSource.h"

@interface ViewController ()

@end

@implementation ViewController{
    WhirlyGlobeViewController *globeViewC;
    MaplyBaseViewController *theViewC;
    MaplyViewController *mapViewC;
}

// Set this to false for a map
const bool DoGlobe = true;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

//    if ([theViewC isKindOfClass:[WhirlyGlobeViewController class]])
//        globeViewC = (WhirlyGlobeViewController *)theViewC;
//    else
//        mapViewC = (MaplyViewController *)theViewC;
    
    
    if(DoGlobe){
        globeViewC = [[WhirlyGlobeViewController alloc]init];
        theViewC = globeViewC;
    }else{
        mapViewC = [[MaplyViewController alloc]init];
        theViewC = mapViewC;
    }

    // Create an empty globe and add it to the view
//    theViewC = [[WhirlyGlobeViewController alloc] init];
    [self.view addSubview:theViewC.view];
    theViewC.view.frame = self.view.bounds;
    [self addChildViewController:theViewC];

    
    // add the capability to use the local tiles or remote tiles
    bool useLocalTiles = false;
    
    // we'll need this layer in a second
    MaplyQuadImageTilesLayer *layer;
    MaplyQuadImageTilesLayer *layerBing;
    
    if (useLocalTiles)
    {
        MaplyMBTileSource *tileSource =
        [[MaplyMBTileSource alloc] initWithMBTiles:@"geography­-class_medres"];
        layer = [[MaplyQuadImageTilesLayer alloc]
                 initWithCoordSystem:tileSource.coordSys tileSource:tileSource];
    } else {
        // Because this is a remote tile set, we'll want a cache directory
        NSString *baseCacheDir =
        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
         objectAtIndex:0];
        NSString *aerialTilesCacheDir = [NSString stringWithFormat:@"%@/osmtiles/",
                                         baseCacheDir];
        int maxZoom = 18;
        
        // MapQuest Open Aerial Tiles, Courtesy Of Mapquest
        // Portions Courtesy NASA/JPL­Caltech and U.S. Depart. of Agriculture, Farm Service Agency
        MaplyRemoteTileSource *tileSource =
        [[MaplyRemoteTileSource alloc]
         initWithBaseURL:@"http://www.stratalogica.com/NystromDigital/static/maps/maps_v4/map_early_learning_world_v4/layer_early_learning_world_label/"
         ext:@"jpg" minZoom:5 maxZoom:maxZoom];
        
        tileSource.cacheDir = aerialTilesCacheDir;
        
        
        layer = [[MaplyQuadImageTilesLayer alloc]
                 initWithCoordSystem:tileSource.coordSys tileSource:tileSource];
        
        layer.flipY = false;
        
        MaplyRemoteTileSource *tileSourceBing =
        [[MaplyRemoteTileSource alloc]
         initWithBaseURL:@"http://otile1.mqcdn.com/tiles/1.0.0/sat/"
         ext:@"png" minZoom:0 maxZoom:5];
        tileSourceBing.cacheDir = aerialTilesCacheDir;
        
        layerBing = [[MaplyQuadImageTilesLayer alloc]
                 initWithCoordSystem:tileSourceBing.coordSys tileSource:tileSourceBing];
    
        
        
//        layerBing.flipY = false;
        
        tileSourceBing.cacheDir = aerialTilesCacheDir;
        
        
        [theViewC addLayer:layerBing];
        [theViewC addLayer:layer];
        
        MaplyBlankTileSource *tileBin = [[MaplyBlankTileSource alloc]initWithCoordSys:tileSourceBing.coordSys minZoom:0 maxZoom:maxZoom];
        
        layerBing = [[MaplyQuadImageTilesLayer alloc]
                     initWithCoordSystem:tileBin.coordSys tileSource:tileBin];
    
        
        
        // start up over San Francisco, center of the universe
//        if (globeViewC != nil)
//        {
//            globeViewC.height = 0.8;
//            [globeViewC animateToPosition:MaplyCoordinateMakeWithDegrees(-122.4192,37.7793)
//                                     time:1.0];
//        } else {
//            mapViewC.height = 1.0;
//            [mapViewC animateToPosition:MaplyCoordinateMakeWithDegrees(-122.4192,37.7793)
//                                   time:1.0];
//        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
