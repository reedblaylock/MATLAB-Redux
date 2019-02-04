classdef MenuItem < redux.Component
	methods
		function this = MenuItem(parent, label)
			p = redux.InputParser;
			p.addParent();
			p.addRequired('label', @ischar);
			p.parse(parent, label);
			
			this.handle = uimenu( ...
				'Parent', p.Results.parent.handle, ...
				'Label', p.Results.label ...
			);
		end
	end
	
end

