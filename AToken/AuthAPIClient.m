//
//  AuthAPIClient.m
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import "AuthAPIClient.h"
#import "CredentialStore.h"

#define BASE_URL @"http://localhost:3000"

@implementation AuthAPIClient

+ (id)sharedClient
{
    static AuthAPIClient *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:BASE_URL];
        __instance = [[AuthAPIClient alloc] initWithBaseURL:baseUrl];
    });
    return __instance;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
    }
    return self;
}

@end
