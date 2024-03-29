classdef App < redux.Component.Window & redux.State.Listener
	methods
		function this = App(name)
			p = redux.InputParser();
			p.addRequired('name', @ischar);
			p.parse(name);
			
			this@redux.Component.Window(name);
		end
		
		function [] = onVideoChange(this, state)
			this.setParameters('Name', [this.baseName ' - ' state.video.fullpath]);
		end
		
		function [] = delete(this)
			delete@redux.State.Listener(this);
% 			clear redux.Config;
% 			clear redux.Action.NewRegion;
		end
	end
	
end

