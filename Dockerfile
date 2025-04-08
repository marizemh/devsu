# Usar una imagen base de Java 17 con Alpine
FROM openjdk:17-jdk-alpine

# Instalar Maven
RUN apk add --no-cache maven

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo pom.xml y descargar las dependencias
COPY pom.xml .
RUN mvn dependency:go-offline

# Copiar el código fuente
COPY src ./src

# Compilar la aplicación
RUN mvn package -DskipTests

# Exponer el puerto 8080
EXPOSE 8080

# Establecer variables de entorno
ENV SPRING_PROFILES_ACTIVE=prod

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "target/demo-0.0.1.jar"]
