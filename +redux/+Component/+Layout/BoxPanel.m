classdef BoxPanel < redux.Component.Layout & redux.Action.Dispatcher & redux.State.Listener
	properties
		oldParent
	end
	
	methods
		function this = BoxPanel(parent, varargin)
			this@redux.Component.Layout(parent, varargin{:});
			
			this.setCallback('DockFcn');
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
				
				% Change Docked to isDocked
				nameToChange = 'Docked';
				nameReplacement = 'isDocked';
				s = this.renameField(s, nameToChange, nameReplacement);
			end
			
			c = this.struct2interleavedCell(s);
			setParameters@redux.Component.Layout(this, c{:});
		end
		
		function value = getParameter(this, param)
			p = redux.InputParser;
			p.addRequired('param', @ischar);
			parse(p, param);
			
			if redux.Config.isOldMatlabVersion()
				switch param
					case 'Contents'
						param = 'Children';
					case 'Docked'
						param = 'isDocked';
					otherwise
						% do nothing
				end
			end
			
			value = getParameter@redux.Component.Layout(this, param);
		end
		
		function [] = onVideoIsDockedChange(this, state)
			this.setParameters('Docked', state.videoIsDocked);
			if state.videoIsDocked
				% State wants you to be docked, so re-dock
				
				% Get the handle of the undocked window
				newFig = this.getParameter('Parent');
				
				if isvalid(this.oldParent)
					% Move this BoxPanel back to where it was before
					this.setParameters('Parent', this.oldParent);

					newOrder = [2 1];
					if redux.Config.isOldMatlabVersion()
						contents = this.oldParent.Children;
						this.oldParent.Children = contents(newOrder);
					else
						contents = this.oldParent.Contents;
						this.oldParent.Contents = contents(newOrder);
					end
				end
				
				% Delete the undocked window
				delete(newFig);
			else
				% State wants you to be undocked, so pop out
				
				% Save the old parent so you can come back
				this.oldParent = this.getParameter('Parent');
				
				% get position of the BoxPanel
				% this.handle should be the main window handle instead?
				pos = getpixelposition(this.handle);

				% Create a new undocked window
				newFig = redux.Component.Window.Undocked( ...
					this.getParameter('Title'), ...
					this.actionFactory ...
				);

				% Set the position of the undocked window
				figpos = newFig.getParameter('Position');
				newFig.setParameters( ...
					'Position', [figpos(1,1:2), pos(1,3:4)] ...
				);
				
				% Move the contents of this BoxPanel to the undocked window
				% Documentation suggests that you should set:
				%   'Position', [0 0 1 1] ...
				% ...but it only causes problems for me.
				this.setParameters( ...
					'Parent', newFig.handle, ...
					'Units', 'Normalized' ...
				);
			end
		end
		
		function [] = dispatchAction(this, ~, ~)
			action = this.actionFactory.actions.TOGGLE_DOCK;
			action.prepare();
			action.dispatch();
		end
	end
	
	methods (Access = protected)
		function [] = construct(this, parent)
			p = redux.InputParser;
			p.addParent();
			parse(p, parent);
			
			if redux.Config.isOldMatlabVersion()
				this.handle = uiextras.BoxPanel( ...
					'Parent', p.Results.parent.handle ...
				);
			else
				this.handle = uix.BoxPanel( ...
					'Parent', p.Results.parent.handle ...
				);
			end
		end
	end
end