#*******************************************************************************
#* iPhone-Wireless Project : Apple80211 Library                                *
#* Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
#* Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
#*******************************************************************************
#* $LastChangedDate:: 2008-01-30 04:52:20 +0800 (Wed, 30 Jan 2008)           $ *
#* $LastChangedBy:: lokkju                                                   $ *
#* $LastChangedRevision:: 139                                                $ *
#* $Id:: Makefile 139 2008-01-29 20:52:20Z lokkju                            $ *
#*******************************************************************************
#*  This program is free software: you can redistribute it and/or modify       *
#*  it under the terms of the GNU General Public License as published by       *
#*  the Free Software Foundation, either version 3 of the License, or          *
#*  (at your option) any later version.                                        *
#*                                                                             *
#*  This program is distributed in the hope that it will be useful,            *
#*  but WITHOUT ANY WARRANTY; without even the implied warranty of             *
#*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              *
#*  GNU General Public License for more details.                               *
#*                                                                             *
#*  You should have received a copy of the GNU General Public License          *
#*  along with this program.  If not, see <http://www.gnu.org/licenses/>.      *
#*******************************************************************************

# $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Apple80211/Makefile $
ARM_DARWIN_TOOLCHAIN=/usr/local/arm-apple-darwin
HEAVENLY=$(ARM_DARWIN_TOOLCHAIN)/heavenly

CC=$(ARM_DARWIN_TOOLCHAIN)/bin/gcc
CFLAGS=-fPIC
LDFLAGS=-Wl,-syslibroot,$(HEAVENLY) -lobjc -framework CoreFoundation -ldl -dynamiclib

objects = main.o

all:	Apple80211

Apple80211: $(objects)
	$(CC) $(LDFLAGS) -o $@ $(objects)
	mkdir -p Apple80211.framework
	cp Apple80211 Info.plist Apple80211.framework
	mkdir -p Apple80211.framework/Headers
	cp Apple80211.h Apple80211.framework/Headers

%.o:    %.c
	$(CC) $(CFLAGS) -c $(CPPFLAGS) $< -dynamic -o $@

install:
	cp -rf Apple80211.framework $(HEAVENLY)/System/Library/Frameworks/
	mkdir -p $(ARM_DARWIN_TOOLCHAIN)/arm-apple-darwin/include/Apple80211
	cp -f Apple80211.h $(ARM_DARWIN_TOOLCHAIN)/arm-apple-darwin/include/Apple80211/

clean:
	rm -f *.o Apple80211
	rm -rf Apple80211.framework