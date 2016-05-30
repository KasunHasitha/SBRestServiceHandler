//////////////////////////////////////////////////////////
//  SBWebServicesHandler
//
//
//  Created by KASUN HASITHA on 10/15/15.
//  Copyright (c) 2015 SingingBits. All rights reserved.
//////////////////////////////////////////////////////////

#import "SBWebServicesHandler.h"


@implementation SBWebServicesHandler


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    
    return self;
}


//********************************* CALL  ************************************
//POST all data from here
-(void)callWebService:(NSString*)tag :(NSDictionary*)reqest{
    
    NSURL *url;
    NSData *jsonData;
    NSString *jsonString;
    NSURLConnection *connection;
    
    NSString *suffix = URL(tag);
    NSString *prefix = URL(@"WebService");
    
    
    
    url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",prefix,suffix]];
    
    NSLog(@"%@", url);
    
    
    
    // Generate JSON request string
    
    if([NSJSONSerialization isValidJSONObject:reqest])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:reqest options:0 error:nil];
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", jsonString);
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    
    
    
    [request setTimeoutInterval:120.0];
    
    connection.currentRequest.URL.accessibilityHint = tag;
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    connection.currentRequest.URL.accessibilityHint = tag;
}

//send all data from here(optianal)
-(void)callWebServiceFileUpload:(NSString*)tag :(NSDictionary*)reqest{
    
    NSURL *url;
    NSData *jsonData;
    NSString *jsonString;
    NSURLConnection *connection;
    
    NSString *suffix = URL(tag);
    NSString *prefix = URL(@"fileUploadService");
    // NSString *prefix = URL(@"WebService");
    
    
    
    url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",prefix,suffix]];
    
    
    NSLog(@"%@", url);
    // NSString *urlString = [NSString stringWithFormat:@"%@",url];
    
    // Generate JSON request string
    
    if([NSJSONSerialization isValidJSONObject:reqest])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:reqest options:0 error:nil];
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", jsonString);
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    
    [request setTimeoutInterval:120.0];
    connection.currentRequest.URL.accessibilityHint = tag;
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    connection.currentRequest.URL.accessibilityHint = tag;
}

//GET all data from here(
-(void)callWebServiceGet:(NSString*)tag :(NSDictionary*)reqest{
    
    NSURL *url;
    NSData *jsonData;
    NSString *jsonString;
    NSURLConnection *connection;
    
    NSString *suffix = URL(tag);
    NSString *prefix = URL(@"WebService");
    
    url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",prefix,suffix]];
    
    NSLog(@"%@", url);
    
    
    
    // Generate JSON request string
    
    if([NSJSONSerialization isValidJSONObject:reqest])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:reqest options:0 error:nil];
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", jsonString);
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    
    
    //optional
    [request setTimeoutInterval:120.0];
    
    connection.currentRequest.URL.accessibilityHint = tag;
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    connection.currentRequest.URL.accessibilityHint = tag;
}


//******************************* DELEGATE *********************************************************
#pragma mark NSURLConnection Delegate Methods
// this dalegate methods will call for all requests but identify separetly by connectin name

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
    // NSLog(@"receved data");
}


// after getting data append the response data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
    
}


// Return nil to indicate not necessary to store a cached response for this connection
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
    
}

//if their a error with NSUrlConection server error/timeout..
- (void)connection:(NSURLConnection *)connection

  didFailWithError:(NSError *)error{
    
    NSLog(@"%@",error);
    UIAlertView *ResultsAlert = [[UIAlertView alloc]initWithTitle:@"Alert"
                                                          message:@"Service fails with error"
                                                         delegate:self
                                                cancelButtonTitle:@"Continue"
                                                otherButtonTitles: nil];
    [ResultsAlert show];
    
}

// end the reciving procces and get the data to use ...
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    NSError *jsonParsingError = nil;
    
    id jsonObject  = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&jsonParsingError];
    
    if (![jsonObject isKindOfClass:[NSArray class]])
    {
        NSMutableDictionary *jsonDictionary = (NSMutableDictionary *)jsonObject;
        
        
        
        // Accesing the response.
        
        
        NSLog(@"did finish %@",jsonDictionary);
        
        if([jsonDictionary objectForKey:@"code"]){
            
            NSLog(@"Found some error ");
            
        }
        else{
            
            NSString *tag = connection.currentRequest.URL.accessibilityHint;
            
            NSLog(@"the tag %@",tag);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:tag object:nil userInfo:jsonDictionary];
            
            
        }//code
    }
    
}



@end
