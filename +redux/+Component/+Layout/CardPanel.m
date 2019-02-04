classdef CardPanel < redux.Component.Layout
	methods
		function this = CardPanel(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
        end
        
        function [] = setParameters(this, varargin)
			p = inputParser;
			p.KeepUnmatched = true;
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout'));
			parse(p, this, varargin{:});
			
			s = p.Unmatched;
			
			if redux.Config.isOldMatlabVersion()
                % Change Contents to Children
				nameToChange = 'Contents';
				nameReplacement = 'Children';
				s = this.renameField(s, nameToChange, nameReplacement);
				
				% Change Selection to SelectedChild
				nameToChange = 'Selection';
				nameReplacement = 'SelectedChild';
				s = this.renameField(s, nameToChange, nameReplacement);
			end
			
			c = this.struct2interleavedCell(s);
			setParameters@redux.Component.Layout(this, c{:});
		end
	end
	
	methods (Access = protected)
		function [] = construct(this, parent)
			p = redux.InputParser;
			p.addParent();
			parse(p, parent);
			
% 			this.handle = uiextras.Panel( ...
% 				'Parent', p.Results.parent.handle ...
% 			);
			if redux.Config.isOldMatlabVersion()
				this.handle = uiextras.CardPanel( ...
					'Parent', p.Results.parent.handle ...
				);
			else
				this.handle = uix.CardPanel( ...
					'Parent', p.Results.parent.handle ...
				);
			end
		end
	end
end

