# Sharlay
### Share and Play

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

## Instalació

## Tomcat
Per al desenvolupament de l'aplicació s'ha usat el servidor Tomcat en la versió 8. Per instalar-lo és necessari descarregar el arxiu zip core desde el següent enllaç: https://tomcat.apache.org/download-80.cgi

Seguir el següent link per la seva instal·lació: http://www.coreservlets.com/Apache-Tomcat-Tutorial/tomcat-7-with-eclipse.html

## SQL DUMP

Un cop instal·lat el servidor Tomcat procedirem a carregar la base de dades de prova. 

En primer lloc crearem un nou usuari anomenat mysql amb el password prac:

`CREATE USER 'mysql'@'localhost' IDENTIFIED BY 'prac'; ` <br>
`GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'localhost'; `

Tot seguit, obrirem el script Lab4_SQLDUMP.sql i realitzarem una execució completa.

## Context de les fotografies de perfil

Sharlay permet pujar una foto de perfil en format .png. Per que aquesta funcionalitat funcioni correctament cal configurar el context on es troben les imatges.

Per configurar el context ens dirigirem al fitxer server.xml.

! [Imatge ajuda] (tutorial_context.png)

Dins del fitxer afegirem la següent linia dins l'etiqueta `<Host>` especificant la ruta local de la carpeta ProfileImages del nostre projecte.

`<Context docBase="ruta_a_la_carpeta_ProfileImages" path="/Sharlay/ProfileImages" />`

** Exemple: ** `<Context docBase="C:\Users\david\eclipse-workspace\Sharlay\WebContent\ProfileImages" path="/Sharlay/ProfileImages" />`

! [Imatge ajuda] (tutorial_context2.png)




