
# Version 2 : 14 de Marzo de 2021
# Enrique R.P. Buendia Lozada
# Benemérita Universidad Autónoma de Puebla

# vector de ajuste de porcentajes especificos a 10 divisiones del máximo registrado por persona (fijo)
set.seed(5)

repeat {
   # crear muestra aleatoria de preferencia con distribución normal
   vec<-rnorm(9,mean=0,sd=0.3) # varianza pequeña pues define personas no elite
   # si aumenta la media, aumentaría la intensidad de la actividad estimada
  

   vec<-sort(abs(vec))
   # partir la muestra para crear simetría por la media
   vec1<-c()
   vec2<-c()
   for (i in 1:length(vec)){
   # separar la muestra ordenada por la mitad
   if (i%%2 == 0) {
          vec1 = c(vec1, vec[i])
   } else {
          vec2 = c(vec2, vec[i])
   }
   }

   vec2<-sort(vec2,decreasing=TRUE)        # simetría de la muestra normal
   vec<-c(vec1,vec2)                       # construir estructura normal
   pv<- shapiro.test(vec)                  # probar bormalidad
   if (pv$p.value >= 0.05) break           # asegurar normalidad
}

vec[1]=0.0
vec_normal<-vec
shapiro.test(vec)      # con la adecuación se mantiene la normalidad
# plot(vec)
# el numero intermedio de vec_normal representaría la intensidad media
# el cero corresponde a la máxima intensidad del esfuerzo

#print(vec_normal[1])




# leer archivo de datos de peso cargado maximo sin cometer errores
# sin modificar la técnica (peso)
# en la repetición donde ya cometió el error  o no pudo realizar el movimiento (rep)
dat<- read.csv("med.csv")
head(dat)
n1=nrow(dat)
cat("Tamaño de la muestra: ",n1,"\n")  #### tamaño de la muestra


sugs=c()
pesos=c()
rrp=c()
for (p in 1:n1){
    zo<- sort(rep_len(dat$peso[p]:1, length.out=9),decreasing =TRUE)
    rr<- sort(rep_len(dat$rep[p]:1, length.out=9),decreasing =TRUE)
    sugs=c(sugs,vec+zo)
    pesos=c(pesos,zo)
    rrp=c(rrp,rr)
}
dat2=data.frame(sug=sugs,peso=pesos,repeticiones=rrp)
dat2




# crear el modelo matemático que define este comportamiento
fit<-lm(sug ~ repeticiones + peso, data=dat2)
summary(fit)

# valores de r
r2<-summary(lm(sug ~ repeticiones + peso, data=dat2))$r.squared
adjustR2<-summary(lm(sug ~ repeticiones + peso, data=dat2))$adj.r.squared
cat(" R2 = ",r2,"\n")
cat(" R2_ajustada = ",adjustR2,"\n")

# El modelo mostrarlo en forma conocida
cc <- fit$coefficients
(eqn <- paste("Y =", paste(cc[1], paste(cc[-1], names(cc[-1]), sep=" * ", collapse=" + "), sep=" + "), "+ e"))





# comparar modelo nuevo contra Brsiky
datorigen<-data.frame(peso=dat$peso,repeticiones=dat$rep)
#datorigen
maximaz<-predict(fit,datorigen) # peso maximo estimado
cat("Datos estimados por el nuevo modelo: ",maximaz,"\n")
br<-datorigen$peso/(1.0278-(0.0278*datorigen$repeticiones)) # formula de Brsiky
cat("Datos estimados por la ecuación de Brsiky: ",br,"\n")

# mostrar comportamiento
ymin1=min(datorigen$peso)
ymin2=min(maximaz)
ymin3=min(br)
miny=min(c(ymin1,ymin2,ymin3))
ymax1=max(datorigen$peso)
ymax2=max(maximaz)
ymax3=max(br)
maxy=max(c(ymax1,ymax2,ymax3))

x<-1:length(maximaz)
plot(x,br,pch=18,col="red",type="b",lty=2,ylim=c(miny,maxy))
lines(x,maximaz,pch=18,col="blue",type="b",lty=2)
legend("topleft",legend=c("Brsiky","Nuevo modelo","Datos originales"),col=c("red","blue","black"),lty=1:2,cex=0.8)
lines(x,datorigen$peso,col="black")           # datos originales







