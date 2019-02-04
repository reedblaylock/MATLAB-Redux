classdef VButtonGroup < redux.Component.Layout
	methods
		function this = VButtonGroup(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
		end
	end
	
	methods (Access = protected)
		function [] = construct(this, parent)
			p = redux.InputParser;
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout.VButtonGroup'));
			p.addParent();
			parse(p, this, parent);
			
			this.handle = uix2.VButtonGroup( ...
				'Parent', parent.handle ...
			);
		end
	end
	
end

