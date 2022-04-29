import Pkg; Pkg.add("CDDLib")

using LinearAlgebra
using Polyhedra
using CDDLib
function Cono(v,init,args...) 
n=length(init)
A=init
 for i in args
  A=hcat(A,i) #=Concatenamos los vectores W=#
 end
Id=zeros(Float64,n, n)
for i in 1:n
 for j in i:n
  if i==j
    Id[i,j]=1.
  else
    Id[i,j]=0.
  end
 end
end #=Creamos la matriz identidad=#
h=HyperPlane(A[1,:],v[1]) ∩ HalfSpace(-Id[1,:],0.)
for i in 2:n
 h=h ∩ HyperPlane(A[i,:],v[i]) ∩ HalfSpace(-Id[i,:],0.)
end
p=polyhedron(h, CDDLib.Library()) #=Creamos el poliedro correspondiente a Ax=v,x>=0 =#
if isempty(p)==true #Si p es vacío, x no está en el cono convexo de W, y viceversa=#
 return false
else
 return true
end
end
Cono([3.;-4.;2.],[1.;0.;0.],[0.;1.;0.],[0.;0.;1.])


