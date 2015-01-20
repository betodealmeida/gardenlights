# Garden lights controller

This repo contains two simple programs that I use to control my garden lights:

  - `lights.pl` turns on the lights at sunset, based on the day, latitude and
    longitude. You can find your coordinates on Google Maps by typing your 
    address and then right clicking "What's in here?". Lights turn off after 3
    hours (configurable).

  - `server.pl` is a Mojolicious web app that displays two buttons, one for
    turning the lights on and the other for turning them off.

Both programs need to be run as root, since they access `/dev/mem/`.

I used this simple circuit to connect a relay to the Raspberry pi, using a 
transistor:

![Circuit](http://www.reuk.co.uk/OtherImages/connect-raspberry-pi-to-a-relay.jpg)
