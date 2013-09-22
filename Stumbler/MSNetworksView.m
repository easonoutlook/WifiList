/*******************************************************************************
 * iPhone-Wireless Project : Stumbler                                          *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 140                                                $ *
 * $Id:: MSNetworksView.m 140 2008-01-29 21:02:23Z lokkju                    $ *
 *******************************************************************************
 *  This program is free software: you can redistribute it and/or modify       *
 *  it under the terms of the GNU General Public License as published by       *
 *  the Free Software Foundation, either version 3 of the License, or          *
 *  (at your option) any later version.                                        *
 *                                                                             *
 *  This program is distributed in the hope that it will be useful,            *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of             *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              *
 *  GNU General Public License for more details.                               *
 *                                                                             *
 *  You should have received a copy of the GNU General Public License          *
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.      *
 *******************************************************************************/

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Stumbler/MSNetworksView.m $ */
#import "MSNetworksView.h"

@implementation MSNetworksView

- (id)initWithFrame:(struct CGRect)frame
{
	self = [super initWithFrame:frame];
	
	ms = [StumblerApplication sharedInstance];
	//Get full screen app rect
	struct CGRect rect = [UIHardware fullScreenApplicationContentRect];
	rect.origin.x = rect.origin.y = 0.0f;
	
	
	navBar = [[UINavigationBar alloc] init];
	[navBar setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 45.0f)];
	[navBar showLeftButton:@"Quit" withStyle:0 rightButton:nil withStyle:0];
	//[navBar showButtonsWithLeftTitle:nil rightTitle:@"Rescan" leftBack:YES];
	title = [[UINavigationItem alloc] initWithTitle: @"Networks"];
  	[navBar pushNavigationItem: title];
	[navBar setDelegate:self];
	[navBar enableAnimation];

	scanButton = [[[UIPushButton alloc] initWithTitle:@"Stop" autosizesToFit:YES] autorelease];
	[scanButton setFrame: CGRectMake(268.0, 20.0, 50.0, 44.0)];
	[scanButton setDrawsShadow: NO];
	[scanButton setEnabled:YES];
	[scanButton setStretchBackground:NO];
	//[scanButton setBackground:[UIImage applicationImageNamed:@"getnew.png"] forState:0];
	[scanButton addTarget: self action: @selector(toggleScan) forEvents: (1<<6)];
	[navBar addSubview: scanButton];
	
	openNetworks = [[NSMutableArray alloc] init];
	protectedNetworks = [[NSMutableArray alloc] init];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networksUpdated:) name:@"NetworksUpdated" object:nil];
	//[[ms networksManager] scan];
	sectionList = [[UISectionList alloc] initWithFrame:CGRectMake(rect.origin.x, 45.0f, rect.size.width, rect.size.height - 45.0f) showSectionIndex:NO];
	[sectionList setDataSource:self];
	[sectionList reloadData];

	stable = [sectionList table];
	[stable setShouldHideHeaderInShortLists:NO];
  	UITableColumn *packageColumn = [[UITableColumn alloc] initWithTitle:@"Network Name" identifier:@"name" width:320.0f];
	[stable addTableColumn:packageColumn];
	[stable setSeparatorStyle:1];
	[stable setRowHeight:64.0f];
	[stable setDelegate:self];
	[self addSubview:navBar];
	[self addSubview:sectionList];
	[[ms networksManager] autoScan:true];
	return self;
}

- (void) toggleScan
{
/*	
	_spinner = [[[UIProgressIndicator alloc] initWithFrame: CGRectMake(80.0f, 13.0f, 20.0f, 20.0f)] autorelease];
	[_spinner setAnimationDuration:1];
	[_spinner startAnimation];
	[botNavBar addSubview: _spinner];
	
	_spinnerLabel = [[[UITextLabel alloc] initWithFrame: CGRectMake(110.0f, 13.0f, 150.0f, 20.0f)] autorelease];
	[_spinnerLabel setFont:[NSClassFromString(@"WebFontCache") createFontWithFamily:@"Helvetica" traits:2 size:12]];
	[_spinnerLabel setText: @"Refreshing Feed"];
	[_spinnerLabel setBackgroundColor: [UIView colorWithRed:52.0f green:154.0f blue:243.0f alpha:0.0f]];
	[_spinnerLabel setColor: [UIView colorWithRed:52.0f green:154.0f blue:243.0f alpha:1.0f]];
	[_spinnerLabel setWrapsText: NO];
	[botNavBar addSubview: _spinnerLabel];

	ThreadProcesses *_tproc = [[[ThreadProcesses alloc] init] autorelease];
	[_tproc setDelegate: self];

	[NSThread detachNewThreadSelector:@selector(refreshSingleFeed:) toTarget:_tproc withObject:nil];
*/
	if([scanButton title] == @"Stop") {
		[scanButton setTitle:@"Scan"];
		[scanButton setEnabled:NO];
		[[ms networksManager] autoScan:false];
		[scanButton setEnabled:YES];
	} else {
		[scanButton setTitle:@"Stop"];		
		[scanButton setEnabled:NO];
		[[ms networksManager] autoScan:true];
		[scanButton setEnabled:YES];
	}
	
}

- (BOOL) isProtected: (NSDictionary *)network
{
		return (([network objectForKey:@"WEP"] && [[network objectForKey:@"WEP"] boolValue]) || [network objectForKey:@"WPA_IE"]);
}


- (void)networksUpdated:(NSNotification *)notification
{
    NSArray *networks = [[[ms networksManager] networks] allValues];
    NSDictionary *parameters = [[NSDictionary alloc] init];    
    [openNetworks removeAllObjects];
    [protectedNetworks removeAllObjects];
    
    int i;
    for (i = 0; i < [networks count]; i++) {
        if ([self isProtected: [networks objectAtIndex: i]]) {
            NSLog(@"Adding to protected networks");
            [protectedNetworks addObject: [networks objectAtIndex: i]];
        } else {
            NSLog(@"Adding to open networks");
            [openNetworks addObject: [networks objectAtIndex: i]];            
        }
	//NSDictionary *net = [networks objectAtIndex: i];
	//NSEnumerator *netenum = [net keyEnumerator];
	//id key;
	//while ((key = [netenum nextObject])) {
	//	CFShow([net objectForKey: key]);
	//	NSLog(@"%@:%@",key,[net objectForKey: key]);
	//}
		}
		[sectionList reloadData];
    [title setTitle:[NSString stringWithFormat:@"Networks (%d)", [openNetworks count] + [protectedNetworks count]]];
}


#pragma mark ----------Delegate Methods-----------
- (void)navigationBar:(UINavigationBar*)navbar buttonClicked:(int)button 
{
	NSLog(@"Clicked Button: %i", button);
	if (button == 0) { // Rescan
	} else if ( button == 1) { //Exit 
		exit(0);
	}
}
- (void)tableRowSelected:(NSNotification *)notification
{
	[ms showNetworkDetailsViewWithTransition:1 : [[self itemForIndex:[stable selectedRow]] objectForKey:@"BSSID"]];
}

#pragma mark ----------Datasource Methods-----------

- (NSDictionary *) itemForIndex: (int)index
{
    if (index < [openNetworks count]) {
        return [openNetworks objectAtIndex: index];
    } else {
        return [protectedNetworks objectAtIndex: index - [openNetworks count]];        
    }
}

- (int) numberOfRowsInTable: (UITable *)table
{
    return [openNetworks count] + [protectedNetworks count];
}

- (UITableCell *) table: (UITable *)table cellForRow: (int)row column: (int)col
{
    StumblerTableCell *cell = [[StumblerTableCell alloc] initWithNetwork: [self itemForIndex: row]];
    
    return cell;
}

- (UITableCell *) table: (UITable *)table cellForRow: (int)row column: (int)col
    reusing: (BOOL) reusing
{
    return [self table: table cellForRow: row column: col];
}

#pragma mark ----------SectionList Methods-----------

- (int)numberOfSectionsInSectionList:(UISectionList *)aSectionList {
    return 2;
}
        
- (NSString *)sectionList:(UISectionList *)aSectionList titleForSection:(int)section {    
    NSLog(@"Section: %d",section);
    if (section == 1) {
        return @"Protected"; 
    } else {
        return @"Open";
    }
}       
        
- (int)sectionList:(UISectionList *)aSectionList rowForSection:(int)section {
    if (section == 1) {
        return [openNetworks count]; 
    } else {
        return 0;
    }
}

@end