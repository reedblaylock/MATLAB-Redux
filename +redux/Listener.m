classdef (Abstract) Listener < redux.Root
	methods
		function method = action2method(this, underscore_action)
			p = redux.InputParser;
			p.addRequired('underscore_action', @ischar);
			p.parse(underscore_action);
			
			method = this.underscore2camelCase(lower(p.Results.underscore_action));
		end
		
		function ccStr = underscore2camelCase(~, us_str)
			ccStr = regexprep(us_str, '_+(\w?)', '${upper($1)}');
		end
		
		function [] = register(this, action)
			p = redux.InputParser;
			p.addRequired('this', @(this) isa(this, 'redux.Listener'));
			p.addRequired('action', @(action) isa(action, 'redux.Action'));
			p.parse(this, action);
			
			actionName = p.Results.action.getName();
			method = this.action2method(actionName);
			if (this.isMethod(method));
				addlistener( ...
					p.Results.action, ...
					actionName, ...
					@(source, eventdata) this.(method)(source, eventdata)...
				);
			end
		end
		
		function b = isMethod(this, methodName)
			p = redux.InputParser;
			p.addRequired('this', @(this) isa(this, 'redux.Listener'));
			p.addRequired('methodName', @ischar);
			p.parse(this, methodName);
			
			methodList = methods(p.Results.this);
			b = ismember(p.Results.methodName, methodList);
		end
	end
	
end

