/*
Fraise version 3.7 - Based on Smultron by Peter Borg
Written by Jean-François Moy - jeanfrancois.moy@gmail.com
Find the latest version at http://github.com/jfmoy/Fraise

Copyright 2010 Jean-François Moy
 
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 
http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

#import "FRAStandardHeader.h"

#import "FRACommandManagedObject.h"
#import "FRABasicPerformer.h"
#import "FRAApplicationDelegate.h"
#import "FRAToolsMenuController.h"

@implementation FRACommandManagedObject


- (void)awakeFromInsert
{
	[super awakeFromInsert];
	
	[self setValue:[FRABasic createUUID] forKey:@"uuid"];
}

- (void)didChangeValueForKey:(NSString *)key
{	
	[super didChangeValueForKey:key];
	
	if ([[FRAApplicationDelegate sharedInstance] hasFinishedLaunching] == NO) {
		return;
	}

	if (![key isEqualToString:@"uuid"]) {	
		[[FRAToolsMenuController sharedInstance] buildRunCommandMenu];
	}
}
		

- (NSComparisonResult)localizedCaseInsensitiveCompare:(id)object
{
	NSComparisonResult result = NSOrderedSame;
	
	if ([object isKindOfClass:[self class]]) {
		result = [[object valueForKey:@"name"] localizedCaseInsensitiveCompare:[self valueForKey:@"name"]];
	}
	
	return result;
}
@end
