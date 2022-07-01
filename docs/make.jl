push!(LOAD_PATH,"../src/")
include("BMesh.jl")
using .BMesh
using Documenter

makedocs(
         sitename = "BMesh",
         modules  = [BMesh],
         pages=[
                "Home" => "index.md"
               ])
               
deploydocs(;
    versions = nothing,
    repo="github.com/CodeLenz/BMesh.jl",
)
