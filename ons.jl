#Ordered Nonlinear (Inequality) Systems 

#dependencies
using ForwardDiff

function ONSNewton(model::Function,data::Array{Float64,2},n::Int,p::Int,ε::Float64)
    # model = the input model 
    # data =  the dataset 
    # n = number of variables in the model
    # p = trusted points

    #defining closures for derivative and initializations
    model_cl(x)=model(x,t)
    grad_model_cl(x)=ForwardDiff.gradient(model_cl, x)
    t=zeros(2)
    npun=length(data[:,1])
    #All evaluated instance depends of a sort function 
    SortFun(V::Vector)=begin
        Vc=copy(V)
        aux=0
        vaux=0.0
        ind=[1:1:npun;]
        out=Array{Vector,1}(n)
        for i=1:p
            for j=i+1:npun
                if (Vc[i]>Vc[j])
                    aux=ind[j]
                    ind[j]=ind[i]
                    ind[i]=aux
                    vaux=Vc[j]
                    Vc[j]=Vc[i]
                    Vc[i]=vaux
                end
            end
        end
        for i=1:n
            out[i]=ind[i:n:p]
        end
        return out
    end
    
    #main functions
    ONSFun(x)=begin #return a ordered set index and ons value 
        F=zeros(npun)
        for i=1:npun 
            F[i]=(model(x,data[i,:]))^2
        end
        vSort=SortFun(F)
        vFun=zeros(n)
        Fun=0.0
        for i=1:n
            vFun[i]=sum(F[vSort[i]])
            #Fun=max(Fun,norm(F[vSort[i]],Inf))
        end
        return vSort,vFun
    end

    ONSJac(x,vind)=begin #return the residue and Jacobian of residue 
        Jac=zeros(n,n)
        for k=1:n 
            for i in vind[k]
                t=data[i,:]
                Jac[k,:]=2.0*(model(x,data[i,:]))*grad_model_cl(x)+Jac[k,:]
            end
        end
        return Jac 
    end
    
    #ONS-Newton algorithm
    I=eye(n)
    x=zeros(n) #initial point
    xbest=zeros(n)
    d=10.0*ones(n)
    (ind_ons,val_ons)=ONSFun(x)
    count=1
    valbest=copy(norm(val_ons,Inf))
    while norm(d,Inf)>ε && count<2000
        jac_ons=ONSJac(x,ind_ons)
        ad=try
            d=jac_ons\(-val_ons)
        catch
            "error"
        end
        if ad=="error" #restarting if lapack fails
            d=-val_ons 
        else 
            d=ad
        end
        x=x+d
        (ind_ons,val_ons)=ONSFun(x)
        nr_ons=norm(val_ons,Inf)
        if valbest>nr_ons
            xbest=copy(x)
            valbest=copy(nr_ons)
        end
        count+=1
    end
   return xbest, count,valbest
end





