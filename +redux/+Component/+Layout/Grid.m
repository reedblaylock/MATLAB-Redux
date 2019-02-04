classdef Grid < redux.Component.Layout
	methods
		function this = Grid(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
		end
		
		% perfunctory comment
		function [] = setParameters(this, varargin)
			p = redux.InputParser;
			p.KeepUnmatched = true;
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout'));
			parse(p, this, varargin{:});
			
			s = p.Unmatched;
			
			if redux.Config.isOldMatlabVersion()
				% Change Widths to Sizes
				nameToChange = 'Widths';
				nameReplacement = 'ColumnSizes';
				s = this.renameField(s, nameToChange, nameReplacement);
				
				% Change MinimumWidths to MinimumSizes
				nameToChange = 'Heights';
				nameReplacement = 'RowSizes';
				s = this.renameField(s, nameToChange, nameReplacement);
				
				% Change Contents to Children
				nameToChange = 'Contents';
				nameReplacement = 'Children';
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
			
% 			this.handle = uiextras.Grid( ...
% 				'Parent', p.Results.parent.handle ...
% 			);
			if redux.Config.isOldMatlabVersion()
				this.handle = uiextras.Grid( ...
					'Parent', p.Results.parent.handle ...
				);
			else
				this.handle = uix.Grid( ...
					'Parent', p.Results.parent.handle ...
				);
			end
		end
	end
end

