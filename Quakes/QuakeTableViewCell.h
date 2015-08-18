//
//  QuakeTableViewCell.h
//  Quakes
//
//  Created by Victor Guthrie on 8/10/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quake.h"

@interface QuakeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *magnitude;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet UILabel *datetime;

-(void)setFields: (Quake *)quake;
-(void) setMagnitudeColor: (double) value;

@end
