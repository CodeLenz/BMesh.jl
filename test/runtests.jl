using Test
using BMesh
using LinearAlgebra

# For dispatch analysis
using JET

# Method 2D
include("test_b2D.jl")

# Method 3D
include("test_b3D.jl")

# Mesh generators
include("test_bmesh_truss2d.jl")
include("test_bmesh_truss3d.jl")
include("test_bmesh_solid2d.jl")
include("test_bmesh_solid3d.jl")

# Base (truss 2D)
include("test_base_truss2D.jl")

# Base (truss 3D)
include("test_base_truss3D.jl")

# 2D Rotations
include("test_rotation2D.jl")

# 3D Rotations
include("test_rotation3D.jl")

# Merge
include("test_merge.jl")

# Util
include("test_util.jl")