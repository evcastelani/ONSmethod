#benchmarks for ons

#method 
include("gn.jl")

using BenchmarkTools

#model
function model(x,t)
    return (t[1]-x[1])^2+(t[2]-x[2])^2-x[3]^2
end


#right solution
sol=[101.0,42.0,25.0] 

#list1 is used for p=25
list1=["datafile-50-300-30-10.dat",
"datafile-50-300-30-20.dat",
"datafile-50-300-30-30.dat",
"datafile-50-300-30-50.dat",
"datafile-50-300-100-10.dat",
"datafile-50-300-100-20.dat",
"datafile-50-300-100-30.dat",
"datafile-50-300-100-40.dat",
"datafile-50-300-100-50.dat",
"datafile-50-300-200-10.dat",
"datafile-50-300-200-20.dat",
"datafile-50-300-200-30.dat",
"datafile-50-300-200-40.dat",
"datafile-50-300-200-50.dat",
"datafile-50-300-300-10.dat",
"datafile-50-300-300-20.dat",
"datafile-50-300-300-30.dat",
"datafile-50-300-300-40.dat",
"datafile-50-300-300-50.dat",
"clustering-50-300-30-1.dat",
"clustering-50-300-30-2.dat",
"clustering-50-300-30-3.dat",
"clustering-50-300-30-4.dat",
"clustering-50-300-30-5.dat",
"clustering-50-300-30-6.dat",
"clustering-50-300-30-7.dat",
"clustering-50-300-30-8.dat",
"clustering-50-300-30-9.dat",
"clustering-50-300-30-10.dat",
];
f=open("results_gnlovo.txt","w")
for prob in list1
    global A=readdlm("examples/$(prob)");
    xsol,countsol,valsol=GNlovo(model,A,3,25)
    println(f,prob)
    println(f,norm(abs.(xsol)-sol,Inf), "  ", countsol, "  ",valsol)
    b= @benchmark GNlovo(model,A,3,25)
    println(f,(10.0^(-9))*median(b).time," s  ",(10.0^(-6))*(median(b).memory/1024)," Mb ")
    println(f,"**********************************************")
end

list2=["datafile-100-300-300-10.dat",
"datafile-100-300-300-20.dat",
"datafile-100-300-300-30.dat",
"datafile-100-300-300-40.dat",
"datafile-100-300-300-50.dat",
"datafile-100-300-300-60.dat",
"datafile-100-300-300-70.dat",
"datafile-100-300-300-80.dat",
"datafile-100-300-300-90.dat",
"datafile-100-300-300-100.dat",
"clustering-100-300-30-5.dat",
"clustering-100-300-30-10.dat",
"clustering-100-300-30-15.dat",
"clustering-100-300-30-20.dat",
"clustering-100-300-50-20.dat"];

for prob in list2
    global A=readdlm("examples/$(prob)");
    xsol,countsol,valsol=GNlovo(model,A,3,50)
    println(f,prob)
    println(f,norm(abs.(xsol)-sol,Inf), "  ", countsol, "  ",valsol)
    b= @benchmark GNlovo(model,A,3,50)
    println(f,(10.0^(-9))*median(b).time," s  ",(10.0^(-6))*(median(b).memory/1024)," Mb ")
    println(f,"**********************************************")
end

close(f)


