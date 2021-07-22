function newState = appError(varargin)
	p = inputParser;
	addOptional(p, 'oldState', []);
	addOptional(p, 'action', struct('type', '', 'error', []));
	p.StructExpand = false;
	parse(p, varargin{:});

	switch(p.Results.action.type)
		case 'RESET_ERROR'
			newState = [];
		otherwise
			newState = p.Results.action.error;
	end
end