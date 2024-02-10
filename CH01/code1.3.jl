using CSV, DataFrames
using LinearAlgebra

A = CSV.read("data/hald_ingredients.csv", DataFrame, header = false) |> Matrix
b = CSV.read("data/hald_heat.csv", DataFrame, header = false) |> Matrix

U, S, V = svd(A)
x = V*inv(Diagonal(S))*U'*b

# Figure 1.10
plot(
    b, 
    label = "Heat Data",
    linecolor = :black,
    linewidth = 3,
)

plot!(
    A*x,
    label = "Regression",
    linecolor = :red,
    linewidth = 3,
    linestyle = :dash,
)