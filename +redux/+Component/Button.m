classdef Button < redux.Component
	% This button won't do anything. If you want to make a button that does
	% something, you'll have to make a subclass that inherits from redux.Button and
	% redux.ActionDispatcher{With|Without}Data.
	
	methods
		function this = Button(parent, label, varargin)
			p = redux.InputParser;
			p.KeepUnmatched = true;
			p.addParent();
			p.addRequired('label', @ischar);
			p.parse(parent, label, varargin{:});
			
			this.handle = uicontrol(...
				'Parent', p.Results.parent.handle, ...
				'String', p.Results.label ...
			);
		
			if(numel(fieldnames(p.Unmatched)))
				this.setParameters(varargin{:});
			end
		end
	end
	
end

