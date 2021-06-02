-- create a table using a select query in a different tablespace 
create table <tablename> tablespace <tablespace name> as (select <column(s)> from <source_table> where <filters>);
