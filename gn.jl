#LOVO model solved by Gauss-Newton method

#is you are using for circle detection set circ=true 
const circ=true

#dependencies
using ForwardDiff

function GNlovo(model::Function,data::Array{Float64,2},n::Int,p::Int)
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
        return SortFun(F),sum(F[SortFun(F)])
    end
    ResFun(x,ind)=begin #return the residue and Jacobian of residue 
        r=zeros(p)
        rJ=zeros(p,n)
        k=1
        for i in ind
            r[k]=model(x,data[i,:])
            t=data[i,:]
            rJ[k,:]=grad_model_cl(x)
            k=k+1
        end
        return r,rJ 
    end
    
    #gauss-newton algorithm
    I=eye(n)
    ε=10.0^(-4)
    if circ #circle detection problem 
        xbest=zeros(n)
        val_best=10.0^(10)
        x=zeros(n) #initial point
        for c1 in [0.0:30:270;]
            for c2 in [0.0:30:270;]
                x[1]=c1
                x[2]=c2
                x[n]=10.0
                d=zeros(n)
                y=zeros(n)
                (ind_lovo,val_lovo)=LovoFun(x)
                (val_res,jac_res)=ResFun(x,ind_lovo)
                grad_lovo=jac_res'*val_res
                safecount=1
                while norm(grad_lovo,2)>=ε && safecount<200
                    G=jac_res'*jac_res     
                    ad=try
                    d=G\(-grad_lovo)
                    catch
                        "error"
                    end
                    if ad=="error" #restarting if lapack fails
                        d=-grad_lovo 
                    #    println("problem")
                    else 
                        d=ad
                    end
                    #d=G\(-grad_lovo)
                    a=1.0
                    xnew=x+a*d
                    (ind_lovo_new,val_lovo_new)=LovoFun(xnew)
                    count_int=1
                    while val_lovo_new>=val_lovo + a*0.1*vecdot(d,grad_lovo) && count_int<10
                        a=a/2.0
                        xnew=x+a*d
                        (ind_lovo_new,val_lovo_new)=LovoFun(xnew)
                        count_int+=1
                    end
                    x=copy(xnew )
                    #println(x)
                    ind_lovo=copy(ind_lovo_new)
                    val_lovo=copy(val_lovo_new)
                    (val_res,jac_res)=ResFun(x,ind_lovo)
                    grad_lovo=jac_res'*val_res
                    safecount+=1
                end
                if val_best<val_lovo 
                    val_best=val_lovo
                    xbest=copy(x)
                end
                if norm(abs.(x)-[101.0,42.0,25.0],Inf)<1.0
                    return x,safecount,val_lovo
                end
            end 
        end    
            return x,safecount,val_lovo
    else
        x=zeros(n) #initial point
        x[n]=10.0
        d=zeros(n)
        y=zeros(n)
        (ind_lovo,val_lovo)=LovoFun(x)
        (val_res,jac_res)=ResFun(x,ind_lovo)
        grad_lovo=jac_res'*val_res
        safecount=1
        while norm(grad_lovo,2)>=ε && safecount<200
            G=jac_res'*jac_res     
            ad=try
                d=G\(-grad_lovo)
            catch
                "error"
            end
            if ad=="error" #restarting if lapack fails
                d=-grad_lovo 
                println("problem")
            else 
                d=ad
            end
            #d=G\(-grad_lovo)
            a=1.0
            xnew=x+a*d
            (ind_lovo_new,val_lovo_new)=LovoFun(xnew)
            count_int=1
            while val_lovo_new>=val_lovo + a*0.1*vecdot(d,grad_lovo) && count_int<10
                a=a/2.0
                xnew=x+a*d
                (ind_lovo_new,val_lovo_new)=LovoFun(xnew)
                count_int+=1
            end
            x=copy(xnew )
            #println(x)
            ind_lovo=copy(ind_lovo_new)
            val_lovo=copy(val_lovo_new)
            (val_res,jac_res)=ResFun(x,ind_lovo)
            grad_lovo=jac_res'*val_res
            safecount+=1
        end

            return x,safecount,val_lovo
    end
   
end
