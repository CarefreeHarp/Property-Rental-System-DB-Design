create or replace trigger tgr_notification_contract after
   insert on contract
   for each row
declare
   v_username varchar2(30);
begin
   select username
     into v_username
     from client
    where client_id = :new.client_id;
   insert into notification (
      hour_date,
      message,
      typology,
      username
   ) values ( sysdate,
              'Your contract has been created',
              'SIGNED CONTRACT',
              v_username );
   commit;
end;
/