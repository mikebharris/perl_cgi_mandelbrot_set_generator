A very, very long time ago, I wrote this Perl script that generates the Mandelbrot Set using HTML <td> tags.  Note it's extremely resource intensive and generates a huge file.
You're recommended to run it on a local server.

Alternatively, and definitely more easily, run it on the command line and view the resultant HTML file in a browser:

```shell
% perl mandelbrot.pl > set.html
```

It should end up looking like this:

![](mset.png)

If you really want to see how GitHub renders it, a copy of the HTML produced is at [mset.html](mset.html)