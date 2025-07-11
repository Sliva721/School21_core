## Modul ngx_http_stub_status_module

ngx_http_stub_status_module moduli asosiy server holati ma'lumotlariga kirishni taqdim etadi.

Asl sozlamalar bo’yicha, bu modul yig’ilmaydi; uning yig'ilishiga *--with- http_stub_status_module* konfiguratsiya parametri yordamida ruxsat berilishi kerak.

Konfiguratsiyaga misol:
```
location = /basic_status {
    stub_status;
}
```

Ushbu konfiguratsiya asosiy holat ma'lumotlariga ega oddiy veb-sahifani yaratadi, u quyidagicha ko'rinishi mumkin:
```
Active connections: 291
server accepts handled requests
 16630948 16630948 31070465
Reading: 6 Writing: 179 Waiting: 106
```
