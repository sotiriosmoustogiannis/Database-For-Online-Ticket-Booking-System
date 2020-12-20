     -- Table: public.ticketbuy

-- DROP TABLE public.ticketbuy;

CREATE TABLE public.ticketbuy
(
    ticketcode character varying(5) COLLATE pg_catalog."default" NOT NULL,
    typet character varying(30) COLLATE pg_catalog."default" NOT NULL,
    locate character varying(60) COLLATE pg_catalog."default" NOT NULL,
    price numeric(2,0) NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    category character varying(60) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ticketbuy_pkey PRIMARY KEY (ticketcode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ticketbuy
    OWNER to postgres;



     -- Table: public.customers

-- DROP TABLE public.customers;

CREATE TABLE public.customers
(
    custcode character varying(6) COLLATE pg_catalog."default" NOT NULL,
    afm numeric(6,0) NOT NULL,
    onepwn character varying(60) COLLATE pg_catalog."default" NOT NULL,
    phone numeric(10,0),
    email character varying(80) COLLATE pg_catalog."default" NOT NULL,
    age numeric(3,0),
    CONSTRAINT customers_pkey PRIMARY KEY (custcode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.customers
    OWNER to postgres;


     -- Table: public.cartnumber

-- DROP TABLE public.cartnumber;

CREATE TABLE public.cartnumber
(
    cartnum numeric(10,0) NOT NULL,
    custcode character varying(6) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT cartnumber_pkey PRIMARY KEY (cartnum),
    CONSTRAINT fkc1 FOREIGN KEY (custcode)
        REFERENCES public.customers (custcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.cartnumber
    OWNER to postgres;

-- Index: fki_fkc1

-- DROP INDEX public.fki_fkc1;

CREATE INDEX fki_fkc1
    ON public.cartnumber USING btree
    (custcode COLLATE pg_catalog."default")
    TABLESPACE pg_default;


     -- Table: public.company

-- DROP TABLE public.company;

CREATE TABLE public.company
(
    compcode character varying(5) COLLATE pg_catalog."default" NOT NULL,
    afm numeric(6,0) NOT NULL,
    compname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT company_pkey PRIMARY KEY (compcode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.company
    OWNER to postgres;


    -- Table: public.transactions

-- DROP TABLE public.transactions;

CREATE TABLE public.transactions
(
    transcode character varying(6) COLLATE pg_catalog."default" NOT NULL,
    custcode character varying(6) COLLATE pg_catalog."default" NOT NULL,
    ticketcode character varying(5) COLLATE pg_catalog."default" NOT NULL,
    compcode character varying(5) COLLATE pg_catalog."default" NOT NULL,
    datesale date NOT NULL,
    CONSTRAINT transactions_pkey PRIMARY KEY (transcode),
    CONSTRAINT fktr1 FOREIGN KEY (custcode)
        REFERENCES public.customers (custcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fktr2 FOREIGN KEY (ticketcode)
        REFERENCES public.ticketbuy (ticketcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fktr3 FOREIGN KEY (compcode)
        REFERENCES public.company (compcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.transactions
    OWNER to postgres;

-- Index: fki_fktr1

-- DROP INDEX public.fki_fktr1;

CREATE INDEX fki_fktr1
    ON public.transactions USING btree
    (custcode COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: fki_fktr2

-- DROP INDEX public.fki_fktr2;

CREATE INDEX fki_fktr2
    ON public.transactions USING btree
    (ticketcode COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: fki_fktr3

-- DROP INDEX public.fki_fktr3;

CREATE INDEX fki_fktr3
    ON public.transactions USING btree
    (compcode COLLATE pg_catalog."default")
    TABLESPACE pg_default;

	
	--TABLE DATA
	
insert into ticketbuy values ('t0001' , 'kwmwdia' , 'athens' , '12' , '2019-03-12' , '2019-04-12' , 'synaylia');
insert into ticketbuy values ('t0002' , 'drama' , 'athens' , '10' , '2019-03-15' , '2019-04-10' , 'synaylia');
insert into ticketbuy values ('t0003' , 'kwmwdia' , 'athens' , '8' , '2019-02-10' , '2019-02-12' , 'cinema');
insert into ticketbuy values ('t0004' , 'tragwdia' , 'thessalonikh' , '15' , '2019-03-20' , '2019-04-03' , 'theatro');
insert into ticketbuy values ('t0005' , 'drama' , 'athens' , '6' , '2019-01-12' , '2019-01-30' , 'theatro');
insert into ticketbuy values ('t0006' , 'drama' , 'thessalonikh' , '14' , '2019-01-15' , '2019-01-25' , 'cinema');

insert into customers values ('c00001' , '567432' , 'sotos mous' , '6943916690' , 'abc@iu.com' , '21');
insert into customers values ('c00002' , '128745' , 'anesths papan' , '6987345263' , 'fgrd@oi.com' , '19');
insert into customers values ('c00003' , '346587' , 'thimios kot' , '6080546376' , 'hgd@fr.com' , '20');
insert into customers values ('c00004' , '540098' , 'niki bot' , '6956328973' , 'hgf@ui.com' , '46');

insert into cartnumber values ('2040607012' , 'c00001');
insert into cartnumber values ('2540607012' , 'c00001');
insert into cartnumber values ('3040506012' , 'c00002');
insert into cartnumber values ('1020409054' , 'c00003');
insert into cartnumber values ('2309781232' , 'c00004');
insert into cartnumber values ('2309934232' , 'c00004');

insert into company values ('co001' , '360987' , 'universe');
insert into company values ('co002' , '360980' , 'blerian');

insert into transactions values ('tr0001' , 'c00001' , 't0001' , 'co002' , '2019-03-02');
insert into transactions values ('tr0002' , 'c00002' , 't0002' , 'co001' , '2019-03-03');
insert into transactions values ('tr0003' , 'c00001' , 't0002' , 'co001' , '2019-03-01');
insert into transactions values ('tr0004' , 'c00003' , 't0005' , 'co002' , '2019-01-10');
insert into transactions values ('tr0005' , 'c00001' , 't0003' , 'co002' , '2019-02-06');
insert into transactions values ('tr0006' , 'c00003' , 't0003' , 'co002' , '2019-02-03');
insert into transactions values ('tr0007' , 'c00003' , 't0004' , 'co001' , '2019-03-15');
insert into transactions values ('tr0008' , 'c00004' , 't0001' , 'co002' , '2019-03-10');
insert into transactions values ('tr0009' , 'c00001' , 't0002' , 'co002' , '2019-03-05');