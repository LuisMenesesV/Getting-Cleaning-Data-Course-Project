## Descarga el archivo y colócalo en la data carpeta.
if(!file.exists("d:/Coursera R/PF Limpieza de Datos")){dir.create("d:/Coursera R/PF Limpieza de Datos")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="d:/Coursera R/PF Limpieza de Datos/Dataset.zip",method="curl")
unzip(zipfile="d:/Coursera R/PF Limpeza de datos/Dataset.zip",exdir="d:/Coursera R/PF Limpieza de datos")

#Bibliotecas utilizadas
#Las bibliotecas utilizadas en esta operación son data.table y dplyr. 
#Preferimos data.tableya que es eficiente en el manejo de datos grandes como 
#tablas. dplyr se usa para agregar variables para crear datos ordenados.
library(data.table)
library(dplyr)
#leer metadatos
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Dar formato a los conjuntos de datos de prueba y entrenamiento
#Leer datos de entrenamiento
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
#Leer datos de prueba
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

### 1. fusionar los conjuntos de entrenamiento y prueba para crear un conjunto de datos
#Podemos usar combinar los datos respectivos en los conjuntos de datos de 
#entrenamiento y prueba correspondientes al tema, actividad y características.
# Los resultados se almacenan en subject, activityy features.
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#Nombrar las columnas
#Las columnas en el conjunto de datos de características se pueden nombrar a 
#partir de los metadatos en featureNames
colnames(features) <- t(featureNames[2])

#Fusionar los datos
#Los datos en features, activityy subject se fusionan y los datos completos 
#ahora se almacena en completeData.
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

### 2. extrae solo las mediciones de la media y la desviación estándar de 
# cada medición
#Extraiga los índices de columna que tengan media o std en ellos.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

#Agregue columnas de actividad y tema a la lista y observe la dimensión de 
# completeData
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)

#Creamos extractedDatacon con las columnas seleccionadas en formato requiredColumns.
# Y nuevamente, miramos la dimensión de requiredColumns.
extractedData <- completeData[,requiredColumns]
dim(extractedData)

### 3. utiliza nombres de actividades descriptivos para nombrar las actividades
# en el conjunto de datos
#El activity campo en extractedData es originalmente de tipo numérico. Necesitamos
#cambiar su tipo a carácter para que pueda aceptar nombres de actividades. Los 
# nombres de las actividades se toman de los metadatos activityLabels.
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
    extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
# Necesitamos factorizar la activityvariable, una vez que se actualizan los 
#nombres de las actividades.
extractedData$Activity <- as.factor(extractedData$Activity)

### 4. etiquetar adecuadamente el conjunto de datos con nombres de variables 
#descriptivos
#Aquí están los nombres de las variables en extractedData
names(extractedData)

#Examinando extractedData, podemos decir que se pueden reemplazar las siguientes siglas:
#Acc se puede reemplazar con acelerómetro
#Gyro se puede reemplazar con giroscopio
#BodyBody se puede reemplazar con Body
#Mag se puede reemplazar con Magnitud
#El carácter f se puede reemplazar con frecuencia
#El caracter t se puede reemplazar con el tiempo
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
names(extractedData)

### 5. a partir del conjunto de datos del paso 4, crea un segundo conjunto de 
#datos ordenado e independiente con el promedio de cada variable para cada 
# actividad y cada tema.

#En primer lugar, establezcamos Subjectcomo variable factorial.
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)
View(extractedData)

#Creamos tidyDatacomo un conjunto de datos con promedio para cada actividad y 
#tema. Luego, ordenamos las entradas tidyDatay las escribimos en un archivo de 
# datos Tidy.txtque contiene los datos procesados.
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)







