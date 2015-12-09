%% This file reads in simulation results, and then do something about it.
% script can be ErrFunct.m

function open_run(Files_start, Files_end, Fileset, script)
    for file = Files_start:Files_end
        filename = Fileset{file};
        load(filename);
        
        run(script);
    end
end