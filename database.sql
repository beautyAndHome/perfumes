--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ordine_prodotto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordine_prodotto (
    ordine_id integer,
    prodotto_id integer,
    quantita integer
);


ALTER TABLE public.ordine_prodotto OWNER TO postgres;

--
-- Name: ordini; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordini (
    id integer NOT NULL,
    nome character varying(100),
    cognome character varying(100),
    indirizzo character varying(255),
    cap character varying(10),
    provincia character varying(50),
    comune character varying(100),
    telefono character varying(20),
    email character varying(100),
    data_ordine date,
    totale numeric(10,2),
    metodo_pagamento character varying
);


ALTER TABLE public.ordini OWNER TO postgres;

--
-- Name: ordini_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordini_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ordini_id_seq OWNER TO postgres;

--
-- Name: ordini_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordini_id_seq OWNED BY public.ordini.id;


--
-- Name: prodotti; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prodotti (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    descrizione text,
    prezzo numeric(10,2) NOT NULL,
    ml integer NOT NULL,
    categoria character varying(100),
    immagine character varying(255)
);


ALTER TABLE public.prodotti OWNER TO postgres;

--
-- Name: prodotti_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prodotti_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prodotti_id_seq OWNER TO postgres;

--
-- Name: prodotti_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prodotti_id_seq OWNED BY public.prodotti.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    enabled boolean DEFAULT true,
    roles character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vista_ordini_completi; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_ordini_completi AS
 SELECT o.id,
    o.nome,
    o.cognome,
    o.indirizzo,
    o.cap,
    o.provincia,
    o.comune,
    o.telefono,
    o.email,
    o.data_ordine,
    o.totale,
    op.ordine_id,
    op.prodotto_id,
    op.quantita
   FROM (public.ordini o
     LEFT JOIN public.ordine_prodotto op ON ((o.id = op.ordine_id)));


ALTER VIEW public.vista_ordini_completi OWNER TO postgres;

--
-- Name: ordini id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordini ALTER COLUMN id SET DEFAULT nextval('public.ordini_id_seq'::regclass);


--
-- Name: prodotti id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prodotti ALTER COLUMN id SET DEFAULT nextval('public.prodotti_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ordine_prodotto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordine_prodotto (ordine_id, prodotto_id, quantita) FROM stdin;
\.


--
-- Data for Name: ordini; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordini (id, nome, cognome, indirizzo, cap, provincia, comune, telefono, email, data_ordine, totale, metodo_pagamento) FROM stdin;
\.


--
-- Data for Name: prodotti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prodotti (id, nome, descrizione, prezzo, ml, categoria, immagine) FROM stdin;
5	Dolce&Gabbana The One	L’eau de parfum Dolce & Gabbana The One è semplicemente 💖🌟e unica nel suo genere! ✨💐 Combina note fruttate 🍊🍒 e contemporanee con una palette di fiori bianchi classici 🌼💐. Questo contrasto tra modernità e tradizione è proprio quello che rende questo profumo così straordinario! 🌈💪 Ogni donna è unica al mondo, proprio come questo profumo: The One... 💃🌟	59.99	100	Fragranze femminili	https://i.postimg.cc/Fz2qgVTX/D-GThe-One.jpg
7	Creed Silver Mountain Water	 Creed Silver Mountain Water ✨✨✨ si distingue tra i profumi di nicchia Creed per la dualità di una piramide olfattiva che unisce odori fortemente legati alla terra 🌳🌱, come il sandalo 🌿 e il mandarino 🍊, ad accenni acquatici 💦💧 che sorprendono per eleganza 💃 e persistenza.	79.99	100	Fragranze maschili	https://i.postimg.cc/j2Z6RxJg/Creed-Silver-Mountain-Water.jpg
8	Creed Viking	Viking è una sferzata carica di limone e bergamotto, acuita dall’anima pungente del pepe rosa, che fa percepire fin dalle prime note una scossa di energia. 💪🍋🌿 Un territorio sconosciuto, in bilico tra un senso di freddo glaciale e di calore rovente, è evocato dal soffio della menta piperita e dalla profondità delle spezie. ❄️🔥🌶️ La presenza floreale della rosa bulgara conferisce al jus equilibrio e armonia portandoci alla scoperta delle note di fondo di sandalo, vetiver e patchouli che progressivamente e in modo inaspettato emergono grandiose e potenti. 🌹🌳💥 Altrettanto inattesa la lavanda, intensa e aromatica, a siglare la chiusura della composizione. 🌿💜 Non è un finale, ma una tensione all’apertura… una meta raggiunta rappresenta il punto di partenza per la prossima conquista. 🌅✨🏆	34.99	100	Fragranze maschili	https://i.postimg.cc/vHGMjQhR/Creed-Viking.jpg
1	Versace Eros Flame	🔥💚 Una fragranza che colpisce dritto al cuore 💘💥, che si fa portavoce di un importante messaggio alle nuove generazioni sulla dignità dell'amore e sul potere della diversità. 💪🌈💘 Versace Eros Flame è la fragranza per un uomo 💪❤️ forte, passionale e sicuro di sé, che vive le proprie emozioni sulla pelle. 🥰💪 Una fragranza persistente e avvolgente, che riesce ad essere allo stesso tempo virile, un'ode alla passione e un inno alla voluttà dei sensi. 😍🔥🔥🔥💚 Una fragranza che colpisce dritto al cuore 💘💥, che si fa portavoce di un importante messaggio alle nuove generazioni sulla dignità dell'amore e sul potere della diversità. 💪🌈💘 Versace Eros Flame è la fragranza per un uomo 💪❤️ forte, passionale e sicuro di sé, che vive le proprie emozioni sulla pelle. 🥰💪 Una fragranza persistente e avvolgente, che riesce ad essere allo stesso tempo virile, un'ode alla passione e un inno alla voluttà dei sensi. 😍🔥🔥	49.99	100	Fragranze maschili	https://i.postimg.cc/CLCCh4bB/Versace-Eros-Flame.jpg
2	Versace Eros Eau De Parfum	Eros è la fragranza che traduce il maschile in sublime attraverso un’aura luminosa dalla freschezza intensa, vibrante e straordinaria 😍😎💫, ottenuta grazie alla combinazione di foglie di menta 🌿🌿 con zest di limone italiano 🍋🇮🇹 e mela verde 🍏🍏.	59.99	100	Fragranze maschili	https://i.postimg.cc/2yL1qCq8/Versace-Eros-Eau-De-Profum.jpg
9	Creed Millesime Imperial	🌿🍊💧 Fresco ed elegante, Millesime Imperial è un profumo Creed creato per interpretare l’uomo moderno, con note agrumate e legnose, rinfrescate da accenni ozonati. Una miscela esaltante di legni profumati, muschio e iris con note di testa esuberanti scintillanti ✨💼❤️️. La base è calda e ricca di strati di ambra grigia 🌟🔥.	64.99	100	Fragranze maschili	https://i.postimg.cc/VvVdtsLW/image.png
3	Dolce&Gabbana K 	K by Dolce & Gabbana di Dolce&Gabbana è una fragranza ✨ del gruppo Legnoso Aromatico da uomo 🧔. K by Dolce & Gabbana è stato lanciato sul mercato 😎 nel 2019 📅. K by Dolce & Gabbana è stato creato da Daphné Bugey e Nathalie Lorson 👩‍🔬👩‍🔬. Le note di testa sono Bacche di Ginepro, Agrumi 🍊🍋, Arancia Rossa e Limone di Sicilia 🍊🇮🇹; le note di cuore sono Pimento, Lavanda, Salvia Sclarea e Geranio 🌶️🌿; le note di base sono Vetiver, Legno di Cedro e Patchouli 🌿🌳. 😍👌	39.99	100	Fragranze maschili	https://i.postimg.cc/5N0VSspL/Dolce-Gabbana-K-Eau-De-Toilette.jpg
4	Dolce&Gabbana Q	Q by Dolce&Gabbana Eau de Parfum: una composizione per una donna magnetica e passionale. 😍	29.99	100	Fragranze femminili	https://i.postimg.cc/MX2ZLR91/Dolce-Gabbana-Q.jpg
13	Louis Vuitton Ombre Nomade	Ombre Nomade di Louis Vuitton è una fragranza del gruppo Ambrato Legnoso unisex. 🌟	89.99	100	Fragranze unisex	https://i.postimg.cc/CKndqnRP/image.png
11	Creed Aventus for Him	🍏Creed Aventus uomo, nato nel 2010 dal Maestro Olivier Creed in collaborazione con il figlio Erwin, può definirsi oggi il profumo di nicchia ⭐️🔝for him per eccellenza. La fragranza è contraddistinta da un bouquet complesso e seducente, con note di testa di 🍇 ribes nero, 🍊 bergamotto calabrese, 🍎 mela e l'irrinunciabile 🍍. Sulle note di cuore si adagiano, invece, sentori di 🌸 gelsomino, di 🌳 betulla, di bacche di ginepro e dell'esotico 🍂 patchouli, per poi lasciare spazio alle note di fondo morbide e voluttuose di musk, muschio di quercia, ambra grigia e vaniglia. ✨🌺 😍💫	69.99	100	Fragranze maschili	https://i.postimg.cc/7h2fg8Gv/image.png
12	Baccarat Rouge 540	🌸Note di testa: 🌼Gelsomino 🌺e 🌿zafferano	54.99	100	Fragranze unisex	https://i.postimg.cc/7ZyKcSk7/image.png
6	Dolce&Gabbana Light Blue	Lascia che il tuo corpo e la tua mente siano inondati di ☀️ raggi caldi. Al primo fiuto dell’eau de toilette Dolce & Gabbana Light Blue 😍😍, ti ritroverai immediatamente sulle ☀️spiagge siciliane piene di 🌬️ brezza fresca e ☀️ sabbia calda. Puoi vedere chiaramente la promessa di una scintillante notte d’estate. Uno degli ingredienti principali dell’eau de toilette è il cedro siciliano, il cui aroma pervade l’intera composizione fragrante. All’inizio, è integrato dalle note scintillanti di 🍏 mela e campanula delicata. Nel cuore della fragranza c’è un bouquet di gelsomino decadente 🌺 e delicata rosa bianca, rivitalizzata dalla freschezza del 🎋 bambù. Nel 🌱 fondo, note di 🍋 legno di limone aromatico si intrecciano con il muschio animale 🐾e un sensuale accordo ambrato. ✨✨	0.01	100	Fragranze maschili	https://i.postimg.cc/fbt8590w/D-GLight-Blue.jpg
10	Creed Aventus for Her	In Aventus For Her 🍎🍋 note accattivanti di mela, bergamotto e limone annunciano una bellezza delicata 🌹💜 data dall’intreccio tra rosa e violetta. La scia di rosa ci conduce fino al fondo della piramide olfattiva 🌸🍃 dove si unisce a fiori di lillà e ylang-ylang carnali e sensuali. Un’audace determinazione è espressa dal carattere balsamico, resinoso e speziato dello storace, dalla fierezza del legno di sandalo e dal potere seducente dell’ambra 💪💥😍	44.99	100	Fragranze femminili	https://i.postimg.cc/SNVpD1WH/image.png
14	Chanel N°5	N°5, l'essenza stessa della femminilità. Un bouquet fiorito-aldeidato, sublimato in un flacone iconico dalle linee minimaliste. Un profumo mitico e intramontabile. 🌹🌟	49.90	100	Fragranze femminili	https://i.postimg.cc/BQ8WsTkV/image.png
15	Chanel Chance	✨🌼 Chanel Chance eau de toilette è come un'armonia dorata, denso e dolce, un incanto per tutti con la sua freschezza e composizione delicata. 💛✨ Questa fragranza universale è progettata per le donne giovani, attive, promettenti e libere. Non sarà invadente in ufficio e non "svanirà" nemmeno nella festa affollata! 🌟👩‍💼🎉	50.00	100	Fragranze femminili	https://i.postimg.cc/1z32CDGB/image.png
16	Chanel Bleu De Chanel	🌿✨ L'elogio della libertà si traduce in un aromatico-boschivo dalla firma seducente con BLEU DE CHANEL Eau de Parfum. Un'essenza intramontabile racchiusa in un flacone di un blu profondo e misterioso, che promette un viaggio olfattivo avvincente. 💙🌌	50.00	100	Fragranze maschili	https://i.postimg.cc/J4QpfG42/image.png
17	Nasomatto Narcotic Venus	🌺🌸 Narcotic Venus di Nasomatto è come un viaggio olfattivo in un giardino fiorito da sogno! 💫 Questa fragranza floreale da donna è un'esplosione di sensazioni, dove il giglio, la tuberosa e il gelsomino si fondono in una sinfonia fragrante. 🌼✨ Gli aromi floreali avvolgono i sensi come petali delicati, creando un'esperienza olfattiva unica e avvolgente. 🌈👃	50.00	100	Fragranze femminili	https://i.postimg.cc/FKS3QBVH/image.png
22	Dior Hypnotic Poison	Non puoi scegliere di indossare Hypnotic Poison👃👄💣, ma solo di lasciarti indossare💫 . L’eau de toilette Hypnotic Poison è una fragranza magnetica🌪️🌡️🔥 e orientale in cui un inebriante profumo vanigliato🍦 si mischia a un accordo di mandorla🍮💋😍 e gelsomino🌸🌼🌺. Una fragranza femminile dal carattere terribilmente seducente🔥💃.	50.00	100	Fragranze femminili	https://i.postimg.cc/0rgrZ8hG/image.png
24	Dior Sauvage	Sauvage è l'Eau de Parfum by DIOR. Ideato nel 2018 dal naso di Francois Demachy, è un profumo del gruppo Orientale Fougère per l'uomo. La fragranza si apre con le note di testa a base di Bergamotto🌿🌿🍊🍊 , proseguendo con un cuore di Noce Moscata, Anice Stellato, Lavanda e Pepe di Sichuan. Il fondo si chiude con le note a base di Vaniglia🍦🍦 e Ambroxan, per un profumo travolgente💥💥 ed irresistibile❤️❤️.	50.00	100	Fragranze maschili	https://i.postimg.cc/fyvT7xjs/image.png
20	Tom Ford Lost Cherry	Lost Cherry di Tom Ford è un profumo delizioso e seducente. Le note fruttate di ciliegie 🍒💋 creano un cocktail inebriante con un liquore dolce e viscoso 🍹🔥, mentre una calda sfumatura di mandorle dolcemente ti conduce al cuore della composizione dove ad aspettarti c'è la reale rosa turca 🌸🌹. Un ricco sillage orientale con eleganti sfumature legnose di vetiver, legno di sandalo e cedro bianco 🌿🌳. Questo profumo lascia una scia persistente e affascinante 💫✨, aggiungendo un tocco di glamour e mistero 🎩🌹.	50.00	100	Fragranze unisex	https://i.postimg.cc/13r4c1B6/image.png
23	Dior Bois D'Argent	Bois d’Argent di Christian Dior è una raffinata fragranza unisex, che fa parte del gruppo Legnoso Chypre dell’iconica Maison. Il profumo, ideato dal fine naso di Annick Menardo, è presente sul mercato dal 2004, continuando ancora a stupire senza mai stancare. Dior Bois d’Argent è un elogio al new look e alle passioni del fondatore della maison,🎁💝 un’essenza che incarna una sensualità elegante🎩🌟 , sublime✨, che si posa sulla pelle come velluto🪶💫 .	50.00	100	Fragranze unisex	https://i.postimg.cc/hGGxXGnh/image.png
19	Tom Ford Black Orchid	🖤✨ Black Orchid Eau de Parfum di Tom Ford è come un'incantesimo avvolgente, un'esperienza olfattiva sofisticata e sensuale. 🌺 I ricchi accordi tenebrosi dell'orchidea nera catturano l'immaginazione, mentre le esclusive spezie si intrecciano come una danza misteriosa. 🍄 Il tartufo nero aggiunge un tocco di lusso decadente, mentre il ribes nero 🍇🍸aggiunge un'esplosione fruttata. Il cuore orientale è un abbraccio avvolgente, un mistero svelato solo da ricche note misteriose. 🌌💖 Sperimenta l'essenza dell'eleganza e della seduzione in ogni spruzzo. ✨🔮	50.00	100	Fragranze unisex	https://i.postimg.cc/HnFTHB2T/image.png
21	Tom Ford Tobacco Vanille	Un profumo nato dall’affetto che Tom ford nutre per Londra💼🌹 e che ricorda le atmosfere odorose di spezie dei suoi club riservati ai gentlemen🎩🥃.\r\nLo stilista rivisita un genere di fragranza classico arricchendolo con accordi di una cremosa fava tonka✨, vaniglia🍦, cacao🍫 e frutta disidratata🍊 abbinati a resina di legni dolci🪵 per un effetto moderno🔥, opulento🌟, e quasi inebriante💥, assolutamente maschile, salvo che sia indossato da una donna🌸💁‍♀️ .	50.00	100	Fragranze unisex	https://i.postimg.cc/7PnckBK9/image.png
18	Nasomatto Black Afgano	Black Afgano Nasomatto è una fusione avvolgente di cannabis🌿💨 , note verdi e resine, arricchita da un'esplosione di note legnose🪵, caffè☕, tabacco🍁, incenso e oud. 🌲✨ Questa sinfonia di aromi crea un profumo forte, provocatorio e ribelle, che si distingue tra le fragranze trasmettendo un'idea audace di trasgressione. 🌟🖤\r\nNasomatto è più di una casa di profumi, è un'arte non convenzionale che sfida le convenzioni della profumeria di lusso. 🎨🚫 Aromi forti, note persistenti e fumose trasformano questo extrait de parfum in un viaggio olfattivo unico. Acquistare Black Afgano Nasomatto non è solo comprare un profumo, è simboleggiare la tua uscita dagli schemi della profumeria tradizionale. 🚀👃✨ Esplora il lato audace dell'olfatto e abbraccia l'essenza della ribellione aromatica! 🌌💥👊	50.00	100	Fragranze unisex	https://i.postimg.cc/L601gpys/image.png
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, enabled, roles) FROM stdin;
\.


--
-- Name: ordini_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordini_id_seq', 45, true);


--
-- Name: prodotti_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prodotti_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: ordini ordini_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordini
    ADD CONSTRAINT ordini_pkey PRIMARY KEY (id);


--
-- Name: prodotti prodotti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prodotti
    ADD CONSTRAINT prodotti_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: ordine_prodotto dettagli_ordine_ordine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordine_prodotto
    ADD CONSTRAINT dettagli_ordine_ordine_id_fkey FOREIGN KEY (ordine_id) REFERENCES public.ordini(id);


--
-- Name: ordine_prodotto dettagli_ordine_prodotto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordine_prodotto
    ADD CONSTRAINT dettagli_ordine_prodotto_id_fkey FOREIGN KEY (prodotto_id) REFERENCES public.prodotti(id);


--
-- PostgreSQL database dump complete
--

