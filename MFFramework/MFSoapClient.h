//
//  MFSoapClient.h
//  MFFramework
//
//  Created by Maximilian Fischer on 15.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MFSoapClient : NSObject {
	NSString *serviceURL;
}

@property (nonatomic,retain,readonly) NSString *serviceURL;

-(id)initWithServiceURL:(NSString*)url;

@end
