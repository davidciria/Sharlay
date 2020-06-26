# Sharlay - Share and Play

## Universitat Pompeu Fabra (UPF) 2020 - Software Engineering of Web Applications

**Name:** Àngel Herrero Díaz <br />
**NIA:** 205310<br />
**Emails:** angelhd1999@gmail.com / angel.herrero01@estudiant.upf.edu<br />

**Name:** Paula Janer Talamàs  <br />
**NIA:** 204809<br />
**Emails:** paula.janer01@estudiant.upf.edu<br />

**Name:** Mireia Espuga López  <br />
**NIA:** 206319<br />
**Emails:** mireia.espuga01@estudiant.upf.edu<br />

**Name:** David Ciria Mayordomo <br />
**NIA:** 206038<br />
**Emails:** david.ciria01@estudiant.upf.edu<br />

# Introduccion d'ús en local

# Instalació

## Eclipse

Hem emprat l'IDE Eclipse per desenvolupar el projecte. Es pot descarregar fàcilment desde la pàgina oficial: https://www.eclipse.org/

**IMPORTANT:** Instalar la versió "Eclipse IDE for Java EE Developers".

## Tomcat
Per al desenvolupament de l'aplicació s'ha usat el servidor Tomcat en la versió 9. Per instalar-lo és necessari descarregar el arxiu zip core desde el següent enllaç: https://tomcat.apache.org/download-90.cgi

Seguir el següent link per la seva instal·lació: http://www.coreservlets.com/Apache-Tomcat-Tutorial/tomcat-7-with-eclipse.html

##  Projecte

Existeixen dues alternatives per descarregar el projecte:

### 1. Github

Realitzarem un git clone del següent respositori al nostre workspace d'Eclipse: https://github.com/davidciria/Sharlay/

### 2. Fitxer WAR

Importarem el fitxer WAR a Eclipse. Els passos son els següents:
1. Desde el menú accedir a: `File --> Import`
2. Desplegar carpeta `Web` i seleccionar `WAR file`. Fer click a `Next`.
3. Fer un browse del fitxer .war i assegurar-nos que esta seleccionat a l'apartat `Target runtime` el servidor `Apache Tomcat v9.0`.
4. Fer click a `Finish`.

## SQL DUMP

Un cop instal·lat el servidor Tomcat procedirem a carregar la base de dades de prova. 

En primer lloc crearem un nou usuari anomenat mysql amb el password prac:

`CREATE USER 'mysql'@'localhost' IDENTIFIED BY 'prac'; ` <br>
`GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'localhost'; `

Tot seguit, obrirem el script Lab4_SQLDUMP.sql i realitzarem una execució completa.

## Context de les fotografies de perfil

Sharlay permet pujar fotografies de perfil en format .png. Per que aquesta funcionalitat funcioni correctament cal configurar el context on es troben les imatges.

Per configurar el context ens dirigirem al fitxer server.xml.

<img src="https://github.com/davidciria/Sharlay/blob/master/readme_images/tutorial_context.png?raw=true">

Dins del fitxer afegirem la següent linia dins l'etiqueta `<Host>` especificant la ruta local de la carpeta ProfileImages del nostre projecte.

`<Context docBase="ruta_a_la_carpeta_ProfileImages" path="/Sharlay/ProfileImages" />`

**Exemple:** `<Context docBase="C:\Users\david\eclipse-workspace\Sharlay\WebContent\ProfileImages" path="/Sharlay/ProfileImages" />`

<img src="https://github.com/davidciria/Sharlay/blob/master/readme_images/tutorial_context2.png?raw=true">

També caldrà modificar la ruta al controlador UploadProfileImage.java

Cambiar la variable path per la ruta local del projecte on es troben les imatges (la mateixa que l'anterior):

<img src="https://github.com/davidciria/Sharlay/blob/master/readme_images/tutorial_context3.png?raw=true">

## Execució

Ja tenim tot el workspace llest, podem executar el projecte desde eclipse fent clic al icone del play (<img src="https://github.com/davidciria/Sharlay/blob/master/readme_images/play_icon.png?raw=true">). Assegurat d'utilitzar Tomcat en la versió 9 per executar el projecte.

## Email de verificació

Quan un usuari es registra a la plataforma s'envia un email de verificació. Fins que l'usuari no confirma el correu, no pot iniciar sessió.

Es pot canviar el correu origen (direcció desde on s'envien els correus de verificació) a la clase EmailSender situada al package utils.

En el cas que no arribi el email de verificació al usuari es pot modificar el atribut regVerified de la taula Users a true.



