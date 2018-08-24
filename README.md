# ONS method

This repository contains some Julia implementations for ONS method and others methods for LOVO functions.
Our intent is to show a new model which is based on LOVO functions introduced in [1,2] and [3]. This model is 
called ONS (Ordered Nonlinear Systems) and requires some attention with differentiabilty of involved functions. 

By this reason, we developed the **ONS method** which is an adaptation of Newton 
Method in order to solve ONS models. We follow the same spirit of LOVO methods for approximate some 
derivatives functions. 

Shape detection is a potential application of ONS models. Consequently, we explore our implementation 
for this purpose. To show how promising is this model/method, we compare our implementation with others.
For the tests we consider images artificially generated simulating noisy and cluster efects.
All problems are located in ```examples``` folder. Still in this folder we have two files: ```sygen.jl``` and 
```clugen.jl```. These files are responsible to create the examples. The other files make up the dataset that we 
have tested.

In main directory, we have:  
- ```ons.jl```- is an implementation of ONS method;  
- ```ons_benchmarks.jl``` - is an implementation to make benchmarks of ONS method using the dataset given in ```examples``` folder;  
- ```gn.jl```- is an implementation of and adaptation of Gauss-Newton method to solve LOVO functions, see [3];
- ```gn_benchmarks.jl```- is an implementation to make benchmarks of GN method using the dataset given in ```examples``` folder;
- ```nm.jl```- is an implementation to solve LOVO function by Nelder-Mead algorithm. The implementation of Nelder-Mead (NM) algorithm used here, is part of the package [Optim.jl](https://github.com/JuliaNLSolvers/Optim.jl). 
- ```nm_benchmarks.jl```- is an implementation to make benchmarks of NM tested, using the dataset given in ```examples``` folder;
- ```ps.jl```- is an implementation to solve LOVO function by pattern Swarm algorithm. The implementation of pattern Swarm (PS) algorithm used here, is part of the package [Optim.jl](https://github.com/JuliaNLSolvers/Optim.jl). 
 - ```ps_benchmarks.jl```- is an implementation to make benchmarks of PS method tested, using the dataset given in ```examples``` folder;

Both GN and ONS has some derivatives involved and they were solved by [ForwardDiff.jl](https://github.com/JuliaDiff/ForwardDiff.jl) package.

## Basic use
First of all, it is necessary install [Julia Language](https://julialang.org/) version 0.6 (not supported in version 1.0).
Some packages are necessary, like:
- [Optim.jl ]((https://github.com/JuliaNLSolvers/Optim.jl))
- [ForwardDiff.jl](https://github.com/JuliaNLSolvers/Optim.jl)
- [BenchmarkTools.jl](https://github.com/JuliaCI/BenchmarkTools.jl)

To install these packages, just type in Julia REPL 
```Pkg.add("name of package")```.

Finally, clone this directory to your computer.


### ONS

To run pure ONS in some random example, you need:  
- model = the input model  
- data =  the dataset  
- n = number of variables in the model  
- p = trusted points  
- ε = precision

Then, just type in Julia REPL:
```ONSNewton(model,data,n,p,ε)```

For example,

```
function model(x,t)
    return (t[1]-x[1])^2+(t[2]-x[2])^2-x[3]^2
end

A=readdlm("examples/datafile-50-300-200-30.dat");

solution,count,valsolution=ONSNewton(model,A,3,50,0.25)
```

### Benchmarks
Let us suppose that Julia REPL was initiated in ONSmethod directory. So, to test the benchmark you just need to type

```include("ons_benckmarks.jl")```

This could be take a while. When Julia finishes, file called ```results_ons.txt``` will be created. This file contains the output of all tests related to ONS method. 

The same idea is used to test the other methods. For example, to test GN method, just type

```include("gn_benckmarks.jl")```
After running all benchmarks, if you to see the perfomance table of all methods together, just type

```include("plots_benckmarks.jl")```

## Developed by

- Emerson Vitor Castelani
- Wesley Vagner Inês Shirabayashi
- Jesus Marcos de Camargo
- André L. M. Martinez
- Jair da Silva




