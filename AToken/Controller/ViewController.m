//
//  ViewController.m
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import "ViewController.h"
#import "CredentialStore.h"
#import "LoginViewController.h"
#import "AuthAPIClient.h"
#import "SVProgressHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.credentialStore = [[CredentialStore alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tokenExpiredProvidences:) name:@"token-expired" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tokenSaved:) name:@"token-changed" object:nil];
    

}

- (void)tokenSaved:(NSNotification *)notification
{
    [self.infogetBtn setTitle:@"Getinfo"];
    [self.logText setText:@"usuario logado."];
}

- (void)tokenExpiredProvidences:(NSNotification *)notification
{
    [self.infogetBtn setTitle:@"Login"];
    [self.logText setText:@"aguardando login"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getThere:(id)sender {
    if ([self.credentialStore isLoggedIn])
    {
        //NSLog(@"token a provar: %@", self.credentialStore.authToken);
        [SVProgressHUD show];
        
        
        [[AuthAPIClient sharedClient] getPath:@"/home/index"
                                   parameters:@{@"auth_toke": @"edae859ddd7e7de19e41c804290e44b97ac6b775"}
                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                          NSLog(@"passou com o token %@",self.credentialStore.authToken);

                                          NSDictionary *jsonPeople = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                                          self.logText.text = [jsonPeople description];
                                          [SVProgressHUD dismiss];
                                      }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                          NSLog(@"erro, limpar token %@", self.credentialStore.authToken);
//                                          NSLog(@"erro: %@", [self getValueForKeyFromJsonObject:@"error" jsonObject:operation.responseData]);
                                          
                                          if (operation.response.statusCode == 403 || operation.response.statusCode == 401) { // Forbidden, token expirou
                                              [self.credentialStore clearSavedCredentials];
                                              

                                          }
                                          // a api retorna um json com uma key "error"
                                          NSString *errorMsg = [self getValueForKeyFromJsonObject:@"error" jsonObject:operation.responseData];
                                          [SVProgressHUD showErrorWithStatus:errorMsg];
                                      }];
        
        
    }
    else
    {
        UIStoryboard *sb = self.storyboard;
        LoginViewController *loginWindow = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginWindow animated:YES completion:nil];
    }
}



- (IBAction)getUsers:(id)sender {
    
    [[AuthAPIClient sharedClient] getPath:@"auth/getall" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonPeople = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        self.logText.text = [jsonPeople description];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *errorMsg = [self getValueForKeyFromJsonObject:@"error" jsonObject:operation.responseData];
        [SVProgressHUD showErrorWithStatus:errorMsg];
        
    }];
    
    
}



- (NSString *)getValueForKeyFromJsonObject:(NSString *)key jsonObject:(id)jsonObject
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonObject options:0 error:nil];
    NSString *stringToReturn = [json objectForKey:key];
    
    return stringToReturn;
}


- (IBAction)clearToken:(id)sender {
    
    [self.credentialStore clearSavedCredentials];
}




@end
