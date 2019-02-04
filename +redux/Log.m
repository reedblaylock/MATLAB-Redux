classdef Log < handle
	properties
		filename = 'error.log'
		debugMode
		action
		isOn
	end
	
	methods
		function this = Log(varargin)
			p = redux.InputParser;
			p.addOptional('debugMode', 0, @isnumeric);
			parse(p, varargin{:});
			
			this.debugMode = p.Results.debugMode;
			if(this.debugMode == 2)
				dbstop if error
				dbstop if warning
			end
% 			this.action = redux.Action.NotifyError();
			this.isOn = false;
		end
		
		function [] = on(this)
			diary(this.filename);
			this.isOn = true;
		end
		
		function [] = off(this)
			disp('Turning log off...');
			if(this.debugMode == 2)
				dbclear if error;
			end
			diary off;
			this.isOn = false;
		end
		
		function [] = notifyError(this, exception)
			if(this.isOn)
				this.action.dispatch(exception);
			end
		end
		
		function [] = exception(this, exception)
			p = redux.InputParser;
			p.addRequired('this', @(this) isa(this, 'redux.Log'));
			p.addRequired('exception', @(exception) isa(exception, 'MException'));
			p.parse(this, exception);
			
% 			this.notifyError(exception);
			
			if(this.debugMode)
% 				throwAsCaller(exception);
				throw(exception);
			end
		end
		
		function [] = warning(this, warning)
			exception = MException('customExceptionID', warning);
% 			this.notifyError(exception);
			
			if(this.debugMode)
				throwAsCaller(warning);
			end
		end
	end
	
end

