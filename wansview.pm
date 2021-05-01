# ==========================================================================
#
# ZoneMinder ONVIF Control Protocol Module
# Copyright (C) Jan M. Hochstein
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# ==========================================================================
#
# This module contains the implementation of the ONVIF device control protocol
#
package ZoneMinder::Control::wansview;

use 5.006;
use strict;
use warnings;

require ZoneMinder::Control;

our @ISA = qw(ZoneMinder::Control);

our %CamParams = ();

# ==========================================================================
#
# ONVIF Control Protocol
#
# On ControlAddress use the format :
#   USERNAME:PASSWORD@ADDRESS:PORT
#   eg : admin:@10.1.2.1:80
#        zoneminder:zonepass@10.0.100.1:40000
#
# ==========================================================================

use ZoneMinder::Logger qw(:all);
use ZoneMinder::Config qw(:all);

use Time::HiRes qw( usleep );

sub open {
  my $self = shift;

  $self->loadMonitor();

  use LWP::UserAgent;
  $self->{ua} = LWP::UserAgent->new;
  $self->{ua}->agent('ZoneMinder Control Agent/'.ZoneMinder::Base::ZM_VERSION);

  $self->{state} = 'open';
}

sub printMsg
{
    my $self = shift;
    my $msg = shift;
    my $msg_len = length($msg);

    Debug( $msg );
}


sub sendCmd
{
  my $self = shift;
  my $xx = shift;
  my $yy = shift;
  my $result = undef;

  my ( $USER, $PASS, $ADDR, $PORT ) 
        = $self->{Monitor}->{ControlAddress} =~ /^(.*):(.*)@(.*):(\d+)$/;

  $self->printMsg("$xx $yy", 'Tx');
  my $out = `/usr/bin/node ZoneminderWansview/wansview_ptz.js $USER $PASS $ADDR $PORT $xx $yy 2>&1` or Debug("Couldn't exec command : $!");
  Debug( "Out : $out" );

}

#Up Arrow
sub moveConUp
{
  my $self = shift;
  Debug( "Move Up" );
  $self->sendCmd(0, 1);
}

#Down Arrow
sub moveConDown
{
  my $self = shift;
  Debug( "Move Down" );
  $self->sendCmd(0, -1);
}

#Left Arrow
sub moveConLeft
{
  my $self = shift;
  Debug( "Move Left" );
  $self->sendCmd(-1, 0);
}

#Right Arrow
sub moveConRight
{
  my $self = shift;
  Debug( "Move Right" );
  $self->sendCmd(1, 0);
}

sub moveStop
{
  my $self = shift;
  Debug( "Move Stop" );
}

1;
