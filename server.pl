#!/usr/bin/env perl
use Device::BCM2835;
use Mojolicious::Lite;

# call set_debug(1) to do a non-destructive test on non-RPi hardware
Device::BCM2835::init() 
 || die "Could not init library";

# Blink pin 11:
# Set RPi pin 11 to be an output
Device::BCM2835::gpio_fsel(&Device::BCM2835::RPI_GPIO_P1_11, 
                           &Device::BCM2835::BCM2835_GPIO_FSEL_OUTP);

get '/' => {template => 'index'};

get '/:state' => sub {
    my $c     = shift;
    my $state = $c->param('state');
    if ($state eq 'on')
    {
        Device::BCM2835::gpio_write(&Device::BCM2835::RPI_GPIO_P1_11, 1);
    }
    elsif ($state eq 'off')
    {
        Device::BCM2835::gpio_write(&Device::BCM2835::RPI_GPIO_P1_11, 0);
    }
    else
    {
        die 'Invalid request!';
    }
    $c->render(text => "Turned lights $state.");
};

app->start;
__DATA__

@@ index.html.ep
% title 'Backyard lights';
% layout 'bootstrap';
<div class="jumbotron vertical-center">
  <div class="container text-center">
    <div class="btn-group btn-group-lg" role="group" aria-label="lights">
      <button id="on" class="btn btn-success" type="button">
        <span class="glyphicon glyphicon-ok-circle" aria-hidden="true"></span>
        On
      </button>
      <button id="off" class="btn btn-danger" type="button">
        <span class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span>
        Off
      </button>
    </div>
  </div>
</div>

@@ layouts/bootstrap.html.ep
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <style>
/* http://jsfiddle.net/hashem/ut5sbqvz/ */
html, body {
  height: 100%;
}

.jumbotron.vertical-center {
  margin-bottom: 0; /* Remove the default bottom margin of .jumbotron */
}

.vertical-center {
  min-height: 100%;  /* Fallback for vh unit */
  min-height: 100vh; /* You might also want to use
                        'height' property instead.
                        
                        Note that for percentage values of
                        'height' or 'min-height' properties,
                        the 'height' of the parent element
                        should be specified explicitly.
  
                        In this case the parent of '.vertical-center'
                        is the <body> element */

  /* Make it a flex container */
  display: -webkit-box;
  display: -moz-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex; 
  
  /* Align the bootstrap's container vertically */
    -webkit-box-align : center;
  -webkit-align-items : center;
       -moz-box-align : center;
       -ms-flex-align : center;
          align-items : center;
  
  /* In legacy web browsers such as Firefox 9
     we need to specify the width of the flex container */
  width: 100%;
  
  /* Also 'margin: 0 auto' doesn't have any effect on flex items in such web browsers
     hence the bootstrap's container won't be aligned to the center anymore.
  
     Therefore, we should use the following declarations to get it centered again */
         -webkit-box-pack : center;
            -moz-box-pack : center;
            -ms-flex-pack : center;
  -webkit-justify-content : center;
          justify-content : center;
}

    </style>
  </head>
  <body>
    <%= content %>
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script>
      $('#on').click(function() {
        $.ajax({
          url: "/on"
        });
      });
      $('#off').click(function() {
        $.ajax({
          url: "/off"
        });
      });
    </script>
  </body>
</html>
