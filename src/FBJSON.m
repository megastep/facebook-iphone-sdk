//
//  FBJSON.m
//
//  Created by Stéphane Peter on 8/20/09.
//  Copyright 2009 MobileTutor.org. All rights reserved.
//

/*
 * Copyright 2009 MobileTutor.org
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "FBConnect/FBJSON.h"


@implementation NSDictionary (FBJSON)

- (NSString *) getJSON {
	BOOL previous = NO;
	id value;
	
	NSMutableString *str = [NSMutableString stringWithString:@"{"];
	for (id key in self) {
		if (previous) {
			[str appendString:@","];
		}
		value = [self objectForKey:key];
		if ([value respondsToSelector:@selector(getJSON)])
			value = [value getJSON];
		[str appendFormat:@"\"%@\":\"%@\"", key, value];  
		previous = YES;
	}
	[str appendString:@"}"];
	return str;
}

@end

@implementation NSArray (FBJSON)

- (NSString *) getJSON {
	BOOL previous = NO;
	NSMutableString *str = [NSMutableString stringWithString:@"["];
	for (id key in self) {
		if (previous) {
			[str appendString:@","];
		}
		if ([key respondsToSelector:@selector(getJSON)]) {
			[str appendFormat:@"\"%@\"", [key getJSON]];
		} else {
			[str appendFormat:@"\"%@\"", key];
		}
		previous = YES;
	}
	[str appendString:@"]"];
	return str;
}

@end