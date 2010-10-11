//
//  MFUserProtocol.h
//  UserManagerTest
//
//  Created by Maximilian Fischer on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MFUserProtocol <NSObject,NSCoding>

@required
@property (nonatomic, retain) NSString* username;

@optional

@end
