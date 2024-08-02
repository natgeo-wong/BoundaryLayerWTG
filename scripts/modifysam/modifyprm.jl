using DrWatson
@quickactivate "DrivenEquilibriumTests"
using Logging
using Printf

include(srcdir("common.jl"))
include(srcdir("sam.jl"))

expname = "DE2019Advection"
# expname = "FullSubsidence"
radname = "P"

wlsvec = vcat(-1:0.05:0,0:0.1:5); wlsvec = wlsvec[.!iszero.(wlsvec)]
oprm = rundir("prmtemplates","$(radname).prm")

for wls in wlsvec

    runname = wlsname(wls)

    folname = prmdir(expname,radname); mkpath(folname)
    open(joinpath(folname,"$(runname).prm"),"w") do fprm
        open(oprm,"r") do rprm
            s = read(rprm,String)
            s = replace(s,"[expname]" => expname)
            s = replace(s,"[runname]" => runname)
            s = replace(s,"[doDE]" => "true")
            s = replace(s,"[wmax]" => @sprintf("%5e",wls*1.e-2))
            write(fprm,s)
        end
    end
    @info "Creating new prm file for $expname $radname $runname"

end
