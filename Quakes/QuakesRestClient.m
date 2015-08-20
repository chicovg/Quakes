//
//  QuakesRestClient.m
//  Quakes
//
//  Created by Victor Guthrie on 8/4/15.
//  Copyright (c) 2015 Victor Guthrie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QuakesRestClient.h"
#import "Quake.h"
#import "Constants.h"

@implementation QuakesRestClient

- (void) fetchQuakeData: (id<QuakesRestClientDelegate>) clientDelegate {
    
    controller = clientDelegate;
    
    NSString *urlString = @"http://earthquake.usgs.gov/earthquakes/shakemap/rss.xml";

    NSLog(@"Sending Request to URL %@", urlString);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                         cachePolicy:NSURLRequestReloadIgnoringCacheData
                                     timeoutInterval:30.0];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    return;
    
}

- (void) parseDocument:(NSData *) data {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setDelegate:self];
    
    [parser setShouldProcessNamespaces:YES];
    [parser setShouldReportNamespacePrefixes:YES];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"Received Response");
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        long status = [httpResponse statusCode];
        
        if (!((status >= 200) && (status < 300))) {
            NSLog(@"Connection failed with status %ld", status);
        } else {
            quakeData = [[NSMutableData alloc] initWithCapacity:1024];
        }
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [quakeData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    //NSString *xml = [[NSString alloc] initWithData:quakeData encoding:NSUTF8StringEncoding];
    //NSLog(@"xml = %@", xml);
    
    results = [[NSMutableArray alloc] init];
    
    [self parseDocument:quakeData];
    
    [controller performSelector:@selector(updateQuakeData:) withObject:results];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"response loaded");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed");
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {    if ([elementName isEqualToString:ITEM]) {
        currentItem = [[Quake alloc] init];
        withinQuakeItem = true;
    } else if (withinQuakeItem) {
        currentElement = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {    if ([currentElement isEqualToString:TITLE]) {
        currentItem.title = string;
    } else if ([currentElement isEqualToString:LAT]) {
        currentItem.lat = string;
    } else if ([currentElement isEqualToString:LONG]) {
        currentItem.lng = string;
    } else if ([currentElement isEqualToString:PUB_DATE]) {
        currentItem.time = string;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:ITEM]) {
        [results addObject:currentItem];
        withinQuakeItem = false;
    }
}

@end