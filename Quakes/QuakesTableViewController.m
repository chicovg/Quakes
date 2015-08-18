//
//  QuakesTableViewController.m
//  Quakes
//
//  Created by Victor Guthrie on 8/4/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import "QuakesTableViewController.h"
#import "QuakeTableViewCell.h"
#import "Quake.h"

@implementation QuakesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    quakesRestClient = [[QuakesRestClient alloc] init];
    [quakesRestClient fetchQuakeData:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)refreshQuakeData:(UIBarButtonItem *)sender {
    [quakesRestClient fetchQuakeData:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [quakesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quakeCell" forIndexPath:indexPath];
    
    Quake *quake = [quakesList objectAtIndex:[indexPath row]];
    [cell setFields:quake];
    
    return cell;
}

#pragma mark - QuakesRestClientDelegate

- (void) updateQuakeData: (NSArray *) data {
    quakesList = data;
    
    [self.tableView reloadData];
}


@end
