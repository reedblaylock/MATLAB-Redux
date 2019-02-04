classdef ListBox < redux.Component
	methods
		function this = ListBox(parent)
			p = redux.InputParser;
			p.addParent();
			parse(p, parent);
			
			this.handle = uicontrol( ...
				'Parent', p.Results.parent.handle, ...
				'Style', 'listbox' ...
			);
		end
	end
	
end

