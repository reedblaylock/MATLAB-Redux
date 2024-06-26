% This class is initialized in runGui.m. The constructor function creates a Log
% object and initializes it; the run function creates a set of pseudo-global
% objects, creates the GUI components, sets up the connections between the GUI
% components and their functionality, and disables most interface capabilities
% until a video is loaded.
classdef App < redux.Root & redux.State.Listener
	properties
		state
		styles
		reducer
		gui
		actionFactory
	end
	
	methods
		function this = App(varargin)
			p = inputParser;
			addOptional(p, 'debugSetting', 0);
			parse(p, varargin{:});
			
			if(p.Results.debugSetting == 2)
				dbstop if error
				dbstop if warning
			end
		end
		
		function [] = run(this, packageName)
			this.state = redux.State();
			
			this.reducer = redux.Reducer(this.state, packageName);
			this.actionFactory = redux.Action.Factory(this.reducer, packageName);
			
			this.styles = this.createStyles();
			this.gui = this.createInterface();
			
			this.initializeListeners();
			
			set(findall(this.gui.Window.handle, 'Type', 'uicontrol'), 'Enable', 'off');
		end
		
		function [] = initializeListeners(this)
			% Initialize all the gui elements with a log, register their state
			% listeners, and get them registered with the action listener
			fields = fieldnames(this.gui);
			for iField = 1:numel(fields)
				obj = this.gui.(fields{iField});
				if(isa(obj, 'redux.State.Listener'))
					obj.registerAllMethodsToState(this.state);
				end
				if(isa(obj, 'redux.Action.Dispatcher'))
					obj.actionFactory = this.actionFactory;
				end
			end
			
			% Register redux.App as a state listener
			this.registerAllMethodsToState(this.state);
		end
		
		function [] = initializeComponent(this, obj)
			if(isa(obj, 'redux.State.Listener'))
				obj.registerAllMethodsToState(this.state);
			end
			if(isa(obj, 'redux.Action.Dispatcher'))
				obj.actionFactory = this.actionFactory;
			end
		end
		
		function styles = createStyles(~)
			styles = struct( ...
				'Padding', 3, ...
				'Spacing', 3 ...
			);
		end
		
		function [] = guiDelete(this, fieldname)
			delete(this.gui.(fieldname));
			this.gui.(fieldname) = [];
			this.gui = rmfield(this.gui, fieldname);
		end
	end
end