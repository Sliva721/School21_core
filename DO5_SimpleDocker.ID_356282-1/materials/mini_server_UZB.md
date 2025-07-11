## **FastCGI** va **nginx** yordamida **C** dasturini ishga tushirish.

<fcgiapp.h> sarlavha fayli tomonidan taqdim etiluvchi API yordamida soket haqida ma'lumotni ko’rsatish mumkin.

TCP soket fayl deskriptorini olish namunasi:
`int sockfd = FCGX_OpenSocket("127.0.0.1:9000", 100);`

... yoki Unix soketlar yordamida:
`int sockfd = FCGX_OpenSocket("/var/run/fcgi.sock", 100);`

Olingan soket bilan quyidagilarni yozish mumkin:
```c
FCGX_Request req;
FCGX_InitRequest(&req, sockfd, 0);

while (FCGX_Accept_r(&req) >= 0) {
  FCGX_FPrintF(req.out, "Content-Type: text/html\n\n");
  FCGX_FPrintF(req.out, "hello world");
  FCGX_Finish_r(&req);
}
```

Kompilyatsiya qilingandan so'ng, binar fayl to'g'ridan-to'g'ri *spawn-fcgi* or *cgi-fcgi* ishlatmasdan ishga tushirilishi mumkin.
