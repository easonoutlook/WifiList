/*******************************************************************************
 * iPhone-Wireless Project : Telephony Library                                 *
 * Copyright (C) 2007      Geohot <geohot@gmail.com>                           *
 * Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
 * Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
 *******************************************************************************
 * $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
 * $LastChangedBy:: lokkju                                                   $ *
 * $LastChangedRevision:: 140                                                $ *
 * $Id:: main.c 140 2008-01-29 21:02:23Z lokkju                              $ *
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

/* $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/CellStumbler/main.c $ */
#include "CoreTelephony.h"
#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>
#include <sys/time.h>

/*
	main.c : Hack to CoreTelephony. Most of the peculiarities of the code below is based on obervation. 
*/

/*
	For some reason, all these variables have to be global. Toolchain bug?
*/
CFMachPortRef port;
struct CTServerConnection *sc=NULL;
struct CellInfo cellinfo;
int b;
int t1;

/* 
	Never called.
*/
void callback()
{
	printf("Callback called\n");
}

/*
 	Again, _CTServerConnectionCreate() has to be called outside the main(), or whatever is using CTServerConnection. 
	Hence the existence of this function.
*/
	
void cellconnect()
{
	int t1;
	sc=_CTServerConnectionCreate(kCFAllocatorDefault, callback, NULL);

	/*
		port is not currently used, shuld be usable with a runloop.
	*/
	port=CFMachPortCreateWithPort(kCFAllocatorDefault, _CTServerConnectionGetPort(sc), NULL, NULL, NULL);

	_CTServerConnectionCellMonitorStart(&t1,sc);

	printf("Connected\n");
}

void getCellInfo()
{
	int cellcount;
	_CTServerConnectionCellMonitorGetCellCount(&t1,sc,&cellcount);

	printf("Cell count: %x\n",cellcount);

	printf("Size = %x\n", sizeof(struct CellInfo));

	unsigned char *a=malloc(sizeof(struct CellInfo));

	for(b=0;b<cellcount;b++)
	{	
		//OMG the toolchain is broken, &cellinfo doesn't work
		_CTServerConnectionCellMonitorGetCellInfo(&t1,sc,b,a); memcpy(&cellinfo,a,sizeof(struct CellInfo));
		//OMG the toolchain is more broken, these printfs don't work on one line
		printf("Cell Site: %d, MNC: %d, ",b,cellinfo.servingmnc);
		printf("Location: %d, Cell ID: %d, Station: %d, ",cellinfo.location, cellinfo.cellid, cellinfo.station);
		printf("Freq: %d, RxLevel: %d, ", cellinfo.freq, cellinfo.rxlevel);
		printf("C1: %d, C2: %d\n", cellinfo.c1, cellinfo.c2);
	}
	if(a) free(a);

}

int main()
{
	printf("iPhone Cell Stumbler\n");
	cellconnect();
	int cellcount;
	while(1)
	{
		getCellInfo();
		sleep(1);
	}
	return 0;
}

