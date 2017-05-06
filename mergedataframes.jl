Pkg.add("DataFrames")
Pkg.add("DataFramesMeta")
Pkg.add("JLD")

using DataFrames
using DataFramesMeta
using JLD

function host(fullfilename)
    _, filename = splitdir(fullfilename)
    rsplit(split(filename, ".")[1], "-")[end]
end

function dframe(fullfilename)
    df = DataFrames.readtable(fullfilename, separator = ',', header = true)
    df[:Host] = host(fullfilename)
    dfWithTime = @transform(df, Time = Dates.unix2datetime(:Timestamp_unix_))
    dfWithTime
end

function readalltoone(dir) 
    overAll=DataFrames.DataFrame()
    for file = readdir(dir)
        println(file) # path to files
        df = dframe("$dir/$file")
        overAll = [overAll; df]
    end
    overAll    
end

new = readalltoone("./new_csv")
writetable("output_new.csv", new)

old = readalltoone("./old_csv")
writetable("output_old.csv", old)