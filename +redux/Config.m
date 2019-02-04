classdef Config < redux.Root
	properties
		
	end
	
	methods
		
	end
	
	methods (Static = true)
		function isOld = isOldMatlabVersion()
			persistent tf
			if isempty(tf)
				newVersionDate = '08-Sep-2014';
				matlabVersion = ver( 'MATLAB' );
				tf = datenum( matlabVersion.Date ) < datenum( newVersionDate );
			end
			isOld = tf;
		end
	end
	
end

