CREATE DATABASE LINK DB_admin

    CONNECT TO C##GUEST3 IDENTIFIED BY GUEST

USING 'phuc';

CREATE DATABASE LINK DB_M1

    CONNECT TO C##GUEST1 IDENTIFIED BY GUEST

USING 'tai';

CREATE DATABASE LINK DB_M2

    CONNECT TO C##GUEST2 IDENTIFIED BY GUEST


USING 'tien';