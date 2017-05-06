Pkg.add("GR")
Pkg.add("PlotlyJS")
Pkg.add("DataFrames")
Pkg.add("JLD")
Pkg.add("StatPlots")
using GR
using PlotlyJS
using StatPlots
using DataFrames
using JLD

plotlyjs()
StatPlots.scatter(df[(df[:Pause_sec_].>2),:], :Timestamp_unix_, :Pause_sec_, group=:Host,
               title = "GC Pause",
               xlabel = "time", ylabel = "Pause",
               m=(0.5, [:cross :hex :star7], 12),
               bg=RGB(.2,.2,.2))
