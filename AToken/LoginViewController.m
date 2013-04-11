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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(login:)];
    

}


- (void)login:(id)sender
{
    [SVProgressHUD show];
    
    id params = @{
                  @"username": self.usernameField.text,
                  @"password": self.passwordField.text
          };
    
    [[AuthAPIClient sharedClient] postPath:@"auth/sigin" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                
                                    
                                    NSString *authToken = [responseObject objectForKey:@"auth_token"];
                                    [self.credentialStore setAuthToken:authToken];
                                    [SVProgressHUD dismiss];
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    if (operation.response.statusCode == 500) {
                                        [SVProgressHUD showErrorWithStatus:@"Hiii, deu ruim!"];
                                        
                                    }
                                    else
                                    {
                                        NSData  *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
                                        NSString *errorMsg = [json objectForKey:@"error"];
                                        [SVProgressHUD showErrorWithStatus:errorMsg];
                                    }
                                }];
};

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
