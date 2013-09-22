/*******************************************************************************
 * iPhone-Wireless Project : Stumbler                                          *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 140                                                $ *
 * $Id:: MSNetworkDetailsView.h 140 2008-01-29 21:02:23Z lokkju              $ *
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

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Stumbler/MSNetworkDetailsView.h $ */
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/CDStructures.h>
#import <UIKit/UIHardware.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIView.h>

#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTableCell.h>
#import <UIKit/UIPreferencesTextTableCell.h>
#import <UIKit/UIPreferencesDeleteTableCell.h>
#import <UIKit/UINavigationBar.h>

#import "StumblerApplication.h"

@class StumblerApplication;

@interface MSNetworkDetailsView : UIView {
	UINavigationBar *navBar;
	UITable *table;
	NSDictionary *network;
	StumblerApplication *ms;
}

- (id)initWithFrame:(struct CGRect)frame;
- (void)reloadTableData;
- (void)setNetwork:(NSString *)aNetwork;

//Delegate Methods
- (void)navigationBar:(UINavigationBar*)bar buttonClicked:(int)button;

//DataSource Methods
- (void)tableRowSelected:(NSNotification *)notification;
- (BOOL)table:(UITable*)table canSelectRow:(int)row;
//DataSource Methods
- (int)numberOfRowsInTable:(UITable *)table;
- (UITableCell *)table:(UITable *)table cellForRow:(int)row column:(int)col;

@end