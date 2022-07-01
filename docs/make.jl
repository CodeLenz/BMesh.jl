#push!(LOAD_PATH,"../src/")
using BMesh
using Documenter

makedocs(
         sitename = "BMesh.jl",
         modules  = [BMesh],
         pages=[
                "Home" => "index.md"
               ])
               
deploydocs(;
    versions = nothing,
    repo="github.com/CodeLenz/BMesh.jl",
)
