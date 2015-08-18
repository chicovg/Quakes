//
//  QuakesTableViewController.h
//  Quakes
//
//  Created by Victor Guthrie on 8/4/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuakesRestClient.h"

@interface QuakesTableViewController : UITableViewController<UITableViewDataSource, QuakesRestClientDelegate> {
    NSArray	*quakesList;
    QuakesRestClient *quakesRestClient;
}
- (IBAction)refreshQuakeData:(UIBarButtonItem *)sender;

@end
