classdef Action < redux.Root
	properties
		error
	end
	
	methods (Abstract = true)
		prepare(this)
		% Can be implemented with any number of arguments, as required by the
		% implementing subclass. redux.Action/prepare() takes application data and
		% uses it to set the values of all the action properties. Must be called
		% before redux.Action/dispatch(). Should call redux.Action/validate().
	end
	
	methods
		function [] = dispatch(this)
			actionName = this.getName();
			
			actionData = this.assignPropsToActionData(actionName);
			
			eventData = redux.EventData(actionData);
			
			this.unsetProps();
			
			notify(this, actionName, eventData);
		end
		
		function actionName = getName(this)
			e = events(this);
			actionName = e{1};
			
			if strcmp(actionName, 'ObjectBeingDestroyed')
				actionName = '';
			end
		end
		
		function actionData = assignPropsToActionData(this, actionName)
			actionData = struct();
			actionData.type = actionName;
			
			props = properties(this);
			for iProp = 1:numel(props)
				actionData.(props{iProp}) = this.(props{iProp});
			end
		end
		
		function [] = unsetProps(this)
			props = properties(this);
			for iProp = 1:numel(props)
				this.(props{iProp}) = [];
			end
		end
	end
	
end

