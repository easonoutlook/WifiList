#*******************************************************************************
#* iPhone-Wireless Project : Stumbler                                          *
#* Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
#* Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
#*******************************************************************************
#* $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
#* $LastChangedBy:: lokkju                                                   $ *
#* $LastChangedRevision:: 140                                                $ *
#* $Id:: Makefile 140 2008-01-29 21:02:23Z lokkju                            $ *
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

# $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Stumbler/Makefile $
VERSION=0.04.`date +%s`
CC=arm-apple-darwin-gcc
LD=$(CC)
CFLAGS=
LDFLAGS=-lobjc -framework CoreFoundation -framework Foundation -framework UIKit -framework LayerKit -framework CoreGraphics
all:    Stumbler

Stumbler:  stumbler.o StumblerApplication.o MSNetworksView.o MSNetworkDetailsView.o MSNetworksManager.o
	$(LD) $(LDFLAGS) -o $@ $^
	@echo $(VERSION)>VERSION

%.o:    %.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

test:	Stumbler package deploy
	@echo running application...
	@cp resources/test.sh deploy/test.sh
	sh deploy/test.sh

package: FORCE
	@echo package files...
	@mkdir -p deploy/Stumbler.app
	@chmod o+rwx,g+rwx,a+rx Stumbler
	@cp Stumbler deploy/Stumbler.app/Stumbler
	@cp resources/icon.png deploy/Stumbler.app/icon.png
	@cp resources/Default.png deploy/Stumbler.app/Default.png
	@cp resources/Info.plist deploy/Stumbler.app/Info.plist
	@cp VERSION deploy/VERSION

deploy:	FORCE
	@echo sending the files...
	@cp resources/deploy.sh deploy/deploy.sh
	@(cd deploy && sh deploy.sh)

clean:	FORCE
	rm -f *.o Stumbler
	rm -rf deploy

FORCE:

