//
//  QuakesRestClient.h
//  Quakes
//
//  Created by Victor Guthrie on 8/4/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Quake;

@protocol QuakesRestClientDelegate <NSObject>

- (void) updateQuakeData: (NSArray *) data;

@end

@interface QuakesRestClient : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate> {
    NSMutableArray	*results;
    NSMutableData   *quakeData;
    Quake           *currentItem;
    BOOL            withinQuakeItem;
    NSString        *currentElement;
    id<QuakesRestClientDelegate> controller;
}

- (void) fetchQuakeData: (id<QuakesRestClientDelegate>) controller;

@end
