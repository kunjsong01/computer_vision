% use a template to find pattern in 1D signal
%   tempalte: t
%   signal: s 

function index = find_template_1D(t, s)
    c = normxcorr2(t, s);
    disp('size(t): ')
    disp(size(t))
    disp('size(t, 2): ') % dim = 2 means get the number of columns
    disp(size(t, 2))
    disp([1:size(c, 2); c]);
    [maxValue rawIndex] = max(c);
    index = rawIndex - size(t, 2) + 1;
endfunction

