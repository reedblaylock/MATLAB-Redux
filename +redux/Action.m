classdef Action < redux.Root
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
			
			actionData = struct();
			actionData.type = actionName;
			
			props = properties(this);
			for iProp = 1:numel(props)
				actionData.(props{iProp}) = this.(props{iProp});
			end
			
			eventData = redux.EventData(actionData);
			
			this.unsetProps();
			
			notify(this, actionName, eventData);
		end
		
		function actionName = getName(this)
			e = events(this);
			actionName = e{1};
			try
				assert(~strcmp(actionName, 'ObjectBeingDestroyed'))
				% Error: this class does not have an action specified
			catch excp
				% TODO: this will probably throw an error, because this.log does
				% not exist
				this.log.exception(excp);
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

