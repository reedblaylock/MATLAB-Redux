function [] = create_app
	newapp_dir = 'D:/Programs/MATLAB/R2014b/toolbox/vttoolboxtest/';
	if ~exist(newapp_dir, 'dir'), mkdir(newapp_dir), end
	
	% Create a template for rendering the GUI
	copyfile('App.txt', [newapp_dir 'App.m']);
	
	% Create a Reducer system
	copyfile('sampleReducer.txt', [newapp_dir 'Reducer' filesep 'sampleReducer.m']);
	
	% Create init() function to run the app
	copyfile('init.txt', [newapp_dir 'init.m']);
end