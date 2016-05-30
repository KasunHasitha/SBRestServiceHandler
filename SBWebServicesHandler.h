//
//  SBWebServicesHandler.h
//  AxiPay
//
//  Created by KASUN HASITHA on 10/15/15.
//  Copyright (c) 2015 SingingBits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if ! DEBUG
#define NSLog(...)
#endif

#define URL(key) \
[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ServiceUrls" ofType:@"strings"]] objectForKey:key]



@interface SBWebServicesHandler : NSObject

//response data colector
@property (retain, nonatomic) NSMutableData *responseData;

//
@property NSString *access_token;


// methods
-(void)callWebService:(NSString*)tag :(NSDictionary*)reqest;
-(void)callWebServiceGet:(NSString*)tag :(NSDictionary*)reqest;
-(void)callWebServiceFileUpload:(NSString*)tag :(NSDictionary*)reqest;



@end
