create or replace trigger tgr_notifications_solicitude after
   insert on rent_solicitude
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
              'Your rent request has been received',
              'RENT SOLICITUDE',
              v_username );
   commit;
end;
/
