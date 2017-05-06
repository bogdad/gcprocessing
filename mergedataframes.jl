Pkg.add("DataFrames")
Pkg.add("DataFramesMeta")
Pkg.add("JLD")

using DataFrames
using DataFramesMeta
using JLD

function host(fullfilename)
    _, filename = splitdir(fullfilename)
    hen = rsplit(split(filename, ".")[1], "-")[end]
    pod = split(filename, ".")[2]
    "$hen.$pod"
end

function dframe(fullfilename)
    df = DataFrames.readtable(fullfilename, separator = ',', header = true)
    df[:Host] = host(fullfilename)
    dfWithTime = @transform(df, Time = Dates.unix2datetime(:Timestamp_unix_))
    dfWithTime
end

function dfRing()
    df = DataFrames.readtable("./notebook/ring.csv", header = false)
    df = @transform(df, Host = :x1, Token = :x8)
    @select(df, :Host, :Token)
end

function readalltoone(dir) 
    overAll=DataFrames.DataFrame()
    dfR = dfRing()
    for file = readdir(dir)
        println(file) # path to files
        df = join(dframe("$dir/$file"), dfR, on = :Host) 
        overAll = [overAll; df]
    end
    overAll    
end

new = readalltoone("./new_csv")
writetable("output_new.csv", new)

old = readalltoone("./old_csv")
writetable("output_old.csv", old)