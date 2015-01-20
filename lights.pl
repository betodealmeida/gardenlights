#!/usr/bin/env perl
use Device::BCM2835;
use DateTime;
use DateTime::Event::Sunrise;
use strict;
use warnings;

my($lat, $lon) = (37.369643, -122.031677);
my $hours_on = 3;

Device::BCM2835::init() 
 || die "Could not init library";

# Set RPi pin 11 to be an output
Device::BCM2835::gpio_fsel(&Device::BCM2835::RPI_GPIO_P1_11, 
                           &Device::BCM2835::BCM2835_GPIO_FSEL_OUTP);

my($OFF, $ON) = (0, 1);
my $state = $OFF;
my $dt;
my $sunrise = DateTime::Event::Sunrise->new(
    longitude => $lon,
    latitude  => $lat,
    altitude  => -0.833,
    precise   => 1
);
while (1)
{
    $dt = DateTime->now;
    my $start = $sunrise->sunset_datetime($dt);
    my $stop = $sunrise->sunset_datetime($dt)->add(
        hours => $hours_on
    );

    if (($start <= $dt) and ($dt < $stop))
    {
        if ($state eq $OFF)
        {
            # Turn it on
            Device::BCM2835::gpio_write(&Device::BCM2835::RPI_GPIO_P1_11, 1);
            $state = $ON;
        }
    }
    else
    {
        if ($state eq $ON)
        {
            # Turn it off
            Device::BCM2835::gpio_write(&Device::BCM2835::RPI_GPIO_P1_11, 0);
            $state = $OFF;
        }
    }
    Device::BCM2835::delay(1000 * 60); # Milliseconds
}
