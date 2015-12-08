function openfiles(Files_start, Files_end, Fileset, script)
    for file = Files_start:Files_end
        filename = Fileset{file};
        load(filename);
        
        run(script);
    end
end