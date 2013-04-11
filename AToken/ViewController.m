//
//  ViewController.m
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import "ViewController.h"
#import "CredentialStore.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.credentialStore = [[CredentialStore alloc] init];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getThere:(id)sender {
    if ([self.credentialStore isLoggedIn]) {
        //
    }
    else
    {
        UIStoryboard *sb = self.storyboard;
        
    }
}

- (IBAction)clearToken:(id)sender {
}


@end
