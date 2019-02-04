classdef Empty < redux.Component.Layout
	methods
		function this = Empty(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
		end
	end
	
	methods (Access = protected)
		function [] = construct(this, parent)
			p = redux.InputParser;
			p.addParent();
			parse(p, parent);
			
% 			this.handle = uiextras.Empty( ...
% 				'Parent', p.Results.parent.handle ...
% 			);
		
			if redux.Config.isOldMatlabVersion()
				% Use the old version of the GUI Layout Toolbox
				this.handle = uiextras.Empty( ...
					'Parent', p.Results.parent.handle ...
				);
			else
				% Use the new version of the GUI Layout Toolbox
				this.handle = uix.Empty( ...
					'Parent', p.Results.parent.handle ...
				);
			end
		end
	end
end

