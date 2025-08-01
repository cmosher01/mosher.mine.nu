user@localhost:~/mosher.mine.nu$ docker run -it -v mosherminenu_ftmwebview_db:/media:ro nouchka/sqlite3
SQLite version 3.34.1 2021-01-20 14:10:07
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .cd /media
sqlite> .open ftmwebview.sqlite
sqlite> .schema
sqlite> select * from emails;
sqlite> select * from users;
sqlite> .quit
