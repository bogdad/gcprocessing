using DataFrames
using DataFramesMeta
using JLD

function host(fullfilename)
    _, filename = splitdir(fullfilename)
    splitted = rsplit(split(filename, ".")[1], "-")
    if length(splitted) == 4
        l3 = splitted[3]
        l4 = splitted[4]
        hen = "$l3-$l4"
    else
        hen = splitted[end]
    end
    pod = split(filename, ".")[2]
    ("$hen.$pod", pod)
end

function dframe(fullfilename)
    df = DataFrames.readtable(fullfilename, separator = ',', header = true)
    df[:Host], df[:Pod] = host(fullfilename)
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


# usage julia -- mergedataframes.jl FROM TO

print(map(x->string(x, x), ARGS))
df = readalltoone(ARGS[1])
writetable(ARGS[2], df)