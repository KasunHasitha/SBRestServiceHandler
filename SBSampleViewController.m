/////////////////////////////////////
//  SBSampleViewController.m
//  
//
//  Created by KASUN HASITHA on 5/30/16.
//
/////////////////////////////////////

#import "SBSampleViewController.h"


@interface SBSampleViewController ()

@end

@implementation SBSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    //adding Observer
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getResponce:)
                                                 name:@"login"
                                               object:nil];
    //NOTE
    //make sure to give the observer name same as the token and url Key
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    //removing observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"login" object:nil];
    
    
}



- (void)makeRequest {
    
    NSString *email =@"name@email.com";
    NSString *password = @"kasun@123";
    
    
    NSArray *keys;
    NSArray *objects;
    NSDictionary *Dictionary;
    
    // Preparing the request -they are different in search and non search
    keys = [NSArray arrayWithObjects:@"Email",@"Password",nil];
    objects = [NSArray arrayWithObjects:email,password,nil];
    
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    
    Dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:jsonDictionary, nil] forKeys:[NSArray arrayWithObjects:@"request",nil]];
    
    
    //create object from SBWebServicesHandler class
    SBWebServicesHandler *webServiceHandler = [[SBWebServicesHandler alloc ] init];
    
        [webServiceHandler callWebService:@"login" :jsonDictionary];
        
    
}


-(void)getResponce:(NSNotification*)notif{
    
    
    NSLog(@"get data %@",notif.userInfo);
    
    
    
}


@end
