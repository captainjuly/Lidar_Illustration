classdef ( ConstructOnLoad ) reflectiveObject < handle
    properties
        start_pos
        end_pos
        slope
        theta
        handle
        vec
        center
        length
        angle
        line_color  = 'red'
    end     % 
    
    methods
        function ro  = reflectiveObject( center , length , angle )
            if nargin == 0
                ro.length       = 1                         ;
                ro.angle        = 90 + 25/2                 ;
                ro.center       = [ -5 0 ]                  ;
            else
                ro.center       = center                    ;
                ro.length       = length                    ;
                ro.angle        = angle                     ;
            end
            
            offset          = ro.length * [ cosd( ro.angle ) sind( ro.angle ) ]     ;
            ro.start_pos    = ro.center + offset                                    ;
            ro.end_pos      = ro.center - offset                                    ;
            plot_vecs       = ro.extract_plot_vecs( ro.start_pos , ro.end_pos )     ;
            hold on
            ro.handle       = plot( gca, plot_vecs{ : } ,                           ...
                                    'LineSmoothing' , 'on' ,                        ...
                                    'Color' , ro.line_color )                       ;
            axis equal
            grid on
        end
        
        function p = extract_plot_vecs( varargin )
            p   = cell( nargin-1 , 1 )                                              ;
            for i_input   = 2 : nargin
                for i_components = 1 : numel( varargin{ i_input } )
                    p{ i_components }( i_input-1 )   = varargin{ i_input }( i_components )    ;
                end
            end
        end     % end extract_plot_vecs
    end         % end methods
end             % end class