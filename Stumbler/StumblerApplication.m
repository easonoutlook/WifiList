/*******************************************************************************
 * iPhone-Wireless Project : Stumbler                                          *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 140                                                $ *
 * $Id:: StumblerApplication.m 140 2008-01-29 21:02:23Z lokkju               $ *
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

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Stumbler/StumblerApplication.m $ */

#import "StumblerApplication.h"

@implementation StumblerTableCell

- (id) initWithNetwork: (NSDictionary *)network
{
    self = [super init];
    network_name = [[UITextLabel alloc] initWithFrame: CGRectMake(9.0f, 7.0f, 260.0f, 29.0f)];
    bssid = [[UITextLabel alloc] initWithFrame: CGRectMake(10.0f, 26.0f, 260.0f, 34.0f)];

    float c[] = { 0.0f, 0.0f, 0.0f, 0.0f };
    float h[] = { 1.0f, 1.0f, 1.0f, 1.0f };
    
    if ([[network objectForKey: @"HIDDEN_NETWORK"] boolValue]) {
        [network_name setText: @"<hidden>"];
    } else {
        [network_name setText: [network objectForKey: @"SSID_STR"]];
    }
    [network_name setFont: [UIImageAndTextTableCell defaultTitleFont]];
    [network_name setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), c)];
    [network_name setHighlightedColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), h)];
    
    [bssid setText: [network objectForKey: @"BSSID"]];
    [bssid setFont: [UIDateLabel defaultFont]];
    [bssid setColor: CGColorCreateCopyWithAlpha([bssid color], 0.4f)];
    [bssid setBackgroundColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), c)];
    [bssid setHighlightedColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(), h)];

    
    [self addSubview: bssid];
    [self addSubview: network_name];

    [self setShowDisclosure: YES];
    [self setDisclosureStyle: 2];

    return self;
}

- (void) drawContentInRect: (struct CGRect)rect selected: (BOOL) selected
{
    [network_name setHighlighted: selected];
    [bssid setHighlighted: selected];
    
    [super drawContentInRect: rect selected: selected];
}

@end
static StumblerApplication *sharedInstance;
@implementation StumblerApplication
- (void) showAlert: (NSString *) msg
{
	NSMutableArray *buttons = [[NSMutableArray alloc] init];
	[buttons addObject:[NSString stringWithString:@"OK"]];
	UIAlertSheet *alert = [[UIAlertSheet alloc]
		initWithTitle:@"Alert"
		buttons:buttons
		defaultButtonIndex:0
		delegate:self
		context:self];
	[alert setBodyText:msg];
	[alert _slideSheetOut:YES];
	[alert setRunsModal:YES];
	[alert popupAlertAnimated:YES];
}
- (void) alertSheet:(UIAlertSheet *)sheet buttonClicked:(int) bnum
{
	[sheet dismiss];
}
+ (StumblerApplication *)sharedInstance
{
	if (!sharedInstance)
		sharedInstance = [[StumblerApplication alloc] init];
	
	return sharedInstance;
}
- (void) applicationDidFinishLaunching: (id) unused
{
    sharedInstance = self;
    struct CGRect rect = [UIHardware fullScreenApplicationContentRect];
    rect.origin.x = rect.origin.y = 0.0f;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    float whiteComponents[4] = {1, 1, 1, 1};
    float transparentComponents[4] = {0, 0, 0, 0};
    networksManager = [[MSNetworksManager alloc] init];
    transitionView = [[UITransitionView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    mainView = [[UIView alloc] initWithFrame:rect];
    [mainView addSubview:transitionView];
    mainWindow = [[UIWindow alloc] initWithContentRect:rect];
    [mainWindow setContentView:mainView];
    [mainWindow orderFront:self];
    [mainWindow makeKey:self];
    [mainWindow _setHidden:NO];
    [self showNetworksViewWithTransition:1];
}
- (MSNetworksManager *)networksManager
{
	return networksManager;
}
- (void)enableiPhonePreference
{
}
- (void)showNetworksViewWithTransition:(int)trans
{
	if (!networksView)
	{
		struct CGRect rect = [UIHardware fullScreenApplicationContentRect];
		rect.origin.x = rect.origin.y = 0.0f;
		networksView = [[MSNetworksView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
	}
	[transitionView transition:trans toView:networksView];
}
- (void)showNetworkDetailsViewWithTransition:(int)trans : (NSString *)aNetwork
{
	if (!networkDetailsView)
	{
		struct CGRect rect = [UIHardware fullScreenApplicationContentRect];
		rect.origin.x = rect.origin.y = 0.0f;
		networkDetailsView = [[MSNetworkDetailsView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
	}
	[networkDetailsView setNetwork:aNetwork];
	[transitionView transition:trans toView:networkDetailsView];
}

@end
