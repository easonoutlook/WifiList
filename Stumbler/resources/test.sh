#*******************************************************************************
#* iPhone-Wireless Project : Stumbler                                          *
#* Copyright (C) 2007-2008 Pumpkin <pumpkingod@gmail.com>                      *
#* Copyright (C) 2007-2008 Lokkju <lokkju@gmail.com>                           *
#*******************************************************************************
#* $LastChangedDate:: 2008-01-30 05:02:23 +0800 (Wed, 30 Jan 2008)           $ *
#* $LastChangedBy:: lokkju                                                   $ *
#* $LastChangedRevision:: 140                                                $ *
#* $Id:: test.sh 140 2008-01-29 21:02:23Z lokkju                             $ *
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

# $HeadURL: http://iphone-wireless.googlecode.com/svn/trunk/Stumbler/resources/test.sh $
# TARGET should be your iphone's ip.  I use /etc/hosts to link iphone to the ip
TARGET=iphone
NAME=Stumbler
USER=root
VERSION=`cat VERSION`
echo Running Application...
ssh -t $USER@$TARGET /Applications/$NAME-$VERSION.app/$NAME
ssh $USER@$TARGET rm -rf /Applications/$NAME-$VERSION.app

