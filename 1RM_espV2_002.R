
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

# Residual sum of squares:
RSS <- c(crossprod(fit$residuals))
cat(" RSS : ",RSS,"\n")
# Mean squared error:
MSE <- RSS / length(fit$residuals)
cat(" MSE : ",MSE,"\n")
# Root MSE:
RMSE <- sqrt(MSE)
cat(" RMSE : ",RMSE,"\n")
# Pearson estimated residual variance
sig2 <- RSS / fit$df.residual
cat(" sig2 : ",sig2,"\n")
# Estadísticamente, MSE es el estimador de máxima verosimilitud de la varianza residual, 
# pero está sesgado (hacia abajo). El de Pearson es el estimador de máxima verosimilitud restringida
# de la varianza residual, que es insesgado.

#Residual Standard error (Like Standard Deviation)
k=length(fit$coefficients)-1 #Subtract one to ignore intercept
SSE=sum(fit$residuals**2)
cat(" SSE : ",SSE,"\n")
n=length(fit$residuals)
RSE=sqrt(SSE/(n-(1+k))) #Residual Standard Error
cat("Residual Standard Error : ",RSE,"\n")


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

#  Standard Error of the Estimate
cc=maximaz-datorigen$peso
cc=sum(cc^2)
SEE=cc/(length(maximaz)-2)
cat(" SEE : ",SEE,"\n")

# Cohen’s d effect size: Cohen’s d is known as the difference of two population means 
# and it is divided by the standard deviation##
# from the data. Mathematically Cohen’s effect size is denoted by:
var1=var(maximaz)
var2=var(dat$peso)
n1=length(maximaz)
n2=length(dat$peso)
s=(((n1-1)*var1 + (n2-1)*var2)/(n1+n2-2))^(0.5)
d=(mean(maximaz)-mean(dat$peso))/s
cat("Cohen’s d effect size : ",d,"\n")
#Effect size	d	Reference       https://en.wikipedia.org/wiki/Effect_size
# d = 0.01 to 2.0, as initially suggested by Cohen and expanded by Sawilowsky
#Very small	0.01
#Small	    0.20
#Medium	    0.50
#Large	    0.80
#Very large	1.20
#Huge	      2.0

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
plot(x,br,pch=18,col="red",type="b",lty=2,ylim=c(miny,maxy),ylab="kg", xlab="mediciones o pruebas")
lines(x,maximaz,pch=18,col="blue",type="b",lty=2)
legend("topleft",legend=c("Brsiky","Nuevo modelo","Datos originales"),col=c("red","blue","black"),lty=1:2,cex=0.8)
lines(x,datorigen$peso,col="black")           # datos originales


# intensidades objetivo
rmm=max(datorigen$peso)
porcent=c(1,.95,.90,.86,.82,.78,.74,.70,.65,.61,.57,.53,.5,.45,.4,.35,.30,.25,.2,.15,.1,.05,.04,.03,.02,.01)
for (i in porcent){
 cat(" ",i*100,"%   = ", rmm*i,"\n")
}






