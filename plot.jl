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

df = DataFrames.readtable(fullfilename, separator = ',', header = true)

x = randn(500)
data = [
  [
    "x" => df,
    "type" => "histogram"
  ]
]
response = PlotlyJS.plot(data, ["filename" => "basic-histogram", "fileopt" => "overwrite"])
plot_url = response["url"]


plotlyjs()
StatPlots.scatter(df[(df[:Pause_sec_].>2),:], :Timestamp_unix_, :Pause_sec_, group=:Host,
               title = "GC Pause",
               xlabel = "time", ylabel = "Pause",
               m=(0.5, [:cross :hex :star7], 12),
               bg=RGB(.2,.2,.2))
