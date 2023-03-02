--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-06-03 17:11:35

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
-- TOC entry 828 (class 1247 OID 16566)
-- Name: categ_zona; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.categ_zona AS ENUM (
    'ochi',
    'fata',
    'buze'
);


ALTER TYPE public.categ_zona OWNER TO postgres;

--
-- TOC entry 831 (class 1247 OID 16574)
-- Name: tipuri_produse; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipuri_produse AS ENUM (
    'palete de farduri',
    'creioane de ochi',
    'sprancene',
    'mascara',
    'fonduri de ten',
    'iluminatoare',
    'corectoare',
    'conturarea fetei',
    'blush',
    'pudra',
    'rujuri',
    'lip gloss',
    'balsamuri de buze',
    'creioane de buze'
);


ALTER TYPE public.tipuri_produse OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 16604)
-- Name: machiaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machiaje (
    id integer NOT NULL,
    nume character varying(50) NOT NULL,
    descriere text,
    pret numeric(8,2) NOT NULL,
    cantitate integer NOT NULL,
    tip_culori character varying(50) NOT NULL,
    tip_produs public.tipuri_produse DEFAULT 'palete de farduri'::public.tipuri_produse,
    nr_bucati integer NOT NULL,
    categorie public.categ_zona DEFAULT 'ochi'::public.categ_zona,
    culori character varying[],
    produs_vegan boolean DEFAULT true NOT NULL,
    imagine character varying(300),
    data_adaugare timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT machiaje_cantitate_check CHECK ((cantitate >= 0)),
    CONSTRAINT machiaje_nr_bucati_check CHECK ((nr_bucati >= 0))
);


ALTER TABLE public.machiaje OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16603)
-- Name: machiaje_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.machiaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.machiaje_id_seq OWNER TO postgres;

--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 211
-- Name: machiaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.machiaje_id_seq OWNED BY public.machiaje.id;


--
-- TOC entry 210 (class 1259 OID 16558)
-- Name: tabel_test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabel_test (
    id integer NOT NULL,
    nume character varying(100) NOT NULL,
    pret integer DEFAULT 100 NOT NULL
);


ALTER TABLE public.tabel_test OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16557)
-- Name: tabel_test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tabel_test ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tabel_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3176 (class 2604 OID 16607)
-- Name: machiaje id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machiaje ALTER COLUMN id SET DEFAULT nextval('public.machiaje_id_seq'::regclass);


--
-- TOC entry 3331 (class 0 OID 16604)
-- Dependencies: 212
-- Data for Name: machiaje; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (1, 'Paleta de machiaj Colourful Palette 1', 'Paleta de machiaj in culori naturale, calde.', 50.00, 20, 'calde', 'palete de farduri', 500, 'ochi', '{nud,maro,negru,alb}', true, 'paleta1.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (2, 'Paleta de machiaj Colourful Palette 2', 'Paleta de machiaj in culori diverse, curcubeu.', 100.00, 50, 'mixte', 'palete de farduri', 400, 'ochi', '{nud,maro,negru,alb,rosu,albastru,verde,roz,mov,galben}', true, 'paleta2.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (3, 'Paleta de machiaj Colourful Palette 3', 'Paleta de machiaj in culori naturale, reci.', 50.00, 20, 'reci', 'palete de farduri', 450, 'ochi', '{nud,maro,negru,alb,roz}', true, 'paleta3.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (4, 'Creion de ochi Colourful Eyes', 'Creion de ochi de culoare albastru deschis.', 10.00, 2, 'reci', 'creioane de ochi', 100, 'ochi', '{albastru,negru}', false, 'creion_ochi.png', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (5, 'Creion pentru sprancene Colourful Brows', 'Creion pentru sprancene, perfect pentru toate tipurile.', 30.00, 2, 'reci', 'sprancene', 100, 'ochi', '{maro,negru,nud}', false, 'creion_sprancene.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (6, 'Mascara Colourful Lash 1', 'Mascara pentru volum.', 20.00, 10, 'reci', 'mascara', 540, 'ochi', '{maro,negru}', true, 'rimel1.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (7, 'Mascara Colourful Lash 2', 'Mascara pentru alungire.', 20.00, 10, 'reci', 'mascara', 440, 'ochi', '{maro,negru}', true, 'rimel2.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (8, 'Mascara Colourful Lash 3', 'Mascara cu efect de gene false.', 20.00, 10, 'reci', 'mascara', 400, 'ochi', '{maro,negru}', true, 'rimel3.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (9, 'Fond de ten Colourful Face', 'Fond de ten cu efect matifiant.', 60.00, 30, 'calde', 'fonduri de ten', 660, 'fata', '{maro,nud,alb,roz}', true, 'ten.png', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (10, 'Iluminator Colourful Glow', 'Iluminator perfect pentru toate tipurile de ten.', 70.00, 25, 'reci', 'iluminatoare', 300, 'fata', '{alb,nud,roz}', true, 'iluminator.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (11, 'Corector Colourful Conceal', 'Corector pentru acoperirea imperfectiunilor.', 55.00, 45, 'mixte', 'corectoare', 500, 'fata', '{alb,nud,roz,verde,maro}', true, 'corector.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (12, 'Perle de contur Colourful Bronzer', 'Perle de contur, cu efect brozant.', 65.00, 35, 'calde', 'conturarea fetei', 350, 'fata', '{nud,roz,maro}', true, 'Perle de contur.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (13, 'Blush Colourful Cheeks', 'Blush ce ofera dimensiune fetei, cu efect natural.', 30.00, 20, 'calde', 'blush', 400, 'fata', '{nud,roz,rosu}', true, 'blush.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (14, 'Pudra Colourful Finish', 'Pudra ce reduce efectul de sebum.', 50.00, 45, 'calde', 'pudra', 555, 'fata', '{nud,roz,alb}', true, 'pudra.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (15, 'Ruj Colourful Nude', 'Ruj nude hidratant.', 40.00, 35, 'calde', 'rujuri', 600, 'buze', '{nud,roz}', false, 'ruj1.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (16, 'Ruj Colourful Matte', 'Ruj mat, rezistent la transfer.', 40.00, 35, 'calde', 'rujuri', 500, 'buze', '{nud,roz}', false, 'ruj2.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (17, 'Ruj Colourful Intense Red', 'Ruj rosu intens, pigmentat.', 40.00, 35, 'calde', 'rujuri', 500, 'buze', '{nud,roz,rosu}', false, 'ruj3.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (18, 'Lip Gloss Colourful Shine', 'Lip gloss cu stralucire intensa.', 30.00, 30, 'reci', 'lip gloss', 300, 'buze', '{nud,roz,rosu,alb}', true, 'gloss.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (19, 'Balsam de buze Colourful Moisturizer', 'Balsam de buze foarte hidratant.', 15.00, 30, 'reci', 'balsamuri de buze', 350, 'buze', '{nud,roz,alb}', true, 'balsam.jpg', '2022-05-20 14:45:53.303532');
INSERT INTO public.machiaje (id, nume, descriere, pret, cantitate, tip_culori, tip_produs, nr_bucati, categorie, culori, produs_vegan, imagine, data_adaugare) VALUES (20, 'Creion de buze Colourful Lips', 'Creion de buze in diferite nuante.', 15.00, 20, 'calde', 'creioane de buze', 400, 'buze', '{nud,roz,rosu}', true, 'creion_buze.jpg', '2022-05-20 14:45:53.303532');


--
-- TOC entry 3329 (class 0 OID 16558)
-- Dependencies: 210
-- Data for Name: tabel_test; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tabel_test (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (1, 'adbc', 100);
INSERT INTO public.tabel_test (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (2, 'def', 17);
INSERT INTO public.tabel_test (id, nume, pret) OVERRIDING SYSTEM VALUE VALUES (3, 'xyz', 100);


--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 211
-- Name: machiaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.machiaje_id_seq', 21, true);


--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 209
-- Name: tabel_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tabel_test_id_seq', 3, true);


--
-- TOC entry 3186 (class 2606 OID 16619)
-- Name: machiaje machiaje_nume_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machiaje
    ADD CONSTRAINT machiaje_nume_key UNIQUE (nume);


--
-- TOC entry 3188 (class 2606 OID 16617)
-- Name: machiaje machiaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machiaje
    ADD CONSTRAINT machiaje_pkey PRIMARY KEY (id);


--
-- TOC entry 3184 (class 2606 OID 16563)
-- Name: tabel_test tabel_test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabel_test
    ADD CONSTRAINT tabel_test_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE machiaje; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.machiaje TO tudoroiu_simona;


--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 211
-- Name: SEQUENCE machiaje_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.machiaje_id_seq TO tudoroiu_simona;


--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE tabel_test; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tabel_test TO tudoroiu_simona;


--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 209
-- Name: SEQUENCE tabel_test_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tabel_test_id_seq TO tudoroiu_simona;


-- Completed on 2022-06-03 17:11:36

--
-- PostgreSQL database dump complete
--

