create table account_information (
   username      varchar2(20) primary key,
   max_rent      number(7,2) default 0 not null check ( max_rent >= 0 ),
   type          varchar2(6) default '-' not null check ( type in ( 'CLIENT',
                                                           'OWNER' ) ),
   creation_date date default trunc(sysdate) not null,
   name          varchar2(30) default '-' not null,
   lastname      varchar2(30) default '-' not null,
   in_deleting   char(1) default 'N' not null check ( in_deleting in ( 'Y',
                                                                     'N' ) )
);

create table account_credential (
   username varchar2(20) primary key,
   email    varchar2(30) default '-' not null,
   password varchar2(30) default '-' not null,
   constraint unique_email unique ( email )
);

create table owner (
   owner_id varchar2(10) primary key,
   username varchar2(20) default '-' not null,
   id_type  varchar2(2) default 'CC' not null check ( id_type in ( 'CC',
                                                                  'TI',
                                                                  'CE' ) ),
   foreign key ( username )
      references account_information ( username )
         on delete cascade
);

create table client (
   client_id varchar2(10) primary key,
   username  varchar2(20) default '-' not null,
   id_type   varchar2(2) default 'CC' not null check ( id_type in ( 'CC',
                                                                  'TI',
                                                                  'CE' ) ),
   foreign key ( username )
      references account_information ( username )
         on delete cascade
);

create table property (
   property_id       varchar2(10) primary key,
   owner_id          varchar2(10) default '-' not null,
   num_rooms         number(2) default 1 not null check ( num_rooms > 1
      and num_rooms < 99 ),
   location          varchar2(100) default '-' not null,
   description       varchar2(500) default '-' not null,
   available         char(1) default 'N' not null check ( available in ( 'Y',
                                                                 'N' ) ),
   type              varchar2(11) default '-' not null check ( type in ( 'Casa',
                                                            'Apartamento' ) ),
   address           varchar2(30) default '-' not null,
   base_rent         number(7,2) default 0 not null check ( base_rent >= 0 ),
   availability_date date default trunc(sysdate) not null,
   discount          number(10,5) default 0 not null check ( discount >= 0 ),
   discount_type     varchar2(10) default 'PERCENTAGE' not null check ( discount_type in ( 'PERCENTAGE',
                                                                                       'VALUE' ) ),
   foreign key ( owner_id )
      references owner ( owner_id )
         on delete cascade,
   constraint unique_address unique ( address )
);

create table tenant (
   client_id   varchar2(10) not null,
   property_id varchar2(10) not null,
   start_date  date default trunc(sysdate) not null,
   end_date    date default trunc(sysdate) not null,
   primary key ( client_id,
                 start_date ),
   foreign key ( client_id )
      references client ( client_id )
         on delete cascade,
   foreign key ( property_id )
      references property ( property_id )
         on delete cascade
);

create table visit (
   property_id varchar2(10) not null,
   client_id   varchar2(10) not null,
   start_time  date default trunc(sysdate) not null,
   duration    number(6,2) default 0 not null check ( duration >= 0 ),
   end_time    date default trunc(sysdate) not null,
   primary key ( property_id,
                 client_id,
                 start_time ),
   foreign key ( property_id )
      references property ( property_id )
         on delete cascade,
   foreign key ( client_id )
      references client ( client_id )
         on delete cascade
);

create table service (
   service_name varchar2(50) primary key,
   person_value number(7,2) default 0 not null check ( person_value >= 0 )
);

create table payment (
   payment_id   varchar2(10) primary key,
   client_id    varchar2(10) default '-' not null,
   value        number(8,2) default 0 not null check ( value > 0 ),
   email        varchar2(30) default '-' not null,
   cash_used    char(1) default 'N' not null check ( cash_used in ( 'Y',
                                                                 'N' ) ),
   cash_value   number(8,2) default null check ( cash_value >= 0 ),
   payment_date date default trunc(sysdate) not null,
   contract_id  varchar2(10) default '-' not null,
   foreign key ( client_id )
      references client ( client_id )
         on delete cascade
);


create table card (
   payment_id       varchar2(10) primary key,
   card_number      varchar2(19) default '0-0-0-0' not null,
   card_owner       varchar2(60) default '-' not null,
   type             varchar2(10) default '-' not null check ( type in ( 'Visa',
                                                            'MasterCard' ) ),
   expiration_year  varchar2(2) default '0' not null,
   expiration_month varchar2(2) default '0' not null,
   foreign key ( payment_id )
      references payment ( payment_id )
         on delete cascade
);

create table coupon (
   coupon_number varchar2(10) primary key,
   payment_id    varchar2(10) default '-' not null,
   value         number(8,2) default 0 not null check ( value > 0 ),
   is_used       char(1) default 'N' not null check ( is_used in ( 'Y',
                                                             'N' ) ),
   foreign key ( payment_id )
      references payment ( payment_id )
);

create table waiting_list_position (
   clients_id     varchar2(10) primary key,
   property_id    varchar2(10) not null,
   property_order number(4) default 1 not null check ( property_order >= 1 ),
   foreign key ( property_id )
      references property ( property_id )
);

create table rent_solicitude (
   client_id        varchar2(10) primary key,
   property_id      varchar2(10) not null,
   start_date       date default trunc(sysdate) not null,
   end_date         date default trunc(sysdate) not null,
   preliminary_cost number(8,2) default 0 not null check ( preliminary_cost >= 0 ),
   foreign key ( property_id )
      references property ( property_id )
         on delete cascade,
   foreign key ( client_id )
      references client ( client_id )
         on delete cascade
);

create table contract (
   contract_id   number
      generated always as identity,
   client_id     varchar2(10) not null,
   property_id   varchar2(10) not null,
   tpv_per_month number(8,2) default 0 not null check ( tpv_per_month >= 0 ),
   start_date    date default trunc(sysdate) not null,
   end_date      date default trunc(sysdate) not null,
   primary key ( contract_id,
                 client_id ),
   constraint unique_propertyid unique ( property_id ),
   foreign key ( property_id )
      references property ( property_id )
         on delete cascade,
   foreign key ( client_id )
      references client ( client_id )
         on delete cascade
);

create table additional_service (
   client_id    varchar2(10) not null,
   service_name varchar2(50) not null,
   num_people   number(2) default 1 not null check ( num_people > 1
      and num_people < 99 ),
   value        number(7,2) default 0 not null check ( value >= 0 ),
   primary key ( client_id,
                 service_name ),
   foreign key ( client_id )
      references client ( client_id )
         on delete cascade,
   foreign key ( service_name )
      references service ( service_name )
         on delete cascade
);

create table additional_rates ( -- Tabla que incluye la informacion de tarifas adicionales como impuestos o cosas como la administración de las casas
   rate_name   varchar2(50) primary key,
   rate_value  number(7,2) not null check ( rate_value >= 0 ),
   unit        varchar2(10) default '%' not null check ( unit in ( '%' ) ),
   rate_type   varchar2(20) default '-' not null check ( rate_type in ( 'TAX',
                                                                      'COMMISSION' ) ),
   description varchar2(100) default '-' not null
);


create table control_changes (
   change_id   number
      generated always as identity
   primary key,
   table_name  varchar2(50),         -- Nombre de la tabla modificada (ej. 'Client', 'Property')
   record_id   varchar2(10),         -- ID del registro afectado (ej. client_id, property_id)
   action_type varchar2(10),         -- 'UPDATE', 'INSERT', 'DELETE'
   change_date date default sysdate, -- Fecha del cambio
   column_name varchar2(50),         -- Nombre del atributo modificado
   old_value   varchar2(500),
   new_value   varchar2(500)
);

create table notification (
   hour_date date default trunc(sysdate) not null,
   message   varchar2(500) default '-' not null,
   typology  varchar2(100) default '-' not null check ( typology in ( 'WAITING LIST',
                                                                     'FIRMED CONTRACT',
                                                                     'RENT SOLICITUDE',
                                                                     'SUCCESSFULL PAYMENT',
                                                                     'UPDATED PROPERTY' ) ),
   username  varchar2(20) default '-' not null,
   foreign key ( username )
      references account_information ( username )
         on delete cascade
)