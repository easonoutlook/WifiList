/*******************************************************************************
 * iPhone-Wireless Project : Telephony Library                                 *
 * Copyright (C) 2007      Geohot <geohot@gmail.com>                           *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 140                                                $ *
 * $Id:: CoreTelephony.h 140 2008-01-29 21:02:23Z lokkju                     $ *
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

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/CellStumbler/CoreTelephony.h $ */
#include <CoreFoundation/CoreFoundation.h>

//Functions I'm sure about
struct CTServerConnection
{
	int a;
	int b;
	CFMachPortRef myport;
	int c;
	int d;
	int e;
	int f;
	int g;
	int h;
	int i;
};

struct CellInfo
{
	int servingmnc;
	int network;
	int location;
	int cellid;
	int station;
	int freq;
	int rxlevel;
	int c1;
	int c2;
};

struct CTServerConnection * _CTServerConnectionCreate(CFAllocatorRef, void *, int *);	//the void* is a callback
mach_port_t _CTServerConnectionGetPort(struct CTServerConnection *);
int *_CTServerConnectionCellMonitorStart(int *,struct CTServerConnection *);

void _CTServerConnectionRegisterForNotification(void *, struct CTServerConnection *, void *); //kCTCellMonitorUpdateNotification
void kCTCellMonitorUpdateNotification();

int *_CTServerConnectionCellMonitorGetCellCount(int *,struct CTServerConnection *,int *);
int *_CTServerConnectionCellMonitorGetCellInfo(int *,struct CTServerConnection *,int, struct CellInfo *);	//3rd is cell tower num
