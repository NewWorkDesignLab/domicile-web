# Domicile-VR #
Digitale Bildungsangebote in der der Immobilienwirtschaft mittels Virtual Reality.

Dies ist das Repository zur Entwicklung einer Applikation im Rahmen des Forschungsprojektes "Domicile-VR". Innerhalb dieses Projektes soll ein digitales Bildungsangebot entstehen, welches durch die Verwendung von Virtual Reality die Möglichkeiten zur Aus,- Fort- und Weiterbildung innerhalb der Immobilienbranche vereinfachen soll.

Innerhalb dieses Projektes arbeiten mehrere Kooperationspartner zusammen. Dazu gehören:
* Akademie für berufliche Bildung (AFBB) gGmbH
* Staatlich anerkannte Fachhochschule Dresden (FHD)
* Professur für Bildungstechnologie (PBT/TUD) am Institut für Berufspädagogik und berufliche Didakti-ken an der Technischen Universität Dresden

Im Rahmen des Arbeitspaketes 4 (AP04: Technische Konzeption und Umsetzung) arbeitet der oben genannte Partner FHD an der Erstellung und Umsetzung der Unity-Basierten Anwendung.
<br><br>


## AP04: Technische Konzeption und Umsetzung (Koordination: FHD) ##
Es erfolgt die Szenario- und Umgebungsentwicklung (Gebäude, Wohnungen, Mängel) mit Hilfe eines 3D-Modelling-Werkzeuges (bspw. Blender). Die Inhalte für diese Szenarien werden mit den entsprechenden Stakeholdern frühzeitig abgestimmt und getestet, ob Detailgrad und Komplexität ausreichen. Insofern bilden die 3D-Modelle den Kern des ersten testbaren Prototyps im Meilenstein M2. Auch das Interface wird in einer prototypischen Version realisiert. Die Interface-Entwicklung für die 3D-Umgebung findet in Adobe XD statt.

Dabei stellt die Fertigstellung eines ersten testbaren Prototyps den zweiten Meilenstein M2 des Projekts dar. Schließlich erfolgt die Einbettung (Interface und virtuelle Räume) in eine 3D-Entwicklungsumgebung. Hierzu wird die Entwicklungsumgebung Unity3D verwendet.

Die Fertigstellung des VR-Lernszenarios – somit die praktische Einsatzfähigkeit – stellt den dritten Meilenstein M3 des Projekts dar. Hinzu kommt hier die Administrationsumgebung mit welcher Lehrende verschiedene Szenarien und Mängel laden und beeinflussen können. Diese wird ebenfalls in der Entwicklungsumgebung Unity3D realisiert.
<br><br>


## Partner ##
![Logo der Projektpartner - AFBB, TUD und FHD](/resources/publicity/afbb_tud_fhd_logokombi.jpg)<br>
[Domicile bei der AFBB](https://www.afbb.de/de/projekte/domicile-vr.html)<br>
[Domicile bei der TU Dresden](https://tu-dresden.de/mz/forschung/projekte/?fis_type=forschungsprojekt&fis_id=18159)<br>
[Domicile bei der FH Dresden](https://www.fh-dresden.eu/forschung/forschungsprojekte/domicile-vr/)<br>
<br><br>


## Projektträger ##
![Logo des Projektträgers - Sächsisches Staatsministerium für Wirtschaft, Arbeit und Verkehr (SMWAV)](/resources/publicity/SMWA_EFRE-ESF_Sachsen_Logokombi_quer_03.jpg)
**Projektträger:** Sächsisches Staatsministerium für Wirtschaft, Arbeit und Verkehr (SMWAV)<br>
**Laufzeit:** 01.05.2019 bis 30.04.2022<br>
**Assoziierte Praxispartner:** Verband der Wohnungs- und Immobilienwirtschaft Sachsen e.V., ELB-Immobilien Verwaltungs GmbH<br>
<br><br>


# Domicile-VR Webapp
Dieses Repository beinhaltet die Web-Komponente des Produktes. Die Webanwendung ermöglich das Erstellen und Managen der Übungsszenarien.
## getting started
```sh
git clone git@github.com:NewWorkDesignLab/domicile-web.git
cd domicile-web
```


### prerequisites
For building and running this Repository with docker you need to install docker and docker-compose.
You will find detailed information on how to install the docker dependencies here:
* [Docker](https://docs.docker.com/install/)
* [Docker-Compose](https://docs.docker.com/compose/install/)

Currently used Versions:
* Docker version 19.03.5, build 633a0ea838
* docker-compose version 1.24.1, build 4667896b



### for production: generate necessary config
Provide master key:
```sh
printf "put_master_key_here" >> config/master.key
```
You also need to provide some environemnt variables. To copy a blueprint:
```sh
cp .env.example .env
```



### docker & docker-compose
Build Image in Development:
```sh
DOCKER_BUILDKIT=1 docker build . -t domicile_web:dev --target development
```
Build Image in Production:
```sh
DOCKER_BUILDKIT=1 docker build . -t domicile_web:prod --target production --build-arg RAILS_MASTER_KEY=$(cat config/master.key)
```

Start Container in Development:
```sh
docker-compose up -d -V
```
Start container in Production:
```sh
docker-compose -f docker-compose.yml -f docker-compose.production.yml up -d -V
```

Stop container:
```sh
docker-compose down
```

Bash into Container
```sh
docker ps
docker exec -it <CONTAINER ID> /bin/sh
```

## testing
Run Tests:
```sh
docker-compose run web rails test
docker-compose run web rails test test/system
```

## deploying
```
/bin/bash deploy.sh <VERSION_NUMBER>
```


## keeping the docker setup up to date
### changed docker files

If the docker instances changed you need to rebuild and restart everyting.
```bash
docker-compose down
DOCKER_BUILDKIT=1 docker build . -t domicile_web:dev --target development
docker-compose up -d -V
```



### cleanup docker environment
Docker generally never deletes something what may be useful again. Which means,
that it never deletes anything.

To clean up the mess you should execute
```sh
docker system prune
```
from while to while.

To reset hard, execute (be carefull! this will delete images and volumes aswell!)
```sh
docker system prune --all --volumes -f
```
