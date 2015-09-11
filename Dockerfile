# Start with official jenkins
FROM jenkins

# Install packages we need (n.b., jenkins includes openjdk-8-jdk)
USER root

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb http://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
    openjdk-7-jdk \
    bzip2 \
    docker-engine

# Install maven versions we want in jenkins from official download
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
    FB11D4BB7B244678337AAD8BC7BF26D0BB617866 \
    744A72C49D4B7C81F736956580CE7E5DC9725F3B \
    C739CE4075D9F0F0DED13A7D39BE51A1084C9113 \
    DA5DDD55E69DE580FE985E76E136088A1824BDC1 \
    F4C53F3061834D885726D258AC2D56EAF0E309FF \
    063F1F7ADAF125DDE45DAC76CC6CA38F5249885E \
    9B6FC4B4C0025619D73119AE298E4C7A93CC521B \
    03E1A98442361AFAD93F4BDF3B5B9D09699A35EB \
    791641FC7EA94BEC25327F363402A74A27CD9F92 \
    B920D295BF0E61CB4CF0896C33CD6733AF5EC452 \
    B59B67FD7904984367F931800818D9D68FB67BAC \
    998AF0E2B935996F5CEBD56B9B1FDA9F3C062231 \
    8FE7A0B24B77E888EF5A5CE8ABC8EE39BB550746 \
    935FAB6496C76F2361F2ECC3FA383AABE50BC813 \
    13E97013BB5FAEE485B351F30A335AF8B3A2D3B1 \
    1A4E7F0CF4DAC878B6284F552B7876099C0EFF85 \
    34D924503BAF25291978F7C54F9BDB78DB596386 \
    6E13156C0EE653F0B984663AB95BBD3FA43C4492 \
    D8966C2957783E291CC42226E181870DC625BAFB \
    853939BE1AA9AC7C1F55B990D2A765937BA507E8 \
    190D5A957FF22273E601F7A7C92C5FEC70161C62 \
    F254B35617DC255D9344BCFA873A8E86B4372146 \
    429E6335123A642267EF0CDB8F0FABD30F353251 \
    7350B3B066E17ED725435E940B7B8BED064C851C \
    1BB590FA3FD9E469D01C2FE2C2D879C8B0874707 \
    8537C08B6339A662D3B13D0F8FE7CB51365A46EF \
    54EE8E5039C6E53941F4ED2BA3F9CCC081C4177D \
    9FFED7A118D45A44E4A1E47130E6F80434A72A7F \
    42F9D2F7818D068F1460F4A8E8579C183571506F \
    364303B88A05E219E49E5C25A8AD2A7E9A25CE21 \
    6C4982557FD21F69E64E08863B58205B9D7013A9 \
    82F833963889D7ED06F1E4DC6525FD70CC303655 \
    C1DD8D2231911E96B7E31D867CADB77239332BA6 \
    BA926F64CA647B6D853A38672E2010F8A7FF4A41 \
    A0629D8FAC2B502AE61DF7C03E9B8F917F3ACFC4 \
    C827C931B458D061C4570B6B8C0AEE41CDA187E9 \
    042B29E928995B9DB963C636C7CA19B7B620D787 \
    CFAB13BBD123CD35FB42063A99A03029DDFA199E \
    794C7B5399626BC7233FB941CF277F2D2CF0CC82 \
    47063E8BA7A6450E4A52E7AE466CAED6E0747D50 \
    B99C757B262859B4ABADD09D698DF224589628E0 \
    9C1FC83FF3B877CDE53B337C525875B36BFC416A \
    DA7A1BB85B19E4FB05073431205C8673DC742C7C \
    31FAE244A81D64507B47182E1B2718089CE964B8 \
    B02137D875D833D9B23392ECAE5A7FB608A0221C \
    503BFAAE645286D11EC18181F704B943ED330E1B \
    7C9CFAF9C409737872FE044AF397D776F65C0178 \
    6BDACA2C0493CCA133B372D09C4F7E9D98B1CC53 \
    2BE13D052E9AA567D657D9791FD507154FB9BA39 \
    C413F9B587070392431F3F41EC61DFCD9B758417 \
    C345986F0FD384669C5919E6A5F094FD3961DF05 \
    6A814B1F869C2BBEAB7CB7271A2A1C94BDE89688 \
    D0D78111AEDCC6CAE1799420CEBA9A9B905C7874 \
    3C52836F134ED0C6983F73F200ECB4C4ED5885AC \
    522CA055B326A636D833EF6A0551FD3684FCBBB7 \
    AE9E53FC28FF2AB1012273D0BF1518E0160788A2 \
    47063E8BA7A6450E4A52E7AE466CAED6E0747D50 \
    B6470EDC6EA51DA6B59B4A3DEE2EBD8956CACE56

WORKDIR /opt
RUN for MVN_VERSION in "3.3.3" "3.2.5" "3.1.1" ; do \
        MVN_TGZ=apache-maven-${MVN_VERSION}.tar.gz ; \
        MVN_TGZ_URL=http://www.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz ; \
        set -x \
            && curl -fSL "$MVN_TGZ_URL" -o "$MVN_TGZ" \
            && curl -fSL "$MVN_TGZ_URL.asc" -o "$MVN_TGZ.asc" \
            && gpg --verify "$MVN_TGZ.asc" \
            && tar -xzf ${MVN_TGZ} \
            && rm ${MVN_TGZ}* ; \
    done
WORKDIR /

# Install jenkins plugins and customizations
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY init-scripts/* /usr/share/jenkins/ref/init.groovy.d/
