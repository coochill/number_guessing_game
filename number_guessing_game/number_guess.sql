--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE guess;
--
-- Name: guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE guess OWNER TO freecodecamp;

\connect guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: guess; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guess (
    player_id integer NOT NULL,
    player_name character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_games integer
);


ALTER TABLE public.guess OWNER TO freecodecamp;

--
-- Name: guess_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guess_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guess_player_id_seq OWNER TO freecodecamp;

--
-- Name: guess_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guess_player_id_seq OWNED BY public.guess.player_id;


--
-- Name: guess player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess ALTER COLUMN player_id SET DEFAULT nextval('public.guess_player_id_seq'::regclass);


--
-- Data for Name: guess; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guess VALUES (40, '', 0, 0);
INSERT INTO public.guess VALUES (43, 'user_1735797592109', 2, 1);
INSERT INTO public.guess VALUES (42, 'user_1735797592110', 5, 1);
INSERT INTO public.guess VALUES (45, 'user_1735797724399', 2, 1);
INSERT INTO public.guess VALUES (44, 'user_1735797724400', 5, 1);
INSERT INTO public.guess VALUES (41, 'jojo', 4, 1);
INSERT INTO public.guess VALUES (47, 'user_1735797923161', 2, 450);
INSERT INTO public.guess VALUES (46, 'user_1735797923162', 5, 359);
INSERT INTO public.guess VALUES (49, 'user_1735798002363', 2, 167);
INSERT INTO public.guess VALUES (48, 'user_1735798002364', 5, 259);
INSERT INTO public.guess VALUES (51, 'user_1735798816867', 2, 91);
INSERT INTO public.guess VALUES (50, 'user_1735798816868', 5, 29);


--
-- Name: guess_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guess_player_id_seq', 51, true);


--
-- Name: guess guess_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess
    ADD CONSTRAINT guess_pkey PRIMARY KEY (player_id);


--
-- PostgreSQL database dump complete
--

