% redux.Action.Dispatcher is an abstract class that has a redux.Action.Factory
% property. Any subclass of redux.Action.Dispatcher can access the
% redux.Action.Factory to get access to pre-registered redux.Actions.
classdef (Abstract) Dispatcher < redux.Root
	properties
		actionFactory
	end
	
	methods
		function [] = dispatchAction()
			this.action.dispatch();
		end
	end
end

