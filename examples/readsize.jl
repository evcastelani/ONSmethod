function readsize(names)
   
    output= "size.dat"
    f=open(output,"w")
    for i=1:length(names)
        A=readdlm("$(names[i]).dat", Float64)
        sz=length(A[:,1])
        println(f,"$(names[i])   $(sz)")
    end
    close(f)
 
end

readsize(["datafile-50-300-30-10","datafile-50-300-30-20","datafile-50-300-30-30","datafile-50-300-30-40",
"datafile-50-300-30-50","datafile-50-300-100-10",
"datafile-50-300-100-20","datafile-50-300-100-30",
"datafile-50-300-100-40","datafile-50-300-100-50",
"datafile-50-300-200-10","datafile-50-300-200-20",
"datafile-50-300-200-20","datafile-50-300-200-30",
"datafile-50-300-200-40","datafile-50-300-200-50",
"datafile-50-300-300-10","datafile-50-300-300-20",
"datafile-50-300-300-30","datafile-50-300-300-40",
"datafile-50-300-300-50","datafile-100-300-300-10",
"datafile-100-300-300-20","datafile-100-300-300-30",
"datafile-100-300-300-40","datafile-100-300-300-50",
"datafile-100-300-300-60","datafile-100-300-300-70",
"datafile-100-300-300-80","datafile-100-300-300-90",
"datafile-100-300-300-90","datafile-100-300-300-100",
"clustering-50-300-30-1","clustering-50-300-30-2",
"clustering-50-300-30-3","clustering-50-300-30-4",
"clustering-50-300-30-5","clustering-50-300-30-6",
"clustering-50-300-30-7","clustering-50-300-30-8",
"clustering-50-300-30-9","clustering-50-300-30-10",
"clustering-100-300-30-5","clustering-100-300-30-10",
"clustering-100-300-30-15","clustering-100-300-30-20"]
)

