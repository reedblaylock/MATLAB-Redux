classdef HButtonGroup < redux.Component.Layout
	methods
		function this = HButtonGroup(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
		end
	end
	
	methods (Access = protected)
		function [] = construct(this, parent)
			p = redux.InputParser;
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout.HButtonGroup'));
			p.addParent();
			parse(p, this, parent);
			
			this.handle = uix2.HButtonGroup( ...
				'Parent', parent.handle ...
			);
		end
	end
	
end

