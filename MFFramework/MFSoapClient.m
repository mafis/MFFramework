//
//  MFSoapClient.m
//  MFFramework
//
//  Created by Maximilian Fischer on 15.10.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MFSoapClient.h"


#define SoapStruktur @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body>%@</soap:Body></soap:Envelope>"
#define SoapStruktur12 @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"><soap12:Body>%@</soap12:Body></soap12:Envelope>"

@implementation MFSoapClient

@synthesize serviceURL;

-(id)initWithServiceURL:(NSString*)url
{
	if(self = [super init])
	{
		serviceURL  = [url retain];
	}
	return self;
}


-(void)dealloc
{
	[serviceURL release];
	[super dealloc];
}

@end
