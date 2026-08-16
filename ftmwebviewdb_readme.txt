user@localhost:~/mosher.mine.nu$ docker run -it -v mosherminenu_ftmwebview_db:/root ttimbers/ubuntu-sqlite3
root@3c523d44ad59:/# cd 
root@3c523d44ad59:~# ls -al
total 410024
drwx------ 4 root root      4096 Jul 13 20:31 .
drwxr-xr-x 1 root root      4096 Jul 13 20:32 ..
-rw------- 1 root root       975 Jul 13 20:15 .bash_history
-rw-r--r-- 1 root root      3106 Oct 15  2021 .bashrc
drwxr-x--- 3 root root      4096 Apr 27 12:56 .java
-rw-r--r-- 1 root root       161 Jul  9  2019 .profile
-rw------- 1 root root      2322 Jul 13 20:15 .sqlite_history
-rw-r--r-- 1 root root       165 Sep  2  2022 .wget-hsts
drwxr-x--- 3 root root      4096 Oct 11  2022 .xmlresolver.org
-rw-r----- 1 1000 1000 419659776 Jul 13 20:31 ftmwebview.sqlite
root@3c523d44ad59:~# sqlite3 ftmwebview.sqlite
SQLite version 3.11.0 2016-02-15 17:29:24
Enter ".help" for usage hints.
sqlite>




.null NULL
.mode col
.head on

.wid 5 25 5 40
select * from users left outer join emails on emails.user = users.id;

insert into users values(NNN, null, 4);
insert into emails values ('XXX@gmail.com', strftime('%Y-%m-%dT%H:%M:%f', 'now'), NNN);
