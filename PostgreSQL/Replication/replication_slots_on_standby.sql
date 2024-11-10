-- Check replication slots on standby
SELECT slot_name,
       plugin,
       slot_type,
       active
    FROM pg_replication_slots;