//
//  LoginViewController_iPhone.m
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import "LoginViewController.h"
#import "CredentialStore.h"
#import "SVProgressHUD.h"
#import "AuthAPIClient.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.credentialStore = [[CredentialStore alloc] init];
    
    self.navController.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navController.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(login:)];
    

}


- (void)login:(id)sender
{
    [SVProgressHUD show];
    
    id params = @{
                  @"username": self.usernameField.text,
                  @"password": self.passwordField.text
          };
    
    [[AuthAPIClient sharedClient] postPath:@"auth/signin" parameters:params
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               
               
               // a api retorna um json no caso de sucesso
               NSString *authToken = [self getValueForKeyFromJsonObject:@"auth_token" jsonObject:responseObject];
               [self.credentialStore setAuthToken:authToken];
               [SVProgressHUD dismiss];
               [self dismissViewControllerAnimated:YES completion:nil];
               
               //NSLog(@"passou com o token %@",self.credentialStore.authToken);

               
               
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               // a api retorna um json com uma key "error"
               NSString *errorMsg = [self getValueForKeyFromJsonObject:@"error" jsonObject:operation.responseData];
               [SVProgressHUD showErrorWithStatus:errorMsg];
               
           }];
};

- (NSString *)getValueForKeyFromJsonObject:(NSString *)key jsonObject:(id)jsonObject
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonObject options:0 error:nil];
    NSString *stringToReturn = [json objectForKey:key];
    
    return stringToReturn;
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
