classdef TextBox < redux.Component
	properties
		backupText
	end
	
	methods
		function this = TextBox(parent, varargin)
			p = redux.InputParser;
			p.KeepUnmatched = true;
			p.addParent();
			p.addParameter('String', '', @ischar);
			p.parse(parent, varargin{:});
			
			this.handle = uicontrol( ...
				'Parent', p.Results.parent.handle, ...
				'Style', 'edit', ...
				'String', p.Results.String ...
			);
		
			this.backupText = p.Results.String;
		
			if(numel(fieldnames(p.Unmatched)))
				this.setParameters(varargin{:});
			end
		end
	end
	
end

