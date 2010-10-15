//
//  MFUserSessionDelegate.h
//  UserManagerTest
//
//  Created by Maximilian Fischer on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFUserProtocol.h"

#define MFUserHasChanged @"MFUserHasChanged"
#define MFUserHasLogout @"MFUserHasLogout"
#define MFUserHasLogin @"MFUserHasLogin"
#define MFUserSessionHasSaveUser @"MFUserSessionHasSaveUser"
#define MFUserSessionHasResetUser @"MFUserSessionHasResetUser"
#define MFUserSessionHasLoadSavedUser @"MFUserSessionHasLoadSavedUser"

@protocol MFUserSessionDelegate <NSObject>

@optional 
-(BOOL)UserSessionWillLoginUser:(id<MFUserProtocol>)user;
-(BOOL)UserSessionWillLogoutUser:(id<MFUserProtocol>)user;

@end
