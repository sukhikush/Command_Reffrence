
SELECT * FROM pg_stat_activity                          --- Get Activity Status
SELECT count(*) FROM pg_stat_activity;                  --- Total Number of Connections
SELECT * FROM pg_indexes WHERE tablename = 'tasklinks';   --- Get all index on tabel
CREATE INDEX task_links_updatedBy_object_type ON \"TaskLinks\"(\"updatedBy\", \"objectType\")

SELECT rolname, rolconfig FROM   pg_roles                      ----- all roles

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)

--- Table Stats
        select relname,n_live_tup, n_dead_tup,(Case when (n_dead_tup) > 0 Then 'Yes' Else 'No' END) AS "Run Vacuum" from pg_stat_all_tables where schemaname = 'public' order by relname asc

        select table_name, pg_size_pretty( pg_relation_size(quote_ident(table_name)) ) from information_schema.tables where table_schema = 'public' order by table_name asc

--- Delete Duplicate Row
DELETE FROM "Contacts" where "id" in (
        Select "id" from (
                Select "id","AccountId",count(*) over (partition by "AccountId") as "dupcount",
                ROW_NUMBER() OVER( PARTITION BY "AccountId" ORDER BY  "AccountId" ) AS "row_num" from "Contacts"
        ) as TT where "row_num" > 1
)

---- To Grand Read and Write acess to uses
        --- On Tabel
                GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "DaPgAdmin";
        --- On DB
                GRANT ALL PRIVILEGES ON DATABASE "da-db" to "DaPgAdmin";
        --- on table
                GRANT ALL PRIVILEGES ON TABLE \"JobErrors\" TO \"rahul\"

---- To Remove Read and Write acess to uses
        --- On Tabel
                REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM "DaPgAdmin";
        --- On DB
                REVOKE ALL PRIVILEGES ON DATABASE "da-db" FROM "DaPgAdmin";
        --- on table
                REVOKE ALL PRIVILEGES ON TABLE \"JobErrors\" FROM \"rahul\"
                        
---- To Grant ReadOnly Acess
        GRANT CONNECT ON DATABASE "market-sizing" TO "PowerBiProd";
        GRANT USAGE ON SCHEMA public TO "PowerBiProd";
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO "PowerBiProd";
        ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO "PowerBiProd";

REASSIGN OWNED BY "dev-test" TO "dauser";
DROP OWNED BY dev-test;

-------------------------------------------------------------------------------------------------------------

Get File Path
        Select \"Job\".\"FileId\",\"File\".\"name\",\"File\".\"type\",\"File\".\"location\",\"File\".\"mapping\",\"File\".\"createdAt\",\"File\".\"updatedAt\",\"File\".\"ProjectId\",\"File\".\"createdBy\",\"File\".\"updatedBy\" FROM \"Jobs\" AS \"Job\" LEFT OUTER JOIN \"Files\" AS \"File\" ON \"Job\".\"FileId\" = \"File\".\"id\" WHERE (\"Job\".\"id\" = 'c3e44548-0cfe-426f-8894-9083e9290381') LIMIT 10 OFFSET 0


Insert Users inTO DB

        'auth0|6135a3aaba9d0f006ba09666'   --- Beta
        'auth0|6135a6be81c014006ab78c7f'   --- Dev

        INSERT INTO \"Users\" (\"id\",\"userName\",\"firstName\",\"lastName\",\"role\",\"createdBy\",\"updatedBy\",\"createdAt\",\"updatedAt\")
        VALUES 
        ('auth0|62d772ba536b885a39600ab7','akash.barhe@digitalmsms.com','akash','barhe','agent','auth0|6135a6be81c014006ab78c7f','auth0|6135a6be81c014006ab78c7f','2022-07-20T11:21:48.697Z','2022-07-20T11:21:48.697Z'),
        ('auth0|62037974705bee0068d41ef5','monika.pathak@digitalmsms.com','monika','pathak','manager','auth0|6135a3aaba9d0f006ba09666','auth0|6135a3aaba9d0f006ba09666','2022-02-09T11:21:48.697Z','2022-02-09T11:21:48.697Z');




Get Project ID & Account Name for Contact

        Select \"Contact\".\"email\",\"Contact\".\"mobile\",\"Account\".\"name\" AS \"AccountName\", \"Account\".\"ProjectId\", \"Project\".\"name\" AS \"ProjectName\" FROM \"Contacts\" AS \"Contact\" LEFT OUTER JOIN \"Accounts\" AS \"Account\" ON \"Contact\".\"AccountId\" = \"Account\".\"id\" LEFT OUTER JOIN \"Projects\" as \"Project\" ON \"Project\".\"id\" =  \"Account\".\"ProjectId\" LIMIT 10 OFFSET 0


Update Json Reffrence Query

        UPDATE "Contacts" SET address = JSONB_SET(to_jsonb(address), '{country}', '"75cm"') WHERE address ->> 'country' LIKE '{%}';



File Name  & Project Name
        Select \"File\".\"id\" AS \"FileID\", \"Project\".\"id\" AS \"ProjectID\",\"Project\".\"name\" AS \"ProjectName\", \"File\".\"name\" AS \"FileName\",\"File\".\"createdAt\" FROM \"Files\" AS \"File\"  INNER JOIN \"Projects\" AS \"Project\" ON \"Project\".\"id\" = \"File\".\"ProjectId\" where \"File\".\"type\" = 'Suppression'

File Name & # number of record & Project Name & Client Name & Users

        Select "File"."id" as "File ID","File"."name" as "File Name","File"."type","File"."location","User"."userName","File"."createdAt","Job"."result_processed" as "Processed Record","Job"."result_imported" as "Processed Sucessfuly","Job"."result_errored" as "Error Records","Project"."name" as "Project Name","Client"."name" as "Client Name","File"."createdBy","File"."ProjectId" as "Project Id","Project"."ClientId" from "SharedFiles" as "File" inner join "Jobs" as "Job" on "File"."id" = "Job"."FileId" and "File"."type" = 'Suppression' inner join "Projects" as "Project" on "File"."ProjectId" = "Project"."id" inner join "Clients" as "Client" on "Project"."ClientId" = "Client"."id" inner join "Users" as "User" on "File"."createdBy" = "User"."id"


Share File Join
        Select "File"."id" as "File ID","File"."name" as "File Name","File"."type","File"."location","User"."userName" ,"File"."createdAt","Job"."result_processed" as "Processed Record","Job"."result_imported" as "Processed Sucessfuly" ,"Job"."result_errored" as "Error Records","Client"."name" as "Client Name" ,"File"."createdBy" from "SharedFiles" as "File" inner join "Jobs" as "Job" on "File"."id" = "Job"."FileId" and "File"."type" = 'Suppression' inner join "Clients" as "Client" on "File"."ClientId" = "Client"."id" inner join "Users" as "User" on "File"."createdBy" = "User"."id"

        
Select "FileLink"."SharedFileId","FileLink"."ProjectId" ,"File"."name" as "File Name","Project"."name" as "Project Name" from "SharedFileProjects" as "FileLink" inner join "SharedFiles" as "File" on "File"."id" = "FileLink"."SharedFileId" inner join "Projects" as "Project" on "Project"."id" = "FileLink"."ProjectId"

Project Info
        Select "Project"."id" as "Project Id","Project"."name" as "Project Name","Project"."createdAt" ,"Client"."name" as "Client Name","User"."userName" as "User Name"from "Projects" as "Project" inner join "Clients" as "Client" on "Project"."ClientId" = "Client"."id" inner join "Users" as "User" on "Project"."createdBy" = "User"."id"


--------------------------------------------------------------------------------------------------------------------------------------------
--****************************************************************************************************************************************
--------------------------------------------------------------------------------------------------------------------------------------------
-- show running queries (pre 9.2)
SELECT procpid, age(clock_timestamp(), query_start), usename, current_query 
FROM pg_stat_activity 
WHERE current_query != '<IDLE>' AND current_query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start desc;

-- show running queries (9.2)
SELECT pid, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start desc;

-- kill running query
SELECT pg_cancel_backend(procpid);

-- kill idle query
SELECT pg_terminate_backend(procpid);

-- vacuum command
VACUUM (VERBOSE, ANALYZE);

-- all database users
select * from pg_stat_activity where current_query not like '<%';

-- all databases and their sizes
select * from pg_user;

-- all tables and their size, with/without indexes
select datname, pg_size_pretty(pg_database_size(datname))
from pg_database
order by pg_database_size(datname) desc;

-- cache hit rates (should not be less than 0.99)
SELECT sum(heap_blks_read) as heap_read, sum(heap_blks_hit)  as heap_hit, (sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit) as ratio
FROM pg_statio_user_tables;

-- table index usage rates (should not be less than 0.99)
SELECT relname, 100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used, n_live_tup rows_in_table
FROM pg_stat_user_tables 
ORDER BY n_live_tup DESC;

-- how many indexes are in cache
SELECT sum(idx_blks_read) as idx_read, sum(idx_blks_hit)  as idx_hit, (sum(idx_blks_hit) - sum(idx_blks_read)) / sum(idx_blks_hit) as ratio
FROM pg_statio_user_indexes;

-- Dump database on remote host to file
$ pg_dump -U username -h hostname databasename > dump.sql

-- Import dump into existing database
$ psql -d newdb -f dump.sql

-- Get table Indexes
SELECT *
FROM information_schema.key_column_usage
WHERE table_name = 'client_user_map'
