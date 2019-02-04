classdef Slider < redux.Component
	methods
		function this = Slider(parent)
			p = redux.InputParser;
			p.addParent();
			parse(p, parent);
			
			this.handle = uicontrol(...
				'Parent', p.Results.parent.handle, ...
				'Style', 'slider' ...
			);
		end
	end
end

