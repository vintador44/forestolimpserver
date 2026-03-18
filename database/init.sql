-- Создание расширения PostGIS (раскомментируйте, если нужно)
-- CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;

-- Таблица SequelizeMeta
CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);

ALTER TABLE public."SequelizeMeta" OWNER TO vintador44;

-- Таблица categories
CREATE TABLE public.categories (
    id integer NOT NULL,
    "CategoryName" character varying(255) NOT NULL
);

ALTER TABLE public.categories OWNER TO vintador44;

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.categories_id_seq OWNER TO vintador44;
ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;

-- Таблица dots
CREATE TABLE public.dots (
    "ID" integer NOT NULL,
    "ThisDotCoordinates" public.geography NOT NULL,
    "NextDotCoordinates" public.geography,
    "RoadID" integer NOT NULL
);

ALTER TABLE public.dots OWNER TO vintador44;

CREATE SEQUENCE public."dots_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."dots_ID_seq" OWNER TO vintador44;
ALTER SEQUENCE public."dots_ID_seq" OWNED BY public.dots."ID";

-- Таблица locations
CREATE TABLE public.locations (
    "ID" integer NOT NULL,
    "LocationName" character varying(100) NOT NULL,
    "Coordinates" public.geography NOT NULL,
    "Description" character varying(500) NOT NULL,
    "Categories" character varying(150) NOT NULL
);

ALTER TABLE public.locations OWNER TO vintador44;

CREATE SEQUENCE public."locations_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."locations_ID_seq" OWNER TO vintador44;
ALTER SEQUENCE public."locations_ID_seq" OWNED BY public.locations."ID";

-- Таблица photos
CREATE TABLE public.photos (
    "ID" integer NOT NULL,
    "UserID" integer NOT NULL,
    "LocationID" integer NOT NULL,
    "PhotoBYTEA" bytea NOT NULL
);

ALTER TABLE public.photos OWNER TO vintador44;

CREATE SEQUENCE public."photos_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."photos_ID_seq" OWNER TO vintador44;
ALTER SEQUENCE public."photos_ID_seq" OWNED BY public.photos."ID";

-- Таблица roads
CREATE TABLE public.roads (
    "ID" integer NOT NULL,
    "Description" character varying(500) NOT NULL,
    "UserID" integer NOT NULL,
    "StartDateTime" timestamp with time zone NOT NULL,
    "EndDateTime" timestamp with time zone NOT NULL
);

ALTER TABLE public.roads OWNER TO vintador44;

CREATE SEQUENCE public."roads_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."roads_ID_seq" OWNER TO vintador44;
ALTER SEQUENCE public."roads_ID_seq" OWNED BY public.roads."ID";

-- Таблица user (обратите внимание на кавычки, так как user – зарезервированное слово)
CREATE TABLE public."user" (
    "ID" integer NOT NULL,
    "Password" character varying(60) NOT NULL,
    "Email" character varying(50) NOT NULL,
    "FIO" character varying(60) NOT NULL
);

ALTER TABLE public."user" OWNER TO vintador44;

CREATE SEQUENCE public."user_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."user_ID_seq" OWNER TO vintador44;
ALTER SEQUENCE public."user_ID_seq" OWNED BY public."user"."ID";

-- Таблица users
CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE public.users OWNER TO vintador44;

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.users_id_seq OWNER TO vintador44;
ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;

-- Таблица votes
CREATE TABLE public.votes (
    "ID" integer NOT NULL,
    "UserID" integer NOT NULL,
    "RoadID" integer NOT NULL,
    "Vote" integer NOT NULL
);

ALTER TABLE public.votes OWNER TO vintador44;

CREATE SEQUENCE public."votes_ID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."votes_ID_seq" OWNER TO vintador44;
ALTER SEQUENCE public."votes_ID_seq" OWNED BY public.votes."ID";

-- Настройка значений по умолчанию для последовательностей
ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
ALTER TABLE ONLY public.dots ALTER COLUMN "ID" SET DEFAULT nextval('public."dots_ID_seq"'::regclass);
ALTER TABLE ONLY public.locations ALTER COLUMN "ID" SET DEFAULT nextval('public."locations_ID_seq"'::regclass);
ALTER TABLE ONLY public.photos ALTER COLUMN "ID" SET DEFAULT nextval('public."photos_ID_seq"'::regclass);
ALTER TABLE ONLY public.roads ALTER COLUMN "ID" SET DEFAULT nextval('public."roads_ID_seq"'::regclass);
ALTER TABLE ONLY public."user" ALTER COLUMN "ID" SET DEFAULT nextval('public."user_ID_seq"'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.votes ALTER COLUMN "ID" SET DEFAULT nextval('public."votes_ID_seq"'::regclass);

-- Вставка начальных данных для categories
INSERT INTO public.categories ("CategoryName") VALUES
    ('Лес'),
    ('Озеро'),
    ('Дворец'),
    ('Водопады'),
    ('Пещеры'),
    ('Водохранилища'),
    ('Вулканы'),
    ('Горы'),
    ('Реки'),
    ('Каньоны'),
    ('Карьеры'),
    ('Остров'),
    ('Поле'),
    ('Деревня'),
    ('Ущелья'),
    ('Святые места'),
    ('Тропы'),
    ('Пруды'),
    ('Пляжи'),
    ('Мистические места');

-- Установка значения последовательности для categories (после вставки)
SELECT pg_catalog.setval('public.categories_id_seq', 20, true);