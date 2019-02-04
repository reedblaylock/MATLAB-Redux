classdef TabPanel < redux.Component.Layout
	methods
		function this = TabPanel(parent, varargin)
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
				nameToChange = 'TabWidth';
				nameReplacement = 'TabSize';
				s = this.renameField(s, nameToChange, nameReplacement);
                
                % Change TabEnables to TabEnable
				nameToChange = 'TabEnables';
				nameReplacement = 'TabEnable';
				s = this.renameField(s, nameToChange, nameReplacement);
                
                % Change Contents to Children
				nameToChange = 'Contents';
				nameReplacement = 'Children';
				s = this.renameField(s, nameToChange, nameReplacement);
                
                % Change TabTitles to TabNames
				nameToChange = 'TabTitles';
				nameReplacement = 'TabNames';
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
			p.addRequired('this', @(this) isa(this, 'redux.Component.Layout.TabPanel'));
			p.addParent();
			parse(p, this, parent);
			
% 			this.handle = uiextras.TabPanel( ...
% 				'Parent', p.Results.parent.handle ...
% 			);
			if redux.Config.isOldMatlabVersion()
				this.handle = uiextras.TabPanel( ...
					'Parent', p.Results.parent.handle ...
				);
			else
				this.handle = uix.TabPanel( ...
					'Parent', p.Results.parent.handle ...
				);
			end
		end
	end
end

