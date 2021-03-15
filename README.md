# 1RM-especifico


# Biomechanics_1RM_especifico
Crear un modelo basado en repeticiones y compararlo con el de Brsiky

### Los archivos CSV corresponden a ejercicios realizados con diferentes planos musculares
### tienen 2 columnas , la primera columna corresponde al peso soportado por plano muscular
### con el que se realizaron las repeticiones, preferentemente máximo hasta 10 repeticiones.
### La segunda columna del archivo rep corresponde a las repeticiones que pudo hacer la
### persona sin perder técnica, sin temblar, a la misma velocidad, entre otras.

Al archivo html es un ejemplo usando los datos de ejer1.csv

Asi mismo se anexa el archivo creado en Anaconda con el Kernel R que crea el modelo correspondiente

Esta aplicación sirve para construir el modelo especifico personalizado o por grupos con los que cualquier entrenador
debería trabajar para tener las intensidades correctas por zonas de entrenamiento y comparadas con la maxima de Brsiky.


Descripción de los ejercicios y correspondencia con los archivos

### EJERCICIOS 2020
- BB Squat trasero
- BB Bench Press
- Deadlift
- Empuje de cadera



### CARACTERÍSTICAS DE LA MUESTRA
4 sujetos varones que se desempeñan como defensas laterales, entrenan 5 veces a la semana durante aproximadamente 120 minutos y juegan 1 vez por semana, estos mismos pertenecientes al selectivo BUAP de futbol soccer en la ciudad de Puebla, el cual compite a nivel universitario en edades comprendidas 20 a 23 años.

Sujeto 1
Edad: 20 años 
Altura: 1.72 m
Peso: 69 kg 

Sujeto 2
Edad: 21 años 
Altura: 1.83 m
Peso: 78 kg 

Sujeto 3
Edad: 22 años 
Altura: 1.67 m
Peso: 69 kg 

Sujeto 4
Edad: 22 años 
Altura: 1.65 m
Peso: 63 kg 

Sujeto	Edad	Estatura	Peso
- 1	20	1.72	69
- 2	21	1.83	78
- 3	22	1.67	69
- 4	22	1.65	63

N=4			


# 1RM_espV2.R (corregido y mejorado a marzo de 2021)
#### Med.csv
##### La persona practicó karate, tae kwon do, box y natación por varios años, hasta principios de marzo de 2021 
##### practicante de fitness por aproximadamente tres años, con edad de 23 años, talla de 173 cm, 69 kg, alumno de 8 semestre de licenciatura.

La actividad en el gimnasio consistió en: hacer calentamiento previo, a continuación, press de pecho horizontal, con máximo 10 repeticiones del ejercicio, aumentando las cargas, con inicio de peso de 10kg por lado (discos de 10kg y la barra con un peso de 20kg). Se usó un metrónomo (Metronome Beats, app de celular), de esta forma se logró ser más preciso con la ejecución y respetando la técnica del movimiento, finalizar al rechazo o pérdida de técnica.


