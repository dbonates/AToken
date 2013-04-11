//
//  AuthAPIClient.h
//  AToken
//
//  Created by Daniel Bonates on 4/10/13.
//  Copyright (c) 2013 Daniel Bonates. All rights reserved.
//

#import "AFNetworking.h"

@interface AuthAPIClient : AFHTTPClient

+ (id)sharedClient;


@end
