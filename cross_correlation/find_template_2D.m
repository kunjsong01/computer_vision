% use a template to find pattern in 2D image 
%   template: t
%   image: img

function [yIndex xIndex] = find_template_2D(t, img)
    c = normxcorr2(t, img);

    % experiment: Matlab find function reference provides
    % good example to explain the difference between max(c) and max(c(:))
    % and also the == operator
    % : operator flattens out the matrix. Otherwise it returns columnwise result
    [yRaw, xRaw] = find(c == max(c(:)));
    % Remember: minus the template and add 1
    yIndex = yRaw - size(t, 1) + 1;
    xIndex = xRaw - size(t, 2) + 1;
endfunction
