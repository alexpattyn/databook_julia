using FileIO, ImageCore
using LinearAlgebra
using Plots

A=load("CH01/dog.jpg")
X= @. Gray(A) |> Float64  # Convert RBG to gray, 256 bit to double.
nx, ny = size(X)

U,S,V = svd(X)

plt1 = heatmap(
    X,
    yflip = true,
    aspect_ratio = :equal,
    c = :grays,
    title = "Original",
    showaxis = false,
    colorbar = false,
    grid = false,
)

Xapprox = zeros(3, nx, ny)
rlist = [5 20 100]
for (id, r) = enumerate(rlist)  # Truncation value
    Xapprox[id,:,:] = U[:,1:r]*Diagonal(S)[1:r,1:r]*V[:,1:r]'; # Approx. image
end

plt2 = heatmap(
    Xapprox[1,:,:],
    yflip = true,
    aspect_ratio = :equal,
    c = :grays,
    title = "r=$(rlist[1]) $(round(100*rlist[1]*(nx+ny)/(nx*ny), digits = 2)) % storage",
    showaxis = false,
    colorbar = false,
    grid = false,
)

plt3 = heatmap(
    Xapprox[2,:,:],
    yflip = true,
    aspect_ratio = :equal,
    c = :grays,
    title = "r=$(rlist[2]) $(round(100*rlist[2]*(nx+ny)/(nx*ny), digits = 2)) % storage",
    showaxis = false,
    colorbar = false,
    grid = false,
)

plt4 = heatmap(
    Xapprox[3,:,:],
    yflip = true,
    aspect_ratio = :equal,
    c = :grays,
    title = "r=$(rlist[3]) $(round(100*rlist[3]*(nx+ny)/(nx*ny), digits = 2)) % storage",
    showaxis = false,
    colorbar = false,
    grid = false,
)

# Figure 1.3
plot(plt1, plt2, plt3, plt4)

# Figure 1.4
plot(
    plot(
    S,
    yscale = :log10,
    label = "r",
    ylabel = "Singluar Value, σ r",
    xlims = [-50, 1550],
    linewidth = 1.5
    ),
    plot(
    cumsum(S)./sum(S),
    label = "r",
    ylabel = "Singluar Value, σ r",
    xlims = [-50, 1550],
    ylims = [0, 1.1],
    linewidth = 1.5
    )
)