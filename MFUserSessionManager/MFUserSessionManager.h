//
//  MFUserSessionManager.h
//  UserManagerTest
//
//  Created by Maximilian Fischer on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFUserProtocol.h"
#import "MFUserSessionDelegate.h"

@interface MFUserSessionManager : NSObject {
	id<MFUserProtocol> user;
	id<MFUserSessionDelegate> delegate;
	
	BOOL autosaveUser;
}

@property (nonatomic,retain) id<MFUserProtocol> user;
@property (nonatomic,retain) id<MFUserSessionDelegate> delegate;
@property (nonatomic,assign) BOOL autosaveUser;

-(BOOL)loginWithUser:(id<MFUserProtocol>)newUser;
-(BOOL)logout;

-(void)clearUser;
-(void)saveUser;

#pragma mark -
#pragma mark Singleton
+ (MFUserSessionManager*)sharedUserSessionManager;


@end
