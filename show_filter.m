function show_filter(filter_name)
    dir = [pwd() '/filters/' filter_name '_filter.mat'];
    filter = load(dir); filter = filter.filter;
    filter = abs(filter);
    filter = uint8(255*(filter - min(min(filter(:))))/(...
        max(max(filter(:))) - min(min(filter(:)))));
    imshow(filter,[]);
end