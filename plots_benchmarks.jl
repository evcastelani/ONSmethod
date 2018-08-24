ONS=readdlm("results_ons.txt")
#ONS2=readdlm("results_ons2.txt")
GN=readdlm("results_gnlovo.txt")
NM=readdlm("results_nmlovo.txt")
PS=readdlm("results_pslovo.txt")

using Gadfly

#Problem solved
PROB=[1:1:43;]
SUB1=ONS[[2:4:171;],1]
#SUB2=ONS2[[2:4:171;],1]
SUB3=GN[[2:4:171;],1]
SUB4=NM[[2:4:171;],1]
SUB5=PS[[2:4:171;],1]

#set_default_plot_size(14cm, 12cm)
#layer_1=layer(x=PROB,y=SUB1,Geom.point,Theme(point_size=1.5pt,default_color=colorant"red"))
#layer_2=layer(x=PROB,y=SUB2,Geom.point,Theme(point_size=1.5pt,default_color=colorant"blue"))
#layer_3=layer(x=PROB,y=SUB3,Geom.point,Theme(point_size=1.5pt,default_color=colorant"green"))
#layer_4=layer(x=PROB,y=SUB4,Geom.point,Theme(point_size=1.5pt,default_color=colorant"pink"))
#layer_5=layer(x=PROB,y=SUB5,Geom.point,Theme(point_size=1.5pt,default_color=colorant"orange"))
#myplot=plot(layer_1,layer_2,layer_3,layer_4,layer_5,Guide.xlabel("problem"),Guide.ylabel("Problem solved"),Guide.manual_color_key("Methods", ["ONS1","ONS2", "GN","NM","PS"], ["red", "blue","green","pink","orange"]))
#draw(PDF("results1.pdf",14cm,12cm),myplot)
##Distance from founded points to center
#PROB=[1:1:43;]
#SUB1=ONS1[[2:4:171;],3]
#SUB2=ONS2[[2:4:171;],3]
#SUB3=GN[[2:4:171;],3]
#SUB4=NM[[2:4:171;],3]
#SUB5=PS[[2:4:171;],3]
#
#set_default_plot_size(14cm, 12cm)
#layer_1=layer(x=PROB,y=SUB1,Geom.point,Theme(point_size=1.5pt,default_color=colorant"red"))
#layer_2=layer(x=PROB,y=SUB2,Geom.point,Theme(point_size=1.5pt,default_color=colorant"blue"))
#layer_3=layer(x=PROB,y=SUB3,Geom.point,Theme(point_size=1.5pt,default_color=colorant"green"))
#layer_4=layer(x=PROB,y=SUB4,Geom.point,Theme(point_size=1.5pt,default_color=colorant"pink"))
#layer_5=layer(x=PROB,y=SUB5,Geom.point,Theme(point_size=1.5pt,default_color=colorant"orange"))
#myplot=plot(layer_1,layer_2,layer_3,layer_4,layer_5,Guide.xlabel("problem"),Guide.ylabel("Distance from founded points to center"),Guide.manual_color_key("Methods", ["ONS1","ONS2", "GN","NM","PS"], ["red", "blue","green","pink","orange"]))
#draw(PDF("results2.pdf",14cm,12cm),myplot)

#CPU time
PROB=[1:1:43;]
SUB1=ONS[[3:4:171;],1]
#SUB2=ONS2[[3:4:171;],1]
SUB3=GN[[3:4:171;],1]
SUB4=NM[[3:4:171;],1]
SUB5=PS[[3:4:171;],1]

set_default_plot_size(14cm, 12cm)
layer_1=layer(x=PROB,y=SUB1,Geom.point,Theme(point_size=1.5pt,default_color=colorant"red"))
#layer_2=layer(x=PROB,y=SUB2,Geom.point,Theme(point_size=1.5pt,default_color=colorant"blue"))
layer_3=layer(x=PROB,y=SUB3,Geom.point,Theme(point_size=1.5pt,default_color=colorant"green"))
layer_4=layer(x=PROB,y=SUB4,Geom.point,Theme(point_size=1.5pt,default_color=colorant"pink"))
layer_5=layer(x=PROB,y=SUB5,Geom.point,Theme(point_size=1.5pt,default_color=colorant"orange"))
my_plot=plot(layer_1,layer_3,layer_4,layer_5,Guide.xlabel("problem"),Guide.ylabel("CPU time (seconds)"),Guide.manual_color_key("Methods", ["ONS", "GN","NM","PS"], ["red","green","pink","orange"]))
draw(PDF("results3.pdf",14cm,12cm),my_plot)

SUB1=ONS[[2:4:170;],1]
#SUB2=ONS2[[2:4:170;],1]
SUB3=GN[[2:4:170;],1]
SUB4=NM[[2:4:170;],1]
SUB5=PS[[2:4:170;],1]
k=0
for i=1:43
    if SUB1[i]<1.0
        k+=1
    end
end
r=(k/43.0)*100
println("Ratio of solved problem by method ONS = $r")
#k=0
#for i=1:43
#    if SUB2[i]<1.0
#        k+=1
#    end
#end
#r=(k/43.0)*100
#println("Ratio of solved problem by method ONS2 = $r")
k=0
for i=1:43
    if SUB3[i]<1.0
        k+=1
    end
end
r=(k/43.0)*100
println("Ratio of solved problem by method GN = $r")
k=0
for i=1:43
    if SUB4[i]<1.0
        k+=1
    end
end
r=(k/43.0)*100
println("Ratio of solved problem by method NM = $r")
k=0
for i=1:43
    if SUB5[i]<1.0
        k+=1
    end
end
r=(k/43.0)*100
println("Ratio of solved problem by method PS = $r")


SUB1=ONS[[3:4:171;],1]
#SUB2=ONS2[[3:4:171;],1]
SUB3=GN[[3:4:171;],1]
SUB4=NM[[3:4:171;],1]
SUB5=PS[[3:4:171;],1]
k=zeros(4)
for i=1:43
    vet=[SUB1[i],SUB3[i],SUB4[i],SUB5[i]]
    if SUB1[i]==minimum(vet)
        k[1]+=1
    end
    #if SUB2[i]==minimum(vet)
    #    k[2]+=1
    #end
    if SUB3[i]==minimum(vet)
        k[2]+=1
    end
    if SUB4[i]==minimum(vet)
        k[3]+=1
    end
    if SUB5[i]==minimum(vet)
        k[4]+=1
    end
end
r=zeros(4)
r[1]=(k[1]/43)*100.0
r[2]=(k[2]/43)*100.0
r[3]=(k[3]/43)*100.0
r[4]=(k[4]/43)*100.0


println("CPU time ratio")
println("ONS  = $(r[1])")
#println("ONS 2 = $(r[2])")
println("GN = $(r[2])")
println("NM = $(r[3])")
println("PS = $(r[4])")
