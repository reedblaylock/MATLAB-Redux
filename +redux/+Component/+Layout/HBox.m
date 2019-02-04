classdef HBox < redux.Component.Layout
	methods
		% It seems like I should be able to get away without a constructor here,
		% but MATLAB doesn't seem to like it. Maybe it has something to do with
		% varargin?
		function this = HBox(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
		end
		
		function [] = setParameters(this, varargin)
			p = redux.InputParser;
			p.KeepUnmatched = true;
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout'));
			parse(p, this, varargin{:});
			
			s = p.Unmatched;
			
			if redux.Config.isOldMatlabVersion()
				% Change Widths to Sizes
				nameToChange = 'Widths';
				nameReplacement = 'Sizes';
				s = this.renameField(s, nameToChange, nameReplacement);
				
				% Change MinimumWidths to MinimumSizes
				nameToChange = 'MinimumWidths';
				nameReplacement = 'MinimumSizes';
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
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout.HBox'));
			p.addParent();
			parse(p, this, parent);
			
% 			this.handle = uiextras.HBox( ...
% 				'Parent', parent.handle ...
% 			);
			if redux.Config.isOldMatlabVersion()
				this.handle = uiextras.HBox( ...
					'Parent', parent.handle ...
				);
			else
				this.handle = uix.HBox( ...
					'Parent', parent.handle ...
				);
			end
		end
	end
	
end

