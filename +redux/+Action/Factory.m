% This class would be a singleton class if I weren't so afraid of MATLAB
% singletons (they've given me some performance/memory/scary problems).

% TODO:
% - move to +redux
% - Add package name (e.g. "+vt") as parameter
% - Give package name as parameter in redux.App()
% - Give Give package name to redux.App() through a Config or something when the
%   GUI starts up
classdef Factory < redux.Root
	properties
		actions
	end
	
	methods
		function this = Factory(reducer, packageName)
			% Instantiate an instance of every redux.Action
% 			[pathToActions, ~, ~] = fileparts(mfilename('fullpath'));
% 			files = dir(pathToActions);
			exclude = {'Dispatcher', 'Factory'};
			
			plusIndex = strfind(packageName, '+');
			if ~isempty(plusIndex) && plusIndex(1) == '+'
				packageName = packageName(2:end);
			end
			this.actions = struct();
			
			actionList = meta.package.fromName([packageName '.Action']);
			
			for iAction = 1:numel(actionList.ClassList)
				actionFcn = str2func(actionList.ClassList(iAction).Name);
				action = actionFcn();
% 				[~, actionName, ~] = fileparts(actionFile);
				
% 				if (exist([packageName '.Action.' actionName], 'class') == 8) && ~sum(strcmp(actionName, exclude))
% 					constructorFcn = str2func([packageName '.Action.' actionName]);
% 					action = constructorFcn();
% 					action = vt.Action.(actionName);
				
				% Register each vt.Action to the reducer
				reducer.register(action);

				% Save each vt.Action to the structure this.actions
				this.actions.(action.getName()) = action;
% 				end
			end
		end
		
		function action = get(actionName)
			action = this.actions.(actionName);
		end
	end
end