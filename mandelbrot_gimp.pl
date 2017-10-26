#!/usr/bin/perl
#
# $Id: mandelbrot_gimp.pl,v 1.2 2005-03-11 17:13:27 adelayde Exp $
#
# $Log: mandelbrot_gimp.pl,v $
# Revision 1.2  2005-03-11 17:13:27  adelayde
# Fixed quadratic equations
#
# Revision 1.1  2005/03/11 12:55:23  nelf
# Made work using The Gimp.
#
#

use strict;
use warnings;
use Gimp qw(:consts main xlfd_size :auto); 

my %params = 
    ( 
      height     => 320, 
      width      => 240,
      );

sub mandelbrot {

    my $img = Gimp->image_new($params{'width'}, $params{'height'}, RGB); 

    my $bg_layer = $img->layer_new($img->width, $img->height, 
				   RGB, "BG", 100, NORMAL_MODE); 
    $img->add_layer($bg_layer, -1);

    my $drw = $img->image_active_drawable;


    # We're filling with BLACK, so that we don't have to manually set
    # every black pixel.
    # The following uses hex RGB values.. you can just as easily use decimal.
    Palette->set_background([0x00,0x00,0x00]);

    $drw->edit_fill(BACKGROUND_FILL);     
    
    # preparar página web
    
    # colores
    
    #MSetLSM

    my $nx = $params{'width'}; # resolucion en x
    my $ny = $params{'height'}; # resolucion en y
    my $xmin = -2.5; # valor mínimo en plano real
    my $xmax = 0.8; # valor máximo en plano real
    my $ymin = -1.25; # valor mínimo en plano imaginario
    my $ymax = 1.25; # valor máximo en plano imaginario
    my $maxiter = 60; # número máximo de iteraciones
    my $limite = 10000.00; # límite considerado y valor tiende a infinidad
    
    my $xprop = ($xmax - $xmin) / ($nx - 1);
    my $yprop = ($ymax - $ymin) / ($ny - 1);
    
    for(my $iy = 0; $iy < $ny; $iy++) {

	my $cy = $ymin + $iy * $yprop;

	for(my $ix = 0; $ix < $nx; $ix++) {

	    my $cx = $xmin + $ix * $xprop;

	    # iteración

	    my ($x, $y, $x2, $y2) = (0.0, 0.0, 0.0, 0.0);
	    my $iter = 0;
	    
	    while( ($iter < $maxiter) && (($x2 + $y2) < $limite)) {
		
		# formula es z -> z^2 + c
		
		my $temp = $x2 - $y2 + $cx;
		$y = 2 * $x * $y + $cy;
		$x = $temp;
		$x2 = $x * $x;
		$y2 = $y * $y;
		$iter++;
	    }
	    
	    if ($iter == $maxiter) {
		# We've set the background of the image to be black, so we don't
		# set the pixel at all in this case
	    } else {
		# You can use hex or decimal for the RGB value.
		$drw->set_pixel($ix, $iy, [255,255,255]);
	    }
	}
    }
    Gimp->gimp_file_save(RUN_NONINTERACTIVE, $drw, 'output.xcf', 'output.xcf');
}

Gimp::on_net(\&mandelbrot);

exit main();
