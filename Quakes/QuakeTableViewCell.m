//
//  QuakeTableViewCell.m
//  Quakes
//
//  Created by Victor Guthrie on 8/10/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import "QuakeTableViewCell.h"
#import "Quake.h"

@implementation QuakeTableViewCell
@synthesize title, latitude, longitude, datetime;

-(void) setFields: (Quake *)quake {
    
    if(nil != quake.title){
        NSArray *split = [quake.title componentsSeparatedByString:@" - "];
        
        NSString *mStr = [split objectAtIndex:0];
        [self setMagnitudeColor:[mStr doubleValue]];
        self.magnitude.text = mStr;
        self.title.text = [split objectAtIndex:1];
    }
    
    self.latitude.text = [NSString stringWithFormat:@"Lat: %@", quake.lat];
    self.longitude.text = [NSString stringWithFormat:@"Long: %@", quake.lng];
    
    if (nil != quake.time) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss ZZZ"];
        NSDate *date = [formatter dateFromString:quake.time];
        
        NSString *dateStr = [NSDateFormatter localizedStringFromDate:date
                                       dateStyle:NSDateFormatterShortStyle
                                       timeStyle:NSDateFormatterShortStyle];
        self.datetime.text = dateStr;
    }
}

-(void) setMagnitudeColor: (double) value {
    if (value <= 1.0) {
        self.magnitude.textColor = [UIColor darkGrayColor];
    } else if (value <= 3.0) {
        self.magnitude.textColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.88 alpha:1.0];
    } else if (value <= 4.0) {
        self.magnitude.textColor = [UIColor colorWithRed:0.50 green:0.74 blue:0.38 alpha:1.0];
    } else if (value <= 5.0) {
        self.magnitude.textColor = [UIColor colorWithRed:0.98 green:0.91 blue:0.23 alpha:1.0];
    } else if (value <= 6.0) {
        self.magnitude.textColor = [UIColor colorWithRed:0.89 green:0.28 blue:0.17 alpha:1.0];
    } else {
        self.magnitude.textColor = [UIColor colorWithRed:0.67 green:0.19 blue:0.16 alpha:1.0];
    }
}


@end
