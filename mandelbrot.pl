#!/usr/bin/perl
#
#

use CGI;

# preparar p�gina web

my $cgi = new CGI;
print $cgi->header . $cgi->start_html('Joc Mandelbrot');
print '<table border="0" cellspacing="0" cellpadding="0">';

# colores

#my @colores = ['#000000', '#FFFF00', '#FFCC00', '#CCCC00', '#CC9900', '#999900', '#996600', '#666600', '#663300', '#333300'];

#my $numcolores = scalar (@colores);

#MSetLSM

my $nx = 320; # resolucion en x
my $ny = 240; # resolucion en y
my $xmin = -2.25; # valor m�nimo en plano real
my $xmax = 0.75; # valor m�ximo en plano real
my $ymin = -1.5; # valor m�nimo en plano imaginario
my $ymax = 1.5; # valor m�ximo en plano imaginario
my $maxiter = 60; # n�mero m�ximo de iteraciones
my $limite = 10000.0; # l�mite considerado y valor tiende a infinidad

my $xprop = ($xmax - $xmin) / ($nx - 1);
my $yprop = ($ymax - $ymin) / ($ny - 1);

for(my $iy = 0; $iy < $ny; $iy++) {

    my $cy = $ymin + $iy * $yprop;

    print '<tr style="height: 1px;">';

    for(my $ix = 0; $ix < $nx; $ix++) {

	my $cx = $xmin + $ix * $xprop;

	# iteraci�n

	my ($x, $y, $x2, $y2) = 0.0;
	my $iter = 0;

	while( ($iter < $maxiter) && (($x2 + $y2) < $limite)) {

	    # formula es z -> z^2 + c
	    
	    my $temp = $x2 - $y2 + $cx;
	    $y = 2 * $x * $y + $cy;
	    $x = $temp;
	    $x2 = $x^2;
	    $y2 = $y^2;
	    $iter++;
	}
	
#	my $color = ($iter == 0)?'#000000':
#	    '#FF' . printf("%2d", hex($iter)) . '00';

#	print '<td bgcolor="' . $color . '">&nbsp;</td>';

	if ($iter == $maxiter) {
	    print '<td><img src="/images/0.png" /></td>';
	} else {
	    print '<td><img src="/images/1.png" /></td>';
	}
    }

    print '</tr>';

}

print '</table>' . $cgi->end_html;

exit(0);
