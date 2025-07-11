# Simple Docker

Dokerga kirish. O'z serveringiz uchun oddiy doker obrzini ishlab chiqish.

💡 Ushbu loyiha bo’yicha fikr-mulohazalaringizni biz bilan baham ko'rish uchun [shu yerga bosing](https://new.oprosso.net/p/4cb31ec3f47a4596bc758ea1861fb624). Bu anonim va jamoamizga mashg’ulotlarni yaxshilashga yordam beradi. Loyihani bajarib bo’lgandan so'ng darhol so'rovnomani to'ldirishni tavsiya qilamiz. 

## Contents

1. [Chapter I](#chapter-i)
2. [Chapter II](#chapter-ii) \
    2.1. [nginx](#nginx) \
    2.2. [Docker](#docker) \
    2.3. [Dockle](#dockle)
3. [Chapter III](#chapter-iii) \
    3.1. [Tayyor doker](#part-1-tayyor-doker) \
    3.2. [Konteyner bilan operatsiyalar](#part-2-konteyner-bilan-operatsiyalar) \
    3.3. [Mini veb-server](#part-3-mini-veb-server) \
    3.4. [O'z dokeringiz](#part-4-oz-dokeringiz) \
    3.5. [Dockle](#part-5-dockle) \
    3.6. [Asosiy Docker Compose](#part-6-asosiy-docker-compose)


## Chapter I

![simple_docker](misc/images/simple_docker.png)

Yer sayyorasi, kema bortida, hozirgi kunlar.

Siz hech qachon ko’chib o’tishni yoqtirmagansiz. Ko'p yugur-yugur, kam ish.
Agar DevOps dunyosiga kirish uchun boshqa shaharda ajoyib vakansiya topishga muvaqqat bo’lgan ekansiz, boshqa iloj ham yo’q.

Siz kichik qiyinchiliklar rejalarni buzishiga yo'l qo'yadigan odamlardan emasmisiz, mabodo?

Kayuta derazasidan dengiz to'lqinlarining shovqini eshitilib, sizni to'lqinlarda tinchgina tebratayotganizda, siz dengiz haqidagi sevimli romaningiz – "Mobi Dik" ni eslaysiz.

Garchi romandagi syujet oqimi ochiqlikdan yiroq va lirik chekinishlar va falsafiy mulohazalar bilan to‘la bo‘lsa-da, lekin siz ham boshqalar qatori bu kitobni birinchi navbatda Mobi Dikning o‘zi – oq kit bilan bog‘laysiz.

"Hmm... Oq kit..." – endi siz uzoq safarda vaqtni behuda sarf qilmaslik va doker bilan tanishishingiz haqida eslaysiz.

## Chapter II

### **nginx**

**nginx** ("engine-x" deb talaffuz qilinadi) – HTTP, HTTPS va boshqa protokollar uchun ochiq manbali kodga ega bo’lgan teskari proksi-serverdir.
**nginx** shuningdek yukni balanslovchi, veb-server va HTTP keshlash uchun ishlatiladi.
**nginx** loyihasida asosiy e’tibor yuqori parallellik, yuqori unumdorlik va xotiradan kam foydalanishga qaratilgan.

**nginx** bitta asosiy va bir nechta ishchi jarayonlarga ega.
Asosiy jarayonning asosiy vazifasi – konfiguratsiyani o'qish va tekshirish va ishchi jarayonlarini boshqarishdir.
Ishchi jarayonlar so'rovlarni haqiqiy qayta ishlashni amalga oshiradi.

**nginx** va uning modullari qanday ishlashi konfiguratsiya faylida aniqlanadi. Asl sozlamalar bo’yicha, konfiguratsiya fayli nginx.conf deb ataladi.

### **Docker**

Konteyner - bu mahsulot tomonidan talab qilinadigan barcha bog'liqliklarni o'z ichiga olgan yangi "bajariladigan fayl".
Konteynerlashning asosiy afzalligi – bog’liqliklarni izolyatsiya qilish va yagona, oddiy dasturiy ta'minotni ishga tushirish nuqtasi.

Asosiy tushunchalar:
- Doker obraz - ilova va bog'liqliklar (shu jumladan tizimli) uchun "qadoqlash".
- Konteyner – obraz namunasi, ya’ni “jonli” obraz.

**Docker** – bu konteynerlarda ilovalarni ishlab chiqish, kengaytirish va ishga tushirish uchun mo'ljallangan platforma.
**Docker** – bu sanoatda de-fakto standart konteynerlashtirish vositasi, ammo u konteynerlashtirish texnologiyalari orasida birinchi yoki oxirgi emas.

**Docker** konteynerlarining o'tmishdoshlari virtual mashinalar edi.
Virtual mashina, konteyner kabi, ilovani va uning bog'liqligini tashqi muhitdan ajratib turadi.
Biroq, 88 konteynerlari virtual mashinalarga nisbatan afzalliklarga ega.
Shunday qilib, ular kamroq resurslarni iste'mol qiladilar, ularni tashish juda oson, ular tezroq ishga tushadi va ishga yaroqli holatga keladi.

Doker obraz qatlamlardan tashkil topgan. Har bir qatlam ishga tushirilgan konteynerdagi ma'lumotlar bilan bajarilishi kerak bo'lgan o'zgarishlarni tavsiflaydi.
Qatlamlar orasidagi bog'lanishlar tuzilishi – iyerarxikdir. Qolgan qatlamlar "ustiga qo'yiladigan" asosiy qatlam mavjud.

Obrazni yaratish uchun *Dockerfile* ishlatiladi. Undagi har bir ko'rsatma yangi qatlam yaratadi.

### **Dockle**

**Dockle** — bu zaifliklarni aniqlash uchun ishlatilishi mumkin bo'lgan konteyner obrazlari xavfsizligini tekshirish vositasi.

**Docklening** asosiy xususiyatlari va afzalliklari:
- поиск уязвимостей в образах;
- obrazlardagi zaifliklarni izlash;
- to'g'ri Dockerfile yaratishda yordam berish;
- foydalanish qulayligi, faqat obraz nomi ko’rsatilishi kerak;
- CIS Benchmarks tomonidan qo'llab-quvvatlanish.

### **Docker Compose**

Docker Compose – bu loyihani kengaytirish bilan bog'liq muammolarni hal qilish uchun mo'ljallangan instrumental vosita.
Loyihaning ishlab turishini ta’minlash uchun bir nechta xizmatlar ishlatilsa, Docker Compose foydali bo'lishi mumkin.

Docker Compose ilovani tashkil etuvchi bir nechta konteynerlarni bir vaqtda boshqarish uchun ishlatiladi.
Ushbu vosita Docker bilan bir xil imkoniyatlarni taqdim etadi, lekin mikroservislar kabi yanada murakkab taqsimlangan ilovalar bilan ishlash imkonini ham beradi.

## Chapter III

Birinchi ikkita topshiriq bo'yicha ish natijasi sifatida hisobot taqdim etilishi kerak.
Vazifaning har bir qismida hisobot bajarilgandan so'ng unga nima kiritilishi kerakligi ko'rsatilgan.
Bu savollarga javoblar, skrinshotlar va boshqalar bo'lishi mumkin.

Uchinchi topshiriq bo'yicha ish natijasi sifatida veb-serverni ishga tushirish uchun boshlang’ich fayllar taqdim etilishi kerak.

To'rtinchi va beshinchi topshiriqlar bo'yicha ish natijasi sifatida doker fayllar taqdim etilishi kerak.

Oltinchi topshiriq bo'yicha ish natijasi sifatida *docker-compose.yml* fayli va uni ishga tushirish uchun zarur bo'lgan doker fayllar taqdim etilishi kerak (agar ular ilgari taqdim etilmagan bo'lsa).

- .md kengaytmali hisobot src papkasida joylashgan omborga yuklanishi kerak;
- Hisobotda topshiriqning barcha qismlari 2-darajali sarlavha sifatida ajratib ko'rsatilishi kerak;
- Topshiriqning bir qismi doirasida hisobotga kiritiluvchi barcha narsalar ro'yxat sifatida formatlanishi kerak;
- Hisobotdagi har bir skrinshot qisqacha imzolanishi kerak (skrinshotda ko'rsatilganidek);
- Barcha skrinshotlar ekranning faqat kerakli qismi ko'rinadigan qilib kesilishi lozim;
- Bitta skrinshotda bir vaqtning o'zida bir nechta topshiriq bandlarini ko'rsatishga ruxsat beriladi, lekin ularning barchasi skrinshot imzosida tasvirlangan bo'lishi kerak;
- Uchinchi topshiriqdan veb-serverni ishga tushirish uchun boshlang’ich fayllar src/server papkasida joylashgan omborga yuklanishi kerak;
- To'rtinchi va beshinchi topshiriqlardagi obrazlarni ishga tushirish uchun yakuniy doker fayllari omborga, src papkasiga yuklanishi kerak;
- Oltinchi topshiriqning *docker-compose.yml* fayli omborga, src papkasiga yuklanishi kerak;
- Lozim bo’lganda, yechimni jonli ravishda namoyish etishga tayyor bo'lish kerak.

## Part 1. Tayyor doker

Kichkina amaliyotingizning yakuniy maqsadi sifatida siz darhol o'zingizning veb-serveringiz uchun doker obrazni yozishni tanladingiz va shuning uchun boshida siz server uchun tayyor doker obraz bilan shug'ullanishingiz kerak.
Sizning tanlovingiz juda oddiy **nginxga** to'g'ri keldi.

**== Topshiriq ==**

##### **nginx**-dan rasmiy doker obrazni oling va uni `docker pull` yordamida yuklab oling.
##### `docker images` yordamida doker obrazning mavjudligini tekshiring.
##### Doker obrazni `docker run -d [image_id|repository]` orqali ishga tushiring.
##### Obraz `docker ps` orqali ishga tushirilganligini tekshiring
##### `docker inspect [container_id|container_name]` orqali konteyner haqidagi maʼlumotlarni koʻring.
##### Buyruqning chiqishi asosida konteynerning o'lchamini, maplangan portlar ro'yxatini va konteyner ip-sini aniqlang va hisobotga joylashtiring.
##### `docker stop [container_id|container_name]` yordamida doker konteynerini to'xtating.
##### docker ps orqali konteyner to'xtaganligini tekshiring.
##### *run* buyrug'i orqali mahalliy mashinadagi xuddi shunday portlarga maplangan konteynerdagi 80 va 443 portlarga ega dokerni ishga tushiring.
##### **nginx** boshlang'ich sahifasi brauzerda *localhost:80* manzilida mavjudligini tekshiring.
##### `docker restart [container_id|container_name]` yordamida doker konteynerini qayta ishga tushiring.
##### Konteynerning ishga tushganligini har qanday usul bilan tekshiring.

- Hisobotga skrinlarni joylashtiring:
  - vazifaning ushbu qismida ishlatiladigan barcha buyruqlarni chaqirish va chiqarish;
  - *localhost:80* manzili bo’yicha **nginx** boshlang'ich sahifasi (manzil ko'rinadigan bo'lishi kerak).

*Eslatma:* **Git-ga og'ir fayllarni (>10 MB) yuklamang.**

## Part 2. Konteyner bilan operatsiyalar

Doker obraz va konteyner tayyor. Endi nginx konfiguratsiyasiga kirib, sahifa holatini aks ettirish mumkin.

**== Topshiriq ==**

##### exec buyrug'i yordamida doker konteyneridagi *nginx.conf* konfiguratsiya faylini o'qing.
##### Mahalliy mashinada *nginx.conf* faylini yarating.
##### **nginx** server holati sahifasini qaytarish uchun uni */status* yo'li bo'ylab sozlang.
##### Yaratilgan *nginx.conf* faylini `docker cp` buyrug'i yordamida doker obraz ichida nusxalang.
##### exec buyrug'i yordamida doker obraz ichida **nginx**-ni qayta ishga tushiring.
##### **nginx** server holati sahifasi *localhost:80/status* manzili bo’yicha berilishini tekshiring.
##### *export* buyrug'i yordamida konteynerni *container.tar* fayliga eksport qiling.
##### Konteynerni to'xtating.
##### To'xtatilgan konteynerni o’chiring.
##### Avval konteynerlarni o'chirmasdan, obrazni `docker rmi [image_id|repository]` orqali o'chirib tashlang.
##### *import* buyrug'i yordamida konteynerni qayta import qiling.
##### Import qilingan konteynerni ishga tushiring.
##### **nginx** server holati sahifasi *localhost:80/status* manzili bo’yicha berilishini tekshiring.

- Hisobotga skrinlarni joylashtiring:
  - vazifaning ushbu qismida ishlatiladigan barcha buyruqlarni chaqirish va chiqarish;
  - yaratilgan *nginx.conf* faylining tarkibi;
  - *localhost:80/status* manzili bo’yicha **nginx** server holatiga ega sahifalar.

## Part 3. Mini veb-server

Endi oxirgi bosqichga tayyorgarlik ko'rish uchun dokerdan biroz tanaffus olish lozim. O'z serveringizni yozish vaqti keldi.

**== Topshiriq ==**

##### **C** va **FastCgi**-da `Hello, World!` yozuvi bilan oddiy sahifani qaytaradigan mini-server yozing.
##### 8080 portida *spawn-fcgi* orqali yozilgan mini-serverni ishga tushiring.
##### 81-portdan *127.0.0.1:8080* ga barcha so'rovlarni proksilaydigan o'zingizning *nginx.conf* yozing.
##### **nginx** ni yozma konfiguratsiya bilan mahalliy sifatida ishga tushiring.
##### Brauzerda *localhost:81* bo’yicha siz tomoningizdan yozilgan sahifa berilayotganligini tekshiring.
##### *nginx.conf* faylini *./nginx/nginx.conf* yo'li bo’ylab joylashtiring (bu keyinroq kerak bo'ladi).

## Part 4. O'z dokeringiz

Ana endi hammasi tayyor. Yaratilgan server uchun doker obrazni yozishni boshlashingiz mumkin.

**== Topshiriq ==**

*Doker obrazni yozishda bir nechta RUN buyruqlarini chaqirishdan saqlaning*

#### O'zingizning doker obrazingizni yozing:
##### 1) [3-qismdan](#part-3-mini-veb-server) FastCgi-da mini server manbalarini to'playdi;
##### 2) uni 8080 portida ishga tushiradi;
##### 3) obraz ichidagi yozilgan *./nginx/nginx.conf* ni nusxalaydi;
##### 4) **nginx**-ni ishga tushiradi.
_doker ichida **nginx**-ni mustaqil ravishda o'rnatish mumkin yoki **nginx** ga ega bo’lgan tayyor obrazni asos sifatida ishlatishingiz mumkin._

##### Nom va tegni ko'rsatgan holda `docker build` orqali yozilgan doker obrazni yig’ing.
##### `docker images` orqali hamma narsa to'g'ri yig'ilganligini tekshiring.
##### Mahalliy mashinada yig'ilgan 81 port mappingli doker obrazni 80 ga va **nginx** konfiguratsiya fayllari joylashgan manzil bo’yicha konteyner ichidagi *./nginx* papkasidagi mappingli dokerni ishga tushiring ([2-qismga](#part-2-konteyner-bilan-operatsiyalar) qarang).
##### Yozilgan mini server sahifasi localhost:80 bo’yicha mavjudligini tekshiring.
##### *./nginx/nginx.conf* ga **nginx** serverining holatini ko'rsatish uchun ishlatilishi kerak bo'lgan */status* sahifasini proksilashni yozib to’ldiring.
##### docker tasvirini qayta tiklash.
*Agar hammasi to'g'ri bajarilgan bo'lsa, faylni saqlash va konteynerni qayta ishga tushirgandan so'ng, doker obraz ichidagi konfiguratsiya fayli ortiqcha harakatlarsiz o'z-o'zidan yangilanishi kerak.*
##### **nginx** holatiga ega sahifa endi *localhost:80/status* bo’yicha berilayotganligini tekshiring

## Part 5. **Dockle**

Obrazni yozgandan so'ng, xavfsizlik uchun uni tekshirish hech qachon zarar qilmaydi.

**== Topshiriq ==**

##### Oldingi topshiriqdagi obrazni `dockle [image_id|repository]` yordamida skanerlang.
##### **Dockle** orqali tekshirishda xato yoki ogohlantirishlar bo'lmasligi uchun obrazni to'g'rilang.

## Part 6. Asosiy **Docker Compose**

Ana endi biroz qizib oldingiz. Lekin biroz shoshmay turing ...
Bir vaqtning o'zida bir nechta doker obrazlardan iborat loyihani kengaytirish bilan tajriba o'tkazishga nima deysiz?

**== Topshiriq ==**

##### 1) [5-qismdan](#part-5-dockle) doker konteynerini ko’taring _(u mahalliy tarmoqda ishlashi kerak, ya'ni **EXPOSE** ko'rsatmasi va portlarni mahalliy mashinaga maplashdan foydalanish shart emas)_.
##### 2) barcha so'rovlarni 8080 portidan birinchi konteynerning 81 portiga proksilaydigan **nginx** ga ega bo’lgan doker konteynerini ko'taring.
##### Ikkinchi konteynerning 8080 portini mahalliy mashinaning 80 portiga maplang.

##### Barcha ishga tushirilgan konteynerlarni to'xtating.
##### `docker-compose build` va `docker-compose up` buyruqlari yordamida loyihani yarating va ishga tushiring.
##### *localhost:80* bo’yicha brauzerda avvalgidek siz tomoningizdan yozilgan sahifa berilayotganligini tekshiring.