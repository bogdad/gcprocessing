Pkg.add("DataFrames")
Pkg.add("JLD")

using DataFrames
using JLD

function host(fullfilename)
    _, filename = splitdir(fullfilename)
    rsplit(split(filename, ".")[1], "-")[end]
end

function frame(fullfilename)
    df = DataFrames.readtable(fullfilename, separator = ',', header = true)
    df[:Host] = host(fullfilename)
    df
end

function readalltoone(dir) 
    overAll=DataFrames.DataFrame()
    for file = readdir(dir)
        println(file) # path to files
        df = frame("$dir/$file")
        overAll = [overAll; df]
    end
    overAll    
end

new = readalltoone("./new_csv")
writetable("output_new.csv", new)
