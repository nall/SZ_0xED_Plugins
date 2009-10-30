//  Copyright (c) 2006 Suavetech

// Please read the README.TXT included with this project first

#import <Foundation/Foundation.h>

@protocol ValueTypePluginProtocol

// This will be called by 0xED to initialize your class.
+(NSObject<ValueTypePluginProtocol>*)initializeClass;

// This will be displayed in the first column in value view - it is the name of
// the type the plug-in is dealing with.
-(NSString*)name;

// String representation of the given data. If none is available, pass back nil.
// Reasons for passing back nil would be insufficient data or invalid data passed in.
// Data passed in is never larger than 256 bytes regardless of how much the user
// has selected.
-(NSString*)stringRep: (NSData*)data prefs:(NSDictionary*)prefs;

// This should return YES if type accepts user input (not always the case if you
// have a checksum or some such type). If you return NO here the 'dataRep' selector below
// will never be called.
-(BOOL)userEditable;

// Get data for the given user input. Data will be written to file. Pass back nil
// if data is invalid (i.e. there are letter and you're expecting numbers only).
// If the NSData* passed back is smaller than the user selection, only the number of
// bytes of in NSData* is replaced in the user selection
-(NSData*)dataRep: (NSString*)str prefs:(NSDictionary*)prefs;

// A couple of notes on the preferences. You can currently obtain two user preferences:
// 1.) Decimal number mode preference by doing this:
//     BOOL decimalNumbersMode = [[dict objectForKey: @"DecimalNumbersMode"] boolValue];
// 2.) Little endian mode preference by doing this:
//     BOOL littleEndianMode = [[dict objectForKey: @"LittleEndianMode"] boolValue];
// 3.) String encoding:
//     NSStringEncoding strEnc = [[dict objectForKey: @"StringEncoding"] unsignedIntValue];
@end
