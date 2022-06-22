using Test
using BMesh
using LinearAlgebra

# Method 2D
include("test_b2D.jl")

# Method 3D
include("test_b3D.jl")

# Base (truss 2D)
include("test_base_truss2D.jl")

# Base (truss 3D)
include("test_base_truss3D.jl")

# 2D Rotations
include("test_rotation2D.jl")

# 3D Rotations
include("test_rotation3D.jl")
