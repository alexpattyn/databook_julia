using Distributions, LinearAlgebra
using Plots

x = 3
a = collect(-2:0.25:2)
η = Normal(0,1)

b = a*x + rand(η,length(a))

U, S, V = svd(a)
x̂ = V*inv(Diagonal(S))*U'*b

# Figure 1.9
plot(
    a,
    a*x,
    label = "True Line",
    xlabel = "a",
    ylabel = "b",
    linecolor = :black,
    linewidth = 3,
)

scatter!(
    a,
    b,
    markercolor = :blue,
    markershape = :cross,
    markersize = 5,
    label = "Noisy Data"
)

plot!(
    a,
    x̂.*a,
    label = "Regression Line",
    linecolor = :red,
    linestyle = :dash,
    linewidth = 3,
)