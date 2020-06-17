%%Example WEBCAM custom preview window for MATLAB R2017a
%%List connected webcams
webcamlist
%%Connect to webcam
c = webcam(2);
%%Setup preview window
fig = figure('NumberTitle', 'off', 'MenuBar', 'none');
fig.Name = 'My Camera';
ax = axes(fig);
frame = snapshot(c);
im = image(ax, zeros(size(frame), 'uint8'));
axis(ax, 'image');
%%Start preview
preview(c, im)
setappdata(fig, 'cam', c);
% fig.CloseRequestFcn = @closePreviewWindow_Callback;
% %%Local functions
% function closePreviewWindow_Callback(obj, ~)
% c = getappdata(obj, 'cam');
% closePreview(c)
% delete(obj)
% end