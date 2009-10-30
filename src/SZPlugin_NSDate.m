//  SZPlugin_NSDate.m
//  0xED_Plugins
//
//  Created by Jon Nall on 10/29/09.
//  Copyright 2009 STUNTAZ!!!. All rights reserved.
//

#import "SZPlugin_NSDate.h"

@implementation SZPlugin_NSDate
+(NSObject<ValueTypePluginProtocol>*)initializeClass
{
	return [[[SZPlugin_NSDate alloc] init] autorelease];
}

-(NSString*)name
{
	return @"NSDate (ms since epoch)";
}

-(NSString*)stringRep:(NSData*)data
                prefs:(NSDictionary*)prefs
{
    const BOOL littleEndianMode = [[prefs objectForKey: @"LittleEndianMode"] boolValue];
    const char* bytes = [data bytes];

    if(data && [data length] == 4)
    {
        uint32_t milliseconds;
        if(littleEndianMode == NO)
        {
            milliseconds =
            (bytes[0] << 24) |
            (bytes[1] << 16) |
            (bytes[2] <<  8) |
            (bytes[3] <<  0);
        }
        else
        {
            milliseconds =
            (bytes[3] << 24) |
            (bytes[2] << 16) |
            (bytes[1] <<  8) |
            (bytes[0] <<  0);            
        }
        
        NSTimeInterval seconds = milliseconds;
        seconds /= 1000;
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:seconds];
        return [date description];
    }
    else if(data && [data length] == 8)
    {
        uint64_t milliseconds = 0;

        if(littleEndianMode == NO)
        {
            milliseconds = 
            (((uint64_t)bytes[0] & 0xFF) << 56) |
            (((uint64_t)bytes[1] & 0xFF) << 48) |
            (((uint64_t)bytes[2] & 0xFF) << 40) |
            (((uint64_t)bytes[3] & 0xFF) << 32) |
            (((uint64_t)bytes[4] & 0xFF) << 24) |
            (((uint64_t)bytes[5] & 0xFF) << 16) |
            (((uint64_t)bytes[6] & 0xFF) <<  8) |
            (((uint64_t)bytes[7] & 0xFF) <<  0);
        }
        else
        {
            milliseconds =
            (((uint64_t)bytes[7] & 0xFF) << 56) |
            (((uint64_t)bytes[6] & 0xFF) << 48) |
            (((uint64_t)bytes[5] & 0xFF) << 40) |
            (((uint64_t)bytes[4] & 0xFF) << 32) |            
            (((uint64_t)bytes[3] & 0xFF) << 24) |
            (((uint64_t)bytes[2] & 0xFF) << 16) |
            (((uint64_t)bytes[1] & 0xFF) <<  8) |
            (((uint64_t)bytes[0] & 0xFF) <<  0);            
        }
        
        NSTimeInterval seconds = milliseconds;
        seconds /= 1000;
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:seconds];
        return [date description];        
    }
    else
    {
        return nil;
    }
}

-(BOOL)userEditable
{
	return NO;
}

-(NSData*)dataRep:(NSString*)string
            prefs:(NSDictionary*)prefs
{
    return nil;
}

@end
