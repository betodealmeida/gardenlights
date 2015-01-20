# Garden lights controller

This repo contains two simple programs that I use to control my garden lights:

  - `lights.pl` turns on the lights at sunset, based on the day, latitude and
    longitude. You can find your coordinates on Google Maps by typing your 
    address and then right clicking "What's in here?". Lights turn off after 3
    hours (configurable).

  - `server.pl` is a Mojolicious web app that displays two buttons, one for
    turning the lights on and the other for turning them off.

Both programs need to be run as root, since they access `/dev/mem/`. In my case
I simply added them to `/etc/rc.local` in my Raspberry pi:

    /root/lights/lights.pl &
    /usr/local/bin/hypnotoad /root/lights/server.pl &

I used this simple circuit to drive the relay to the Raspberry pi:

![Circuit](http://www.reuk.co.uk/OtherImages/connect-raspberry-pi-to-a-relay.jpg)
