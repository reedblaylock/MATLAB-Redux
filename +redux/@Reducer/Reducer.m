classdef Reducer < redux.Listener & redux.State.Setter
	% This is where all your reducers go.
	% Actions are dispatched by emitting events from various classes. Those
	% action-events are registered here in the Reducer. Each action-event
	% gets its own reducer.
	
	properties
		stateObj
		packageName
	end
	
	methods
		% Constructor function. Receives a redux.State object.
		function this = Reducer(stateObj, packageName)
			this.stateObj = stateObj;
			this.packageName = packageName;
			this.reduce();
		end
		
		function [] = register(this, actionObj)
			p = inputParser;
			addRequired(p, 'action', @(action) isa(action, 'redux.Action'));
			parse(p, actionObj);
			
			actionName = p.Results.action.getName();
			try
				addlistener( ...
					p.Results.action, ...
					actionName, ...
					@(source, eventData) this.reduce(source, eventData)...
				);
			catch excp
				this.log.exception(excp);
				% TODO: stop executing
			end
		end
		
		% The main reduce function. Calls all the other reduce functions in this
		% class (by calling some from within others).
		function [] = reduce(this, ~, varargin)
			p = inputParser;
			addOptional(p, 'eventData', struct(), @(eventData) isa(eventData, 'redux.EventData'));
			p.StructExpand = false;
			parse(p, varargin{:});
			
			oldState = this.stateObj.state;
			newState = struct();
			
			reducerFcns = this.getReducerFcns();
			
			for fcnidx = 1:numel(reducerFcns)
				method = reducerFcns{fcnidx};
				methodStr = method{1};
				methodFcn = method{2};
				try
					%assert(this.isMethod(method)); % Reducer functions aren't
					%part of the Reducer class, so they'll all fail isMethod()
					if numel(fieldnames(p.Results.eventData))
						actionData = p.Results.eventData.data;
						newState.(methodStr) = methodFcn(oldState.(methodStr), actionData);
					else
						newState.(methodStr) = methodFcn();
					end
					
				catch excp
					this.log.exception(excp);
					% TODO: stop executing
				end
			end
			
			this.stateObj.state = newState;
		end
		
		function reducerFcns = getReducerFcns(this)
			packageFcns = meta.package.fromName([this.packageName '.Reducer']);
			nFuncs = numel(packageFcns.FunctionList);
			reducerFcns = cell(nFuncs, 1);
			for iFunc = 1:nFuncs
				reducerFcns{iFunc} = { ...
					packageFcns.FunctionList(iFunc).Name, ...
					str2func([this.packageName '.Reducer.' packageFcns.FunctionList(iFunc).Name]) ...
				};
			end
		end
	end
	
end

