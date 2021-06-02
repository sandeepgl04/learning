-- This has a few DBA commands that is being used to identify certain items.

/*
    Following command(s) are used to identify activities around various users within a DB (Oracle)

*/

-- identify all available connections
select * from v$session where status='ACTIVE';

-- identify the query being executed from active sessions
select status,sid,serial#,saddr,machine,osuser,program,type,schemaname,state,sql_hash_value,sql_address,sql_text,sql_fulltext 
from v$session left outer join v$sqlarea on (hash_value = sql_hash_value and address=sql_address)
where 
osuser=<place your user name which is ideally OS user from where there could be multiple sessions to the same db connecting different schema or whatsoever> 
and 
machine NOT IN (<Add any machine name that you want to filter out>)
order by osuser;

-- Identify long running queries
select * from v$session_longops where sql_hash_value = &sql_hash_value_from_v$session order by last_update_time;

/*
    Remember the above command to identify long ops might have deviation in terms of total blocks available v/s blocks which are now worked on based on how accurately the statistics is maintained.
    Following query will join sessions and long running items for you
*/

select a.status,a.sid,a.serial#,a.saddr,a.machine,a.osuser,a.program,a.type,a.schemaname,a.state,a.sql_hash_value,a.sql_address,b.sql_text,b.sql_fulltext,c.sofar,c.totalwork,c.units,c.start_time,c.time_remaining,c.elapsed_seconds,c.message,c.sql_id,c.sql_plan_hash_value 
from v$session a 
left outer join v$sqlarea b on (b.hash_value = a.sql_hash_value and b.address=a.sql_address)
left outer join v$session_longops c on (c.sql_hash_value = a.sql_hash_value)
where 
osuser=<place your user name which is ideally OS user from where there could be multiple sessions to the same db connecting different schema or whatsoever> 
and 
machine NOT IN (<Add any machine name that you want to filter out>)
order by a.osuser,a.sql_hash_value;

/*
    some times there can be locks in database tables because of work happening
*/

select * from v$locked_object;

/*
    Ever experienced "ORA-01652: unable to extend temp segment by 1024 in tablespace USERS"
    understand tablespace : https://docs.oracle.com/cd/A64702_01/doc/server.805/a58227/ch4.htm
    AWS RDS has some restrictions when it comes to adding or deleting items in table space : https://aws.amazon.com/premiumsupport/knowledge-center/rds-oracle-storage-optimization/
        Remember : Its not adviced to add extra data files in tablespace to keep track of new data. Its adviced to resize the size of existing files.
*/

-- step 1 : Lets understand available tablespaces today and the allocated storage
select tablespace_name, file_name, bytes allocated_bytes, bytes/(1024*1024*1024 ) allocated_gb,increment_by from dba_data_files;

-- step 2 : Lets understand  tablespace today and the used storage
select tablespace_name, sum(bytes) total_used_bytes, sum(bytes/(1024*1024*1024 ))  used_bytes_in_gig from dba_segments group by tablespace_name

-- step : Lets club both allocated and utilized sizes to validate where we have more availability
with base_data as (
select tablespace_name, file_name, bytes allocated_bytes, bytes/(1024*1024*1024 ) allocated_gb,increment_by from dba_data_files
), used_data as (
select tablespace_name, sum(bytes) total_used_bytes, sum(bytes/(1024*1024*1024 ))  used_bytes_in_gig from dba_segments group by tablespace_name)
select a.* , b.*, a.allocated_gb - b.used_bytes_in_gig available_gb
from base_data a left outer join used_data b
on (b.tablespace_name = a.tablespace_name);

-- In order to extend tablespace there are options to add a new file
alter tablespace <tablespace name> add datafile '<path>/<filename>.ORA' size 1000m;
-- RDS will only allow you to alter tablespace to add more storage : example 
-- alter tablespace <tablespace name> resize 1024m;


/*
    commands to shift tablespaces of tables/indexes etc

*/


