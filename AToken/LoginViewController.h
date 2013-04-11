//
//  LoginViewController_iPhone.h
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CredentialStore;

@interface LoginViewController : UIViewController

@property (nonatomic, strong) CredentialStore *credentialStore;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (void)login:(id)sender;
- (void)cancel:(id)sender;

@end
