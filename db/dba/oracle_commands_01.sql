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

-- 
