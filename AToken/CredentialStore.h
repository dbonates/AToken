//
//  CredentialStore.h
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CredentialStore : NSObject


- (BOOL)isLoggedIn;
- (void)clearSavedCredentials;
- (NSString *)authToken;
- (void)setAuthToken:(NSString *)authToken;



@end
