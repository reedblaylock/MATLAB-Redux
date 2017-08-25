classdef VBoxFlex < vt.Component.Layout
	methods
		function this = VBoxFlex(parent, varargin)
			this@vt.Component.Layout(parent, varargin{:});
		end
		
		function [] = setParameters(this, varargin)
			p = vt.InputParser;
			p.KeepUnmatched = true;
			p.addRequired('this', @(this) isa(this, 'vt.Component.Layout'));
			parse(p, this, varargin{:});
			
			params = fieldnames(p.Unmatched);
			
			if( this.isOldMatlabVersion() )
				% Change Widths to Sizes
				nameToChange = 'Heights';
				nameReplacement = 'Sizes';
				if( find(ismember(params, nameToChange)) )
					[p.Unmatched.(nameReplacement)] = p.Unmatched.(nameToChange);
					p.Unmatched = rmfield(p.Unmatched, nameToChange);
				end
				
				% Change MinimumWidths to MinimumSizes
				nameToChange = 'MinimumHeights';
				nameReplacement = 'MinimumSizes';
				if( find(ismember(params, nameToChange)) )
					[p.Unmatched.(nameReplacement)] = p.Unmatched.(nameToChange);
					p.Unmatched = rmfield(p.Unmatched, nameToChange);
				end
				
				% Change Contents to Children
				nameToChange = 'Contents';
				nameReplacement = 'Children';
				if( find(ismember(params, nameToChange)) )
					[p.Unmatched.(nameReplacement)] = p.Unmatched.(nameToChange);
					p.Unmatched = rmfield(p.Unmatched, nameToChange);
				end
			end

			setParameters@vt.Component.Layout(this, p.Unmatched(:));
		end
	end
	
	methods (Access = protected)
		function [] = construct(this, parent)
			p = vt.InputParser;
			p.addRequired('this', @(this) isa(this, 'vt.Component.Layout.VBoxFlex'));
			p.addParent();
			parse(p, this, parent);
			
			this.handle = uiextras.VBoxFlex( ...
				'Parent', parent.handle ...
			);
% 			if ( this.isOldMatlabVersion() )
% 				this.handle = guilayouttoolbox.old.layout.uiextras.VBoxFlex( ...
% 					'Parent', parent.handle ...
% 				);
% 			else
% 				this.handle = guilayouttoolbox.new.layout.uix.VBoxFlex( ...
% 					'Parent', parent.handle ...
% 				);
% 			end
		end
	end
	
end

