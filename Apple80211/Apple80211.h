/*******************************************************************************
 * iPhone-Wireless Project : Apple80211 Library                                *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 04:52:20 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 139                                                $ *
 * $Id:: Apple80211.h 139 2008-01-29 20:52:20Z lokkju                        $ *
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

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Apple80211/Apple80211.h $ */
#ifndef APPLE80211_H_
#define APPLE80211_H_

#ifdef __OBJC__

    #import <Foundation/NSString.h>
    #import <Foundation/NSArray.h>
    #import <Foundation/NSDictionary.h>

    int Apple80211Open(void **handle);

    int Apple80211BindToInterface(void *handle, NSString *interface);

    int Apple80211Scan(void *handle, NSArray **networks, NSDictionary *parameters);

    int Apple80211Close(void *handle);

#else

    #include <CoreFoundation/CoreFoundation.h>

    int Apple80211Open(void **handle);

    int Apple80211BindToInterface(void *handle, CFStringRef interface);

    int Apple80211Scan(void *handle, CFArrayRef *networks, CFDictionaryRef parameters);

    int Apple80211Close(void *handle);

#endif /* __OBJC__ */

#endif /* APPLE80211_H_ */