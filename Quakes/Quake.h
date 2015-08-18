//
//  Quake.h
//  Quakes
//
//  Created by Victor Guthrie on 8/4/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quake : NSObject 

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *time;

@end


//
//o	The USGS title for the quake
//o	The latitude and longitude of the quake
//o	The time the quake occurred in local time
