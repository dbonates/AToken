//
//  CredentialStore.m
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import "CredentialStore.h"
#import "SSKeychain.h"

#define SERVICE_NAME @"AToken_app-AuthClient"
#define AUTH_TOKEN_KEY @"auth_token"


@implementation CredentialStore



- (BOOL)isLoggedIn
{
    return [self authToken] != nil;
}
- (void)clearSavedCredentials
{
    [self setAuthToken:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"token-expired" object:self];

}
- (NSString *)authToken
{
    return [self fetchSecureValueForKey:AUTH_TOKEN_KEY];
}
- (void)setAuthToken:(NSString *)authToken
{
    [self setSecureValue:authToken forKey:AUTH_TOKEN_KEY];
    if (authToken) [[NSNotificationCenter defaultCenter] postNotificationName:@"token-changed" object:self];
}

// salva e recupera o auth_token no keychain
- (void)setSecureValue:(NSString *)value forKey:(NSString *)key
{
    if (value) {
        [SSKeychain setPassword:value forService:SERVICE_NAME account:key];
    }
    else
    {
        [SSKeychain deletePasswordForService:SERVICE_NAME account:key];
    }

}

- (NSString *)fetchSecureValueForKey: (NSString *)key
{
    return [SSKeychain  passwordForService:SERVICE_NAME account:key];
}


@end
