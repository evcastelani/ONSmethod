#LOVO model solved by Nelder-Mead method

#dependencies
using Optim

function NMlovo(model::Function,data::Array{Float64,2},n::Int,p::Int)
    # model = the input model 
    # data =  the dataset 
    # n = number of variables in the model
    # p = trusted points

    #defining closures for derivative and initializations
    model_cl(x)=model(x,t)

    npun=length(data[:,1])
    
    #All evaluated instance depends of a sort function 
    SortFun(Vet::Vector)=begin
        V=copy(Vet)
        aux=0
        vaux=0.0
        ind=[1:1:npun;]
        for i=1:p
            for j=i+1:npun
                if (V[i]>V[j])
                    aux=ind[j]
                    ind[j]=ind[i]
                    ind[i]=aux
                    vaux=V[j]
                    V[j]=V[i]
                    V[i]=vaux
                end
            end
        end
        return ind[1:1:p]
    end
    
    #main functions
    LovoFun(x)=begin #return a ordered set index and lovo value 
        F=zeros(npun)
        for i=1:npun 
            F[i]=model(x,data[i,:])^2
        end
        return sum(F[SortFun(F)])
    end
    
    
    #Nelder Mead Algorithm
    sol=optimize(LovoFun, zeros(n), NelderMead(),Optim.Options(iterations=1000))
    
    return Optim.minimizer(sol),Optim.iterations(sol),Optim.minimum(sol)
   
end
