



# vector de ajuste de porcentajes especificos a 10 divisiones del máximo registrado por persona
vec_normal<- c()
vec_normal<-c(0,0.01148938,0.01720406,0.17390075,0.19012909,0.55477443,0.19012909,0.17390075,0.01720406,0.01148938)
# el numero 0.55477443 representaría la intensidad media
# el cero corresponde a la máxima intensidad del esfuerzo

#print(vec_normal[1])
# indice de cada porcentaje especifico
i<-1:length(vec_normal)-1



# leer archivo de datos de peso cargado maximo sin cometer errores
# sin modificar la técnica (peso)
# en la repetición donde ya cometió el error  o no pudo realizar el movimiento (rep)
dat<- read.csv("ejer1.csv")
head(dat)
n1=nrow(dat)
cat("Tamaño de la muestra: ",n1)  #### tamaño de la muestra




# construcción de pesos,repeticiones por porcentaje objetivo de peso
# correspondientes a la intensidad
v1<-c() # peso por intensidad
v2<-c() # estimado de repeticiones por intensidad
v3<-c() # estimado de peso por repeticiones
cont=1
di=1
for (p in 1:n1){
for (j in i){
        v1<-c(v1,dat[p,1]-dat[p,1]/10*j)
        v2<-c(v2,dat[p,2]-dat[p,2]/10*j)
        v3<-c(v3,v1[cont]+vec_normal[di])
        cont=cont+1
        di=di+1
}
    di=1
}
cat("peso para intensidad estimada : ",v1,"\n")

cat("rep para intensidad estimada  : ",v2,"\n")
cat("peso estimado para intensidad :",v3,"\n")
cat("diferencias entre peso real y estimado :",v1-v3,"\n")


# convertir los vectores a data frame
datos=data.frame(peso=v1,int=v2,sug=v3)



# crear el modelo matemático que define este comportamiento
fit<-lm(sug ~ int + peso, data=datos)
summary(fit)


# El modelo mostrarlo en forma conocida
cc <- fit$coefficients
(eqn <- paste("Y =", paste(cc[1], paste(cc[-1], names(cc[-1]), sep=" * ", collapse=" + "), sep=" + "), "+ e"))



# comparar modelo nuevo contra Brsiky
datorigen<-data.frame(peso=dat$peso,int=dat$rep)
#datorigen
maximaz<-predict(fit,datorigen) # peso maximo estimado
cat("Datos estimados por el nuevo modelo: ",maximaz,"\n")
br<-datorigen$peso/(1.0278-(0.0278*datorigen$int)) # formula de Brsiky
cat("Datos estimados por la ecuación de Brsiky: ",br,"\n")


# zonas de entrenamiento
# zonas porcentuales para entrenamiento
po<-100
cat("Peso   zona%\n")
for (zz in 1:length(v1)){
       if(zz %% 10 !=0){
        cat(v1[zz],"  ",po," % \n")
           po=po-10
       }
       else{
           cat(v1[zz],"  ",po," % \n\n")
           cat("Peso   zona%\n")
           po=100
       }
    }






