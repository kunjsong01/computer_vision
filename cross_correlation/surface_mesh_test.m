clf;
colormap ("default");
Z = peaks ();
surfc(Z);
title ({"surf() plot of peaks() function"; "color determined by height Z"});
