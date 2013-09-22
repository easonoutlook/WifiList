/*******************************************************************************
 * iPhone-Wireless Project : Stumbler                                          *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 140                                                $ *
 * $Id:: StumblerApplication.h 140 2008-01-29 21:02:23Z lokkju               $ *
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

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Stumbler/StumblerApplication.h $ */
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/CDStructures.h>
#import <UIKit/UIPushButton.h>
#import <UIKit/UIThreePartButton.h>
#import <UIKit/UIWindow.h>
#import <UIKit/UIView-Hierarchy.h>
#import <UIKit/UIView.h>
#import <UIKit/UITransitionView.h>
#import <UIKit/UIHardware.h>
#import <UIKit/UITable.h>
#import <UIKit/UIDateLabel.h>
#import <UIKit/UISectionList.h>

#import <UIKit/UITableCell.h>
#import <UIKit/UITableColumn.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIPushButton.h>
#import <UIKit/UITableCell.h>
#import <UIKit/UINavigationBar.h>
#import <UIKit/UINavigationItem.h>

#import <UIKit/UIImageAndTextTableCell.h>
#include <dlfcn.h>

#import "MSNetworkDetailsView.h"
#import "MSNetworksView.h"
#import "MSNetworksManager.h";

@class MSNetworkDetailsView;
@class MSNetworksView;
@class MSNetworksManager;

@interface StumblerTableCell : UITableCell {
    UITextLabel *network_name;
    UITextLabel *bssid;
}   
- (id) initWithNetwork: (NSDictionary *)network;
@end

@interface StumblerApplication : UIApplication {
    UIWindow *mainWindow;
    UIView *mainView;
    UITransitionView *transitionView;
		NSDictionary *currentNetwork;
    MSNetworkDetailsView *networkDetailsView;
    MSNetworksView *networksView;
    MSNetworksManager *networksManager;
}
+ (StumblerApplication *)sharedInstance;
- (void)applicationDidFinishLaunching:(id)unused;
- (MSNetworksManager *)networksManager;
//- (void)applicationWillSuspend;
- (void)enableiPhonePreference;
- (void)showNetworkDetailsViewWithTransition:(int)trans : (NSString *)aNetwork;
- (void)showNetworksViewWithTransition:(int)trans;
@end