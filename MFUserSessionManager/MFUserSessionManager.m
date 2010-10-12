//
//  MFUserSessionManager.m
//  UserManagerTest
//
//  Created by Maximilian Fischer on 11.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MFUserSessionManager.h"
#import "MFUserProtocol.h"
#import "MFUserSessionDelegate.h"

static MFUserSessionManager *sharedMFUserSessionManager;
static NSString *MFUserDefaultsUser = @"MFUserDefaultsUser";

@implementation MFUserSessionManager

@synthesize user;
@synthesize delegate;
@synthesize autosaveUser;

-(BOOL)loginWithUser:(id<MFUserProtocol>)newUser
{
	BOOL isLogin = NO;
	
	if([delegate respondsToSelector:@selector(UserSessionWillLoginUser:)])
	{
		isLogin = (BOOL)[delegate performSelector:@selector(UserSessionWillLoginUser:) withObject:newUser];
	}
	else {
		isLogin = YES;
	}

	
	if (isLogin) {
		
		if(self.user)
			[[NSNotificationCenter defaultCenter] postNotificationName:MFUserHasChanged object:newUser];
		else
			[[NSNotificationCenter defaultCenter] postNotificationName:MFUserHasLogin object:newUser];
	
		self.user = newUser;
		
		if(self.autosaveUser)
			[self saveUser];
	}
	
	return isLogin;
}

-(BOOL)logout
{
	BOOL isLogout = NO;
	
	if([delegate respondsToSelector:@selector(UserSessionWillLogoutUser:)])
	{
		isLogout = (BOOL)[delegate performSelector:@selector(UserSessionWillLogoutUser:) withObject:self.user];
	}
	else {
		isLogout = YES;
	}
	
	
	if(isLogout)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:MFUserHasLogout object:nil];
		[self setUser:nil];
	}
	
	
	
	if(self.autosaveUser)
		[self clearUser];
	
	return isLogout;
}


#pragma mark -
#pragma mark PersistentUser

-(void)saveUser
{
	NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
	[[NSUserDefaults standardUserDefaults] setValue:userData forKey:MFUserDefaultsUser];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSNotificationCenter defaultCenter] postNotificationName:MFUserSessionHasSaveUser object:nil];	
}

-(void)clearUser
{
	[[NSUserDefaults standardUserDefaults] setValue:nil forKey:MFUserDefaultsUser];
	[[NSNotificationCenter defaultCenter] postNotificationName:MFUserSessionHasResetUser object:nil];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadSavedUser
{
	NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:MFUserDefaultsUser];
	user = [(id<MFUserProtocol>)[NSKeyedUnarchiver unarchiveObjectWithData:data] retain];

	if(user)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:MFUserSessionHasLoadSavedUser object:nil];
	}
	
	[data release];
}



#pragma mark -
#pragma mark Singleton

- (id)init {
    static BOOL initialized = NO;
    if (!initialized) {
        self = [super init];
        sharedMFUserSessionManager = self;
        initialized = YES;
    }
    return self;
}

+ (id)allocWithZone:(NSZone*)zone {
    @synchronized (self) {
        if (!sharedMFUserSessionManager)
            sharedMFUserSessionManager = [super allocWithZone:zone];     
    }
    return sharedMFUserSessionManager;
}

+ (MFUserSessionManager*)sharedMFUserSessionManager {
    if (!sharedMFUserSessionManager)
	{  
		[[MFUserSessionManager alloc] init];
		[sharedMFUserSessionManager loadSavedUser];
		
	}
    return sharedMFUserSessionManager;
}

#pragma mark -

-(void)dealloc
{
	[user release];
	[super dealloc];
}


@end
