%% This file reads in simulation results, and then do something about it.
%  script can be ... 
%       ErrFunct.m
%       save_figures.m

function open_run(Files_start, Files_end, Fileset, script)              % Fileset is a cell.
    for file = Files_start:Files_end
        filename = Fileset{file};
        load(filename);
        
        run(script);
    end
end