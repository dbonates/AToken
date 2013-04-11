//
//  ViewController.h
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CredentialStore;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *infogetBtn;

@property (nonatomic, strong) CredentialStore *credentialStore;
@property (weak, nonatomic) IBOutlet UITextView *logText;

- (IBAction)getThere:(id)sender;
- (IBAction)clearToken:(id)sender;
- (IBAction)getUsers:(id)sender;

- (NSString *)getValueForKeyFromJsonObject:(NSString *)key jsonObject:(id)jsonObject;


@end
